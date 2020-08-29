import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io' as io;

import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_image/src/utils/cached_network_file.dart';

/// Storage abstraction around [CachedNetworkFile] to download cached files
/// for [FirebaseImageProvider].
class FirebaseImageStorage {
  const FirebaseImageStorage._();

  static const _kPhotoMaxSize = 5000000; // bytes

  static final CachedNetworkFile _defaultCache =
      CachedNetworkFile(key: 'storage/firebase_images');

  /// Single instance of [FirebaseImageStorage].
  static FirebaseImageStorage instance = const FirebaseImageStorage._();
  static FirebaseStorage get _bucket =>
      FirebaseStorage(storageBucket: FirebaseImage.storageBucket);

  /// Caches and gets the file
  Future<io.File> _getFile({
    @required StorageReference ref,
    @required int maxBytes,
    CachedNetworkFile cache,
  }) async {
    assert(ref != null);
    assert(maxBytes >= 0);

    developer.log(
      'Retrieving a cached file at ${ref.path}',
      name: 'firebase_image',
    );

    final selectedCache = cache ?? _defaultCache;
    final cachedFile = await selectedCache.getFileFromCache(ref.path);
    final isOld = cachedFile?.validTill?.isBefore(DateTime.now());

    if (isOld == null || isOld == true) {
      try {
        developer.log(
          'Cache outdated or doesn\'t exist, fetching ${ref.path}…',
          name: 'firebase_image',
        );

        final bytes = await ref.getData(_kPhotoMaxSize);

        if (bytes.lengthInBytes > 0) {
          developer.log(
            'Fetched and cached a new file at ${ref.path}',
            name: 'firebase_image',
          );
          return await selectedCache.putFile(ref.path, bytes);
        }
      } on PlatformException catch (e) {
        developer.log(
          'Failed to getData for ${ref.path}, ${e.message}'
          ', bucket: - $_bucket',
          name: 'firebase_image',
        );
      } catch (e) {
        developer.log(
          'Coudn\'t retrieve a cahced file at ${ref.path}',
          name: 'firebase_image',
          error: e,
        );
      }
    }

    developer.log(
      cachedFile?.file != null
          ? 'Returning a cached file at ${ref.path}'
              ', valid till ${cachedFile?.validTill}'
          : 'No cached/new file available at ${ref.path}',
      name: 'firebase_image',
    );

    return cachedFile?.file;
  }

  /// Cache large photos without type postfix, to avoid
  /// redundant reads to large files. If they didn't exist
  /// the first time, they won't exist in the future either,
  /// not unless the whole photo hash changes and a new cache
  /// entry is ceated.
  ///
  /// Only use for regular/large photos, this is not intended for thumbnails.
  Future<io.File> downloadFirebasePhoto(String path) async {
    assert(path.isNotEmpty);

    final split = path.split('/');
    final adjusted = split.take(split.length - 1).join('/');
    final ref = _bucket.ref().child(adjusted);
    final fullRef = _bucket.ref().child(path);

    assert(split.last == 'lg' || split.last == 'reg');
    developer.log(
      'Downloading firebase photo from ${ref.path}',
      name: 'firebase_image',
    );

    final cachedFile = await _defaultCache.getFileFromCache(ref.path);
    final isOld = cachedFile?.validTill?.isBefore(DateTime.now());

    if (isOld == null || isOld == true) {
      try {
        developer.log(
          'Cache outdated or doesn\'t exist, fetching ${ref.path}…',
          name: 'firebase_image',
        );
        final bytes = await fullRef.getData(_kPhotoMaxSize);

        if (bytes.lengthInBytes > 0) {
          developer.log(
            'Fetched and cached a new photo at ${ref.path}',
            name: 'firebase_image',
          );
          return _defaultCache.putFile(ref.path, bytes);
        }
      } on PlatformException catch (e) {
        developer.log(
          'Couldn\t download firebase photo from ${ref.path}, ${e.message}',
          name: 'firebase_image',
          error: e,
        );
      } catch (e) {
        developer.log(
          'Couldn\'t download firebase photo from ${ref.path}',
          name: 'firebase_image',
          error: e,
        );
      }
    }

    developer.log(
      cachedFile?.file != null
          ? 'Returning a cached photo at ${ref.path}'
              ', valid till ${cachedFile?.validTill}'
          : 'No cached/network photo available at ${ref.path}',
      name: 'firebase_image',
    );

    return cachedFile?.file;
  }

  /// Downloads a cached file from `path` in [_bucket].
  Future<io.File> downloadFile({
    @required String path,
    CachedNetworkFile cache,
  }) async {
    assert(path.isNotEmpty);

    developer.log(
      'Calling `downloadFile` with $path ...',
      name: 'firebase_image',
    );

    return _getFile(
      ref: _bucket.ref().child(path),
      maxBytes: _kPhotoMaxSize,
      cache: cache ?? _defaultCache,
    );
  }
}
