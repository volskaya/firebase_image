import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io' as io;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/cache.dart';

/// Batches and memoizes requests to the same network [io.File].
/// Memoized item is discarded after async tick completes and read again
/// for the file system, when needed
class CachedNetworkFile extends BaseCacheManager {
  /// Created [CachedNetworkFile].
  CachedNetworkFile({
    @required this.key,
  })  : assert(key?.isNotEmpty == true),
        super(
          key,
          maxAgeCacheObject: const Duration(days: 30),
        );

  /// Key that serves as the cache label.
  final String key;

  /// Values intended to be invalidated, when their operation completes
  final _cache = MapCache<String, io.File>();

  Future<io.File> _getSingleFile(String url) async {
    assert(url?.isNotEmpty == true);
    developer.log('Fetching file: $url', name: 'firebase_image');
    try {
      return getSingleFile(url);
    } catch (e) {
      developer.log(
        'Couldn\'t fetch file: $url',
        name: 'firebase_image',
        error: e,
      );
    }

    return null;
  }

  @override
  Future<String> getFilePath() async {
    final temp = await getTemporaryDirectory();
    return path.join(temp.path, key);
  }

  /// Fetch a file from the `url` and cache it.
  Future<io.File> fromUrl(String url) async {
    assert(url?.isNotEmpty == true);
    developer.log(
      'Requesting cached network file from: $url',
      name: 'firebase_image',
    );
    final file = await _cache.get(
      url,
      ifAbsent: (String url) async =>
          _getSingleFile(url).whenComplete(() => _cache.invalidate(key)),
    );
    developer.log(
      'File $url, ' + (file != null ? 'retrieved: $file' : 'not found'),
      name: 'firebase_image',
    );
    return file;
  }
}
