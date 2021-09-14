import 'dart:async';
import 'dart:io' as io;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:log/log.dart';
import 'package:quiver/cache.dart';

/// Batches and memoizes requests to the same network [io.File].
/// Memoized item is discarded after async tick completes and read again
/// for the file system, when needed
class CachedNetworkFile extends CacheManager {
  /// Created [CachedNetworkFile].
  CachedNetworkFile({
    required this.key,
  })  : assert(key.isNotEmpty),
        super(
          Config(
            key,
            stalePeriod: const Duration(days: 365),
          ),
        );

  /// Key that serves as the cache label.
  final String key;

  /// Values intended to be invalidated, when their operation completes.
  final _cache = MapCache<String, io.File?>();
  static final _log = Log.named('CachedNetworkFile');

  Future<io.File?> _getSingleFile(String url) async {
    assert(url.isNotEmpty);
    _log.v('Fetching file: $url');

    try {
      return getSingleFile(url);
    } catch (e, t) {
      _log.e('Failed to fetch file: $url', e, t);
    }

    return null;
  }

  Future<io.File?> _handleAbsent(String url) async {
    try {
      return await _getSingleFile(url);
    } finally {
      // Defer invalidate until the call above is awaited.
      _cache.invalidate(url);
    }
  }

  /// Fetch a file from the `url` and cache it.
  Future<io.File?> fromUrl(String url) async {
    assert(url.isNotEmpty);

    _log.v('Requesting cached network file from: $url');
    final file = await _cache.get(url, ifAbsent: _handleAbsent);

    _log.v('File $url, ' + (file != null ? 'retrieved: $file' : 'not found'));
    return file;
  }
}
