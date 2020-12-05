import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Tracks live [FirebaseImage]s of [ImageCache].
class FirebaseImageCacheListener {
  /// Constructs FirebaseImageCacheListener.
  FirebaseImageCacheListener(this.imageCache) {
    _attach();
  }

  /// Target [ImageCache] from [PainterBinding].
  final ImageCache imageCache;

  /// Set of currently live [FirebaseImage]s.
  final cachedImages = <FirebaseImage>{};

  /// Mapped [FirebaseImage]s by their cache size and path.
  final cachedSizes = <String, Map<Size, FirebaseImage>>{}; // Keyed by the image provider's path.

  /// Get [FirebaseImageCacheListener] from context, if it exists.
  static FirebaseImageCacheListener of(BuildContext context) {
    try {
      return Provider.of<FirebaseImageCacheListener>(context, listen: false);
    } catch (_) {
      return null; //Couldn't find it.
    }
  }

  void _handleKeyAdded(Object key) {
    if (key is FirebaseImage) {
      assert(!cachedImages.contains(key));
      cachedImages.add(key);

      if (key.cacheSize != null) {
        assert(!cachedSizes.containsKey(key.path) || !cachedSizes[key.path].containsKey(key.cacheSize));

        cachedSizes[key.path] ??= <Size, FirebaseImage>{};
        cachedSizes[key.path][key.cacheSize] = key;
      }
    }
  }

  void _handleKeyRemoved(Object key) {
    if (key is FirebaseImage) {
      assert(cachedImages.contains(key));
      cachedImages.remove(key);

      if (key.cacheSize != null) {
        assert(cachedSizes.containsKey(key.path));
        assert(cachedSizes[key.path].containsKey(key.cacheSize));
        cachedSizes[key.path].remove(key.cacheSize);
      }
    }
  }

  void _attach() {
    imageCache.keyAddedCallbacks.add(_handleKeyAdded);
    imageCache.keyEvictedCallbacks.add(_handleKeyRemoved);
  }

  /// Remove listeners.
  void dispose() {
    imageCache.keyAddedCallbacks.remove(_handleKeyAdded);
    imageCache.keyEvictedCallbacks.remove(_handleKeyRemoved);
  }

  /// Lookup the highest available size of [FirebaseImage] inside [FirebaseImageCacheListener]'s cache.
  FirebaseImage getHighestCachedSize(FirebaseImage image, {bool lowestInstead = false}) {
    if (cachedSizes.containsKey(image.path)) {
      final keys = cachedSizes[image.path].keys.toList(growable: false)
        ..sort((a, b) {
          return (a.width * a.height).compareTo(b.width * b.height);
        });

      for (final key in lowestInstead ? keys : keys.reversed) {
        final provider = cachedSizes[image.path][key];
        assert(PaintingBinding.instance.imageCache.containsKey(provider));
        return provider;
      }
    }

    return null;
  }
}
