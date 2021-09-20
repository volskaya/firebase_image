import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_image/src/utils/cached_network_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_coordinator/loader_coordinator.dart';
import 'package:log/log.dart';

/// Storage abstraction around [CachedNetworkFile] to download cached files
/// for [FirebaseImageProvider].
class FirebaseImageStorage {
  const FirebaseImageStorage._();

  static const _kPhotoMaxSize = 5000000; // bytes
  static final _defaultCache = CachedNetworkFile(key: 'storage/firebase_images');
  static final _log = Log.named('FirebaseImageStorage');

  /// Single instance of [FirebaseImageStorage].
  static const instance = FirebaseImageStorage._();
  static FirebaseStorage get _bucket => FirebaseStorage.instanceFor(bucket: FirebaseImage.storageBucket);

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
      if (debugNetworkImageHttpClientProvider != null) client = debugNetworkImageHttpClientProvider!();
      return true;
    }());
    return client;
  }

  /// Attempts to download and cache a file from the `url`.
  Future<Uint8List?> downloadNetworkFile({
    required String url,
    StreamController<ImageChunkEvent>? chunkEvents,
    Map<String, String>? headers,
    CachedNetworkFile? cache,
  }) async {
    final selectedCache = cache ?? _defaultCache;
    final resolved = Uri.base.resolve(url);
    final cachedFile = await selectedCache.getFileFromCache(url);
    final isOld = cachedFile?.validTill.isBefore(DateTime.now());

    if (isOld != false) {
      final loader = LoaderCoordinator.instance.touch();
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
      } catch (e, t) {
        _log.e('Failed to retrieve a cached network file from $url', e, t);
      } finally {
        loader.dispose();
      }
    }

    _log.v(
      cachedFile?.file != null
          ? 'Returning a cached network file at $url'
              ', valid till ${cachedFile?.validTill}'
          : 'No cached/new file available at $url',
    );

    return cachedFile?.file.readAsBytes();
  }

  /// Caches and gets the file from Firebase storage.
  Future<Uint8List?> _getFirebaseFile({
    required Reference ref,
    required int maxBytes,
    CachedNetworkFile? cache,

    /// If this is defined, `ref` is only used for the actual "getData" call.
    /// Cache conditionals will be evalued against `optionalComparableRef`.
    Reference? optionalComparableRef,
  }) async {
    assert(maxBytes >= 0);

    _log.v('Retrieving a cached file at ${ref.fullPath}');

    final comparableRef = optionalComparableRef ?? ref;
    final selectedCache = cache ?? _defaultCache;
    final cachedFile = await selectedCache.getFileFromCache(comparableRef.fullPath);
    final isOld = cachedFile?.validTill.isBefore(DateTime.now());

    if (isOld != false) {
      final loader = LoaderCoordinator.instance.touch();
      try {
        _log.v('Cache outdated or doesn\'t exist, fetching ${comparableRef.fullPath}…');

        // Getting data from the `ref`, instead of `comparableRef`.
        final bytes = await ref.getData(_kPhotoMaxSize);

        if (bytes != null && bytes.lengthInBytes > 0) {
          _log.i('Fetched and cached a new file at ${comparableRef.fullPath}');
          selectedCache.putFile(comparableRef.fullPath, bytes);
          return bytes;
        }
      } on PlatformException catch (e, t) {
        _log.e(
          'Failed to getData for ${comparableRef.fullPath}, ${e.message}'
          ', bucket: - $_bucket',
          e,
          t,
        );
      } catch (e, t) {
        _log.e('Failed to retrieve a cached file at ${comparableRef.fullPath}', e, t);
      } finally {
        loader.dispose();
      }
    }

    _log.v(
      cachedFile?.file != null
          ? 'Returning a cached file at ${comparableRef.fullPath}'
              ', valid till ${cachedFile?.validTill}'
          : 'No cached/new file available at ${comparableRef.fullPath}',
    );

    return cachedFile?.file.readAsBytes();
  }

  /// Cache large photos without type postfix, to avoid
  /// redundant reads to large files. If they didn't exist
  /// the first time, they won't exist in the future either,
  /// not unless the whole photo hash changes and a new cache
  /// entry is ceated.
  ///
  /// Only use for regular/large photos, this is not intended for thumbnails.
  Future<Uint8List?> downloadFirebasePhoto(String path) async {
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
  Future<Uint8List?> downloadFile({
    required String path,
    CachedNetworkFile? cache,
  }) =>
      _getFirebaseFile(
        ref: _bucket.ref().child(path),
        maxBytes: _kPhotoMaxSize,
        cache: cache ?? _defaultCache,
      );
}
