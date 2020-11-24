import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_image/src/utils/cached_network_file.dart';

/// Storage abstraction around [CachedNetworkFile] to download cached files
/// for [FirebaseImageProvider].
class FirebaseImageStorage {
  const FirebaseImageStorage._();

  static const _kPhotoMaxSize = 5000000; // bytes
  static final _defaultCache = CachedNetworkFile(key: 'storage/firebase_images');

  /// Single instance of [FirebaseImageStorage].
  static const instance = FirebaseImageStorage._();
  static FirebaseStorage get _bucket => FirebaseStorage(storageBucket: FirebaseImage.storageBucket);

  // Do not access this field directly; use [_httpClient] instead.
  // We set `autoUncompress` to false to ensure that we can trust the value of
  // the `Content-Length` HTTP header. We automatically uncompress the content
  // in our call to [consolidateHttpClientResponseBytes].
  //
  // NOTE: Copy pasted from flutters [NetworkImage] code.
  static final _sharedHttpClient = HttpClient()..autoUncompress = false;

  static HttpClient get _httpClient {
    HttpClient client = _sharedHttpClient;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) client = debugNetworkImageHttpClientProvider();
      return true;
    }());
    return client;
  }

  /// Attempts to download and cache a file from the `url`.
  Future<Uint8List> downloadNetworkFile({
    @required String url,
    StreamController<ImageChunkEvent> chunkEvents,
    Map<String, String> headers,
    CachedNetworkFile cache,
  }) async {
    assert(url != null);

    final selectedCache = cache ?? _defaultCache;
    final resolved = Uri.base.resolve(url);
    final cachedFile = await selectedCache.getFileFromCache(url);
    final isOld = cachedFile?.validTill?.isBefore(DateTime.now());

    if (isOld != false) {
      try {
        final request = await _httpClient.getUrl(resolved);

        headers?.forEach((name, value) => request.headers.add(name, value));
        final response = await request.close();

        if (response.statusCode != HttpStatus.ok) {
          // The network may be only temporarily unavailable, or the file will be
          // added on the server later. Avoid having future calls to resolve
          // fail to check the network again.
          throw NetworkImageLoadException(statusCode: response.statusCode, uri: resolved);
        }

        final bytes = await consolidateHttpClientResponseBytes(
          response,
          onBytesReceived: (cumulative, total) => chunkEvents?.add(ImageChunkEvent(
            cumulativeBytesLoaded: cumulative,
            expectedTotalBytes: total,
          )),
        );

        if (bytes.lengthInBytes > 0) {
          selectedCache.putFile(url, bytes);
          return bytes;
        }
      } catch (e) {
        developer.log(
          'Coudn\'t retrieve a cached network file from $url',
          name: 'firebase_image',
          error: e,
        );
      }
    }

    developer.log(
      cachedFile?.file != null
          ? 'Returning a cached network file at $url'
              ', valid till ${cachedFile?.validTill}'
          : 'No cached/new file available at $url',
      name: 'firebase_image',
    );

    return cachedFile?.file?.readAsBytes();
  }

  /// Caches and gets the file from Firebase storage.
  Future<Uint8List> _getFirebaseFile({
    @required StorageReference ref,
    @required int maxBytes,
    CachedNetworkFile cache,

    /// If this is defined, `ref` is only used for the actual "getData" call.
    /// Cache conditionals will be evalued against `optionalComparableRef`.
    StorageReference optionalComparableRef,
  }) async {
    assert(ref != null);
    assert(maxBytes >= 0);

    developer.log(
      'Retrieving a cached file at ${ref.path}',
      name: 'firebase_image',
    );

    final comparableRef = optionalComparableRef ?? ref;
    final selectedCache = cache ?? _defaultCache;
    final cachedFile = await selectedCache.getFileFromCache(comparableRef.path);
    final isOld = cachedFile?.validTill?.isBefore(DateTime.now());

    if (isOld != false) {
      try {
        developer.log(
          'Cache outdated or doesn\'t exist, fetching ${comparableRef.path}…',
          name: 'firebase_image',
        );

        // Getting data from the `ref`, instead of `comparableRef`.
        final bytes = await ref.getData(_kPhotoMaxSize);

        if (bytes.lengthInBytes > 0) {
          developer.log(
            'Fetched and cached a new file at ${comparableRef.path}',
            name: 'firebase_image',
          );

          // FIXME: Allow decoding the image, before this write.
          selectedCache.putFile(comparableRef.path, bytes);
          return bytes;
        }
      } on PlatformException catch (e) {
        developer.log(
          'Failed to getData for ${comparableRef.path}, ${e.message}'
          ', bucket: - $_bucket',
          name: 'firebase_image',
        );
      } catch (e) {
        developer.log(
          'Coudn\'t retrieve a cached file at ${comparableRef.path}',
          name: 'firebase_image',
          error: e,
        );
      }
    }

    developer.log(
      cachedFile?.file != null
          ? 'Returning a cached file at ${comparableRef.path}'
              ', valid till ${cachedFile?.validTill}'
          : 'No cached/new file available at ${comparableRef.path}',
      name: 'firebase_image',
    );

    return cachedFile?.file?.readAsBytes();
  }

  /// Cache large photos without type postfix, to avoid
  /// redundant reads to large files. If they didn't exist
  /// the first time, they won't exist in the future either,
  /// not unless the whole photo hash changes and a new cache
  /// entry is ceated.
  ///
  /// Only use for regular/large photos, this is not intended for thumbnails.
  Future<Uint8List> downloadFirebasePhoto(String path) async {
    assert(path.isNotEmpty);

    final split = path.split('/');
    final adjusted = split.take(split.length - 1).join('/');
    final ref = _bucket.ref().child(adjusted);
    final fullRef = _bucket.ref().child(path);

    assert(split.last == FirebaseImage.names.large || split.last == FirebaseImage.names.regular);

    return _getFirebaseFile(
      ref: fullRef,
      optionalComparableRef: ref,
      maxBytes: _kPhotoMaxSize,
      cache: _defaultCache,
    );
  }

  /// Downloads a cached file from `path` in [_bucket].
  Future<Uint8List> downloadFile({
    @required String path,
    CachedNetworkFile cache,
  }) async {
    assert(path.isNotEmpty);

    developer.log(
      'Calling `downloadFile` with $path ...',
      name: 'firebase_image',
    );

    return _getFirebaseFile(
      ref: _bucket.ref().child(path),
      maxBytes: _kPhotoMaxSize,
      cache: cache ?? _defaultCache,
    );
  }
}
