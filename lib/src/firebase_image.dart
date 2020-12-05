import 'dart:async';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:firebase_image/src/blur_hash_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' show join;
import 'package:firebase_image/src/firebase_photo.dart';
import 'package:firebase_image/src/utils/firebase_image_storage.dart';
import 'package:quiver/strings.dart';

const _kLargeDpiBreakPoint = 2;

/// Filenames for firebase image sizes.
class FirebaseImageNames {
  /// Creates [FirebaseImageNames].
  const FirebaseImageNames({
    this.thumbnail = 'thumbnail',
    this.regular = 'reg',
    this.large = 'lg',
    this.photoFolder = 'photo',
  });

  /// Filename of the thumbnail image.
  final String thumbnail;

  /// Filename of the regular image.
  final String regular;

  /// Filename of the large image.
  final String large;

  /// Filename of the photo folder, where the images are placed.
  final String photoFolder;
}

/// [FirebaseImage] provider type.
enum FirebaseImageType {
  /// Enum of a thumbnail firebase image.
  thumbnail,

  /// Enum of a regular firebase image, which can also refer to a large firebase image.
  regular,
}

/// Firebase image provider, which can differentiate between high-res large
/// images, regulars and thumbnails.
///
/// If scale is higher than the [_kLargeDpiBreakPoint], the image provider
/// attempts to first fetch the large image. If none are found, regular photo
/// is fetched.
///
///
class FirebaseImage extends ImageProvider<FirebaseImage> {
  /// Creates [FirebaseImage] of type [FirebaseImageType.regular].
  FirebaseImage(
    this.path,
    this.size, {
    this.scale = 1,
    this.showLarge = true,
    this.blur,
    this.cacheSize,
    this.scrollAwareContext,
  }) : type = FirebaseImageType.regular;

  /// Creates [FirebaseImage] of type [FirebaseImageType.thumbnail].
  FirebaseImage.thumbnail(
    this.path,
    this.size, {
    this.scale = 1,
    this.blur,
    this.cacheSize,
    this.scrollAwareContext,
  })  : type = FirebaseImageType.thumbnail,
        showLarge = false;

  /// Creates a regular [FirebaseImage] from the path of [FirebasePhotoReference].
  factory FirebaseImage.from(FirebasePhotoReference photo, [Size cacheSize]) {
    switch (photo.type) {
      case FirebasePhotoType.image:
        return FirebaseImage(photo.path, photo.size, blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.animation:
        return FirebaseImage(photo.path, photo.size, showLarge: false, blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.video:
        throw UnsupportedError('Theres no video image provider');
      default:
        throw UnimplementedError();
    }
  }

  /// Creates a thumbnail [FirebaseImage] from the path of [FirebasePhotoReference].
  factory FirebaseImage.thumbnailFrom(FirebasePhotoReference photo, [Size cacheSize]) {
    switch (photo.type) {
      case FirebasePhotoType.image:
        return FirebaseImage.thumbnail(photo.path, photo.size, blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.animation:
        return FirebaseImage(photo.path, photo.size, showLarge: false, blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.video:
        throw UnsupportedError('Theres no video image provider');
      default:
        throw UnimplementedError();
    }
  }

  /// Default device pixel ratio.
  ///
  /// This can be overriden from the first app's build method.
  /// Every call to [FirebaseImage.getCacheSize] will default to this value.
  static double defaultPixelRatio = 1;

  /// Optional global storage bucket override for [FirebaseImageStorage].
  ///
  /// Leave this null to fallback to the default storage bucket of this project.
  static String storageBucket;

  /// Firebase storage path to the image file.
  final String path;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Blurhash of the image.
  final FirebasePhotoBlurData blur;

  /// Type of this [FirebaseImageProvider]
  final FirebaseImageType type;

  /// Whether to automatically attempt to fetch large images before regular.
  final bool showLarge;

  /// Size of the [FirebasePhoto] that the [path] points to.
  final Size size;

  /// Cache size to decode the images at.
  ///
  /// NOTE: Don't apply pixel density ratio to this,
  /// [FirebaseImage] does it automatically, [ResizeImage] does not.
  Size cacheSize;

  /// Filenames for firebase image sizes.
  static FirebaseImageNames names = const FirebaseImageNames();

  /// Scroll aware context. If this is defined, image will wait till upper scrollable stops scrolling
  /// fast, before begining a decode.
  ///
  /// Once [DisposableBuildContext.dispose] is called on this context,
  /// the provider will stop trying to resolve the image if it has not already
  /// been resolved.
  DisposableBuildContext scrollAwareContext;

  /// Thumbnail [FirebaseImage] from the copy of this provider, unless it's already a thumbnail.
  FirebaseImage get thumbnail {
    switch (type) {
      case FirebaseImageType.thumbnail:
        return this;
      case FirebaseImageType.regular:
        return FirebaseImage.thumbnail(path, size,
            scale: scale, blur: blur, cacheSize: cacheSize, scrollAwareContext: scrollAwareContext);
    }
    throw UnimplementedError();
  }

  /// Regular [FirebaseImage] from the copy of this provider, unless it's already a regular.
  FirebaseImage get regular {
    switch (type) {
      case FirebaseImageType.regular:
        return this;
      case FirebaseImageType.thumbnail:
        return FirebaseImage(
          path,
          size,
          showLarge: showLarge,
          scale: scale,
          blur: blur,
          cacheSize: cacheSize,
          scrollAwareContext: scrollAwareContext,
        );
    }
    throw UnimplementedError();
  }

  /// [BlurHashImage] from this provider, if the photo had blur.
  BlurHashImage get blurImage => blur != null ? BlurHashImage(blur.hash, blur.size, scale: scale) : null;

  ImageConfiguration _configuration = ImageConfiguration.empty;
  double get _pixelRatio => scale != 1 ? scale : _configuration.devicePixelRatio ?? scale;

  String _buildPathWithScale(double scale, {bool disableScaling = false}) {
    assert(scale != null);
    final shouldScale = scale >= _kLargeDpiBreakPoint && !disableScaling;
    switch (type) {
      case FirebaseImageType.thumbnail:
        return join(path, FirebaseImage.names.thumbnail);
      case FirebaseImageType.regular:
        return shouldScale ? join(path, FirebaseImage.names.large) : join(path, FirebaseImage.names.regular);
      default:
        throw UnimplementedError();
    }
  }

  Future<Uint8List> _getPhoto(String path) async {
    switch (type) {
      case FirebaseImageType.thumbnail:
        return FirebaseImageStorage.instance.downloadFile(path: path);
      case FirebaseImageType.regular:
        return FirebaseImageStorage.instance.downloadFirebasePhoto(path);
      default:
        throw UnimplementedError();
    }
  }

  /// Gets cache size of the [FirebasePhoto] for the current
  ///
  /// [photo] can be null.
  static Size getCacheSize(Size photoSize, Size constraints, [double devicePixelRatio]) {
    assert(photoSize != null);
    assert(constraints != null);

    double width = constraints.width;
    double height = constraints.height;

    if (photoSize.aspectRatio > constraints.aspectRatio) {
      height = constraints.width / photoSize.aspectRatio;
    } else if (photoSize.aspectRatio < constraints.aspectRatio) {
      width = constraints.height * photoSize.aspectRatio;
    }

    return Size(width, height) * (devicePixelRatio ?? FirebaseImage.defaultPixelRatio);
  }

  Future<ui.Codec> _loadAsync(
    FirebaseImage key,
    DecoderCallback decode,
  ) async {
    try {
      assert(_configuration != null);
      assert(key == this);
      if (isEmpty(this.path)) return null;

      // FIXME: Download large image only if `cacheSize` is larger than the regular one.
      // final path = _buildPathWithScale(_pixelRatio, disableScaling: !size);
      // developer.log('Getting image $path, scale: $_pixelRatio', name: 'firebase_image');

      // // First attempt to fetch the largest size.
      // var bytes = await _getPhoto(path);

      // // Attempt to fetch regular size image.
      // if (showLarge && _pixelRatio > _kLargeDpiBreakPoint && bytes == null) {
      //   final path = _buildPathWithScale(1);
      //   developer.log('Falling back to regular image $path, scale: 1', name: 'firebase_image');
      //   bytes = await _getPhoto(path);
      // }

      final path = _buildPathWithScale(1);
      developer.log('Getting image from $path, scale: 1', name: 'firebase_image');
      final bytes = await _getPhoto(path);

      if ((bytes?.lengthInBytes ?? 0) == 0) throw Exception('FirebaseImage is an empty file: $path');
      if (cacheSize != null) {
        // final displayCacheSize = cacheSize * _configuration.devicePixelRatio;
        final displayCacheSize = cacheSize;
        return decode(
          bytes,
          cacheWidth: displayCacheSize.width.toInt(),
          cacheHeight: displayCacheSize.height.toInt(),
        );
      } else {
        return decode(bytes);
      }
    } catch (e) {
      scheduleMicrotask(() => PaintingBinding.instance.imageCache.evict(key));
      rethrow;
    }
  }

  @override
  ImageStreamCompleter load(FirebaseImage key, DecoderCallback decode) => MultiFrameImageStreamCompleter(
        provider: this,
        loop: true,
        codec: _loadAsync(key, decode),
        scale: key.scale,
        informationCollector: () sync* {
          yield ErrorDescription('Path: $path');
        },
      );

  @override
  Future<FirebaseImage> obtainKey(ImageConfiguration configuration) {
    assert(configuration != null);
    _configuration = configuration;
    return SynchronousFuture<FirebaseImage>(this);
  }

  @override
  void resolveStreamForKey(
    ImageConfiguration configuration,
    ImageStream stream,
    FirebaseImage key,
    ImageErrorListener handleError,
  ) {
    if (scrollAwareContext == null) {
      super.resolveStreamForKey(configuration, stream, key, handleError);
      return; // No custom logic needed.
    }

    // Something managed to complete the stream, or it's already in the image
    // cache. Notify the wrapped provider and expect it to behave by not
    // reloading the image since it's already resolved.
    // Do this even if the context has gone out of the tree, since it will
    // update LRU information about the cache. Even though we never showed the
    // image, it was still touched more recently.
    // Do this before checking scrolling, so that if the bytes are available we
    // render them even though we're scrolling fast - there's no additional
    // allocations to do for texture memory, it's already there.
    if (stream.completer != null || PaintingBinding.instance.imageCache.containsKey(key)) {
      super.resolveStreamForKey(configuration, stream, key, handleError);
      return;
    }
    // The context has gone out of the tree - ignore it.
    if (scrollAwareContext.context == null) {
      return;
    }
    // Something still wants this image, but check if the context is scrolling
    // too fast before scheduling work that might never show on screen.
    // Try to get to end of the frame callbacks of the next frame, and then
    // check again.
    if (Scrollable.recommendDeferredLoadingForContext(scrollAwareContext.context)) {
      SchedulerBinding.instance.scheduleFrameCallback((_) {
        scheduleMicrotask(() => resolveStreamForKey(configuration, stream, key, handleError));
      });
      return;
    }

    // We are in the tree, we're not scrolling too fast, the cache doesn't
    // have our image, and no one has otherwise completed the stream.  Go.
    super.resolveStreamForKey(configuration, stream, key, handleError);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FirebaseImage &&
        other.path == path &&
        other.scale == scale &&
        other.type == type &&
        other.size == size &&
        other.cacheSize == cacheSize &&
        other.showLarge == other.showLarge;
  }

  @override
  String toString() {
    return 'FirebaseImage @ $path, cacheSize: $cacheSize';
  }

  @override
  int get hashCode => hashValues(path, scale, type, size, cacheSize, showLarge);

  /// Mutate variables of [FirebaseImage].
  void apply({
    Size cacheSize,

    /// Use [State] for scroll awareness [DisposableBuildContext].
    State state,
  }) {
    if (cacheSize != null) this.cacheSize = cacheSize;
    if (state != null) scrollAwareContext = DisposableBuildContext<State>(state);
  }
}

/// Scroll aware image provider of [FirebaseImage].
class AwareFirebaseImage<T extends StatefulWidget> extends ScrollAwareImageProvider<FirebaseImage> {
  /// Creates a [AwareFirebaseImage] of a regular type [FirestoreImage].
  AwareFirebaseImage.from(State<T> state, FirebasePhotoReference photo, [Size cacheSize])
      : super(
          context: DisposableBuildContext<State<T>>(state),
          imageProvider: FirebaseImage.from(photo, cacheSize),
        );

  /// Creates a [AwareFirebaseImage] of a thumbnail type [FirestoreImage].
  AwareFirebaseImage.thumbnailFrom(State<T> state, FirebasePhotoReference photo, [Size cacheSize])
      : super(
          context: DisposableBuildContext<State<T>>(state),
          imageProvider: FirebaseImage.thumbnailFrom(photo, cacheSize),
        );

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is AwareFirebaseImage && other.imageProvider == imageProvider;
  }

  @override
  int get hashCode => hashValues(imageProvider, true);
}
