import 'dart:collection';

import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_image/src/utils/comparable_size.dart';
import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';

/// Tracks live [FirebaseImage]s of [ImageCache].
class FirebaseImageCacheListener {
  /// Constructs FirebaseImageCacheListener.
  FirebaseImageCacheListener._(this.imageCache) {
    imageCache.keyAddedCallbacks.add(_handleKeyAdded);
    imageCache.keyEvictedCallbacks.add(_handleKeyRemoved);
  }

  /// App wide instance of [FirebaseImageCacheListener].
  static FirebaseImageCacheListener? instance;

  /// Initializes [FirebaseImageCacheListener] and attaches it to [PaintingBinding.instance.imageCache].
  static void initialize() {
    assert(instance == null);
    WidgetsFlutterBinding.ensureInitialized();
    instance = FirebaseImageCacheListener._(PaintingBinding.instance.imageCache);
  }

  /// Target [ImageCache] from [PainterBinding].
  final ImageCache imageCache;

  /// Set of currently live [FirebaseImage]s.
  final cachedImages = HashSet<FirebaseImage>();

  /// Mapped [FirebaseImage]s by their cache size and path.
  ///
  /// Keyed by the image provider's path.
  final cachedSizes = HashMap<String, SortedMap<ComparableSize, FirebaseImage>>();

  static ComparableSize _comparableSizeOf(FirebaseImage key) {
    final size = key.cacheSize ?? key.size;
    return ComparableSize(size.width, size.height);
  }

  void _handleKeyAdded(Object key) {
    if (key is FirebaseImage) {
      final comparableSize = _comparableSizeOf(key);

      assert(!cachedImages.contains(key));
      assert(!cachedSizes.containsKey(key.path) || !cachedSizes[key.path]!.containsKey(comparableSize));

      // FIXME: Thumbnails and regular photos clash, when they have the same cacheSize.
      // Which in turn fools widgets into prefering that thumbnail, with the bigger cacheSize.

      cachedImages.add(key);
      cachedSizes[key.path] ??= SortedMap<ComparableSize, FirebaseImage>();
      cachedSizes[key.path]![comparableSize] = key;
    }
  }

  void _handleKeyRemoved(Object key) {
    if (key is FirebaseImage) {
      final comparableSize = _comparableSizeOf(key);

      assert(cachedImages.contains(key));
      assert(cachedSizes.containsKey(key.path));
      assert(cachedSizes[key.path]!.containsKey(comparableSize));

      cachedImages.remove(key);
      cachedSizes[key.path]?.remove(comparableSize);

      if (cachedSizes[key.path]?.isEmpty == true) cachedSizes.remove(key.path);
    }
  }

  /// Lookup the highest available size of [FirebaseImage] inside [FirebaseImageCacheListener]'s cache.
  FirebaseImage? getHighestCachedSize(FirebaseImage image) {
    if (cachedSizes.containsKey(image.path)) {
      for (final key in cachedSizes[image.path]!.keys) {
        final provider = cachedSizes[image.path]![key];
        assert(provider != null && PaintingBinding.instance.imageCache.containsKey(provider));
        if (provider == null) continue; // FIXME: Shouldn't happen.
        return provider;
      }
    }

    return null;
  }

  /// Remove listeners.
  void dispose() {
    imageCache.keyAddedCallbacks.remove(_handleKeyAdded);
    imageCache.keyEvictedCallbacks.remove(_handleKeyRemoved);
  }
}
