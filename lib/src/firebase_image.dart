import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:firebase_image/src/blur_hash_image.dart';
import 'package:firebase_image/src/firebase_photo.dart';
import 'package:firebase_image/src/utils/firebase_image_storage.dart';
import 'package:firebase_image/src/utils/switching_firebase_image_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' show join;
import 'package:quiver/strings.dart';

part 'firebase_image.freezed.dart';

const _kLargeDpiBreakPoint = 2;

/// Filenames for firebase image sizes.
@freezed
class FirebaseImageNames with _$FirebaseImageNames {
  /// Creates [FirebaseImageNames].
  const factory FirebaseImageNames({
    /// Filename of the thumbnail image.
    @Default('thumbnail') String thumbnail,

    /// Filename of the regular image.
    @Default('reg') String regular,

    /// Filename of the large image.
    @Default('lg') String large,

    /// Filename of the photo folder, where the images are placed.
    @Default('photo') String photoFolder,
  }) = _FirebaseImageNames;
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
    this.hash,
    this.regularURL,
    this.thumbnailURL,
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
    this.hash,
    this.regularURL,
    this.thumbnailURL,
    this.size, {
    this.scale = 1,
    this.blur,
    this.cacheSize,
    this.scrollAwareContext,
  })  : type = FirebaseImageType.thumbnail,
        showLarge = false;

  /// Creates a regular [FirebaseImage] from the path of [FirebasePhotoReference].
  factory FirebaseImage.from(FirebasePhotoReference photo, [Size? cacheSize]) {
    switch (photo.type) {
      case FirebasePhotoType.image:
        return FirebaseImage(photo.path, photo.hash, photo.regularURL, photo.thumbnailURL, photo.size,
            blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.animation:
        return FirebaseImage(photo.path, photo.hash, photo.regularURL, photo.thumbnailURL, photo.size,
            showLarge: false, blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.video:
        throw UnsupportedError('Theres no video image provider');
    }
  }

  /// Creates a thumbnail [FirebaseImage] from the path of [FirebasePhotoReference].
  factory FirebaseImage.thumbnailFrom(FirebasePhotoReference photo, [Size? cacheSize]) {
    switch (photo.type) {
      case FirebasePhotoType.image:
        return FirebaseImage.thumbnail(photo.path, photo.hash, photo.regularURL, photo.thumbnailURL, photo.size,
            blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.animation:
        return FirebaseImage(photo.path, photo.hash, photo.regularURL, photo.thumbnailURL, photo.size,
            showLarge: false, blur: photo.blur, cacheSize: cacheSize);
      case FirebasePhotoType.video:
        throw UnsupportedError('Theres no video image provider');
    }
  }

  /// Optional global storage bucket override for [FirebaseImageStorage].
  ///
  /// Leave this null to fallback to the default storage bucket of this project.
  static String? storageBucket;

  /// Firebase storage path to the image file.
  final String path;

  /// Public URL of the regular photo.
  final String regularURL;

  /// Public URL of the regular photo.
  final String? thumbnailURL;

  /// Hash of the file in the Firebase storage.
  final String hash;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Blurhash of the image.
  final FirebasePhotoBlurData? blur;

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
  Size? cacheSize;

  /// Filenames for firebase image sizes.
  static FirebaseImageNames names = const FirebaseImageNames();

  /// Version 2:
  ///   + Ignores the old "key" from storage paths.
  static int version = 2;

  /// Scroll aware context. If this is defined, image will wait till upper scrollable stops scrolling
  /// fast, before begining a decode.
  ///
  /// Once [DisposableBuildContext.dispose] is called on this context,
  /// the provider will stop trying to resolve the image if it has not already
  /// been resolved.
  DisposableBuildContext? scrollAwareContext;

  /// Calculate image area, prioritizing [cacheSize] if defined.
  static double getImageArea(FirebaseImage image) {
    final size = image.cacheSize ?? image.size;
    return size.width * size.height;
  }

  /// Return true if [a] has a bigger area than [than].
  static bool isImageBigger(FirebaseImage a, {required FirebaseImage than}) => getImageArea(a) > getImageArea(than);

  /// Return the [FirebaseImage] with the largest area.
  static FirebaseImage getBetterQuality(FirebaseImage a, FirebaseImage b) => isImageBigger(a, than: b) ? a : b;

  /// Thumbnail [FirebaseImage] from the copy of this provider, unless it's already a thumbnail.
  FirebaseImage get thumbnail {
    switch (type) {
      case FirebaseImageType.thumbnail:
        return this;
      case FirebaseImageType.regular:
        return FirebaseImage.thumbnail(path, hash, regularURL, thumbnailURL, size,
            scale: scale, blur: blur, cacheSize: cacheSize, scrollAwareContext: scrollAwareContext);
    }
  }

  /// Regular [FirebaseImage] from the copy of this provider, unless it's already a regular.
  FirebaseImage get regular {
    switch (type) {
      case FirebaseImageType.regular:
        return this;
      case FirebaseImageType.thumbnail:
        return FirebaseImage(path, hash, regularURL, thumbnailURL, size,
            showLarge: showLarge,
            scale: scale,
            blur: blur,
            cacheSize: cacheSize,
            scrollAwareContext: scrollAwareContext);
    }
  }

  /// [BlurHashImage] from this provider, if the photo had blur.
  BlurHashImage? get blurImage => blur != null ? BlurHashImage(blur!.hash, blur!.size, scale: scale) : null;

  /// TODO: Implement a check for large photos.
  String _getStoragePath({FirebaseImageType? type}) {
    switch (type ?? this.type) {
      case FirebaseImageType.thumbnail:
        return join(path, FirebaseImage.names.thumbnail);
      case FirebaseImageType.regular:
        return join(path, FirebaseImage.names.regular);
    }
  }

  /// Gets cache size of the [FirebasePhoto] for the current
  ///
  /// [photo] can be null. This won't return original size, if it's smaller than the constraints.
  static Size getCacheSize(Size photoSize, Size constraints, [double? devicePixelRatio]) {
    double width = constraints.width;
    double height = constraints.height;

    if (photoSize.aspectRatio > constraints.aspectRatio) {
      height = constraints.width / photoSize.aspectRatio;
    } else if (photoSize.aspectRatio < constraints.aspectRatio) {
      width = constraints.height * photoSize.aspectRatio;
    }

    final dpr = (devicePixelRatio ?? WidgetsBinding.instance!.window.devicePixelRatio);
    return Size(width * dpr, height * dpr);
  }

  Future<ui.Codec> _loadAsync(
    FirebaseImage key,
    DecoderCallback decode,
  ) async {
    try {
      assert(key == this);

      String url;
      String storagePath;
      Uint8List? bytes;

      switch (type) {
        case FirebaseImageType.thumbnail:
          if (thumbnailURL != null) {
            url = thumbnailURL!;
            storagePath = _getStoragePath(type: type);
            break;
          } else {
            continue regular;
          }
        regular:
        case FirebaseImageType.regular:
          url = regularURL;
          storagePath = _getStoragePath(type: type);
          break;
      }

      // Prefer downloading images from the network.
      if (isNotEmpty(url)) {
        try {
          bytes = await FirebaseImageStorage.instance.downloadNetworkFile(url: url, key: storagePath);
        } on NetworkImageLoadException catch (e) {
          // Some old images might not have exposed the download URLs to public,
          // so avoid hard throwing and fallback to downloading directly from Firebase.
          if (e.statusCode == HttpStatus.unauthorized) {
            bytes = await FirebaseImageStorage.instance.downloadFirebasePhoto(storagePath);
          }
        }
      } else {
        bytes = await FirebaseImageStorage.instance.downloadFirebasePhoto(storagePath);
      }

      if ((bytes?.lengthInBytes ?? 0) == 0) throw Exception('FirebaseImage is an empty file: $path');
      return cacheSize == null
          ? decode(bytes!)
          : decode(
              bytes!,
              cacheWidth: cacheSize!.width.toInt(),
              cacheHeight: cacheSize!.height.toInt(),
              allowUpscaling: false,
            );
    } catch (_) {
      scheduleMicrotask(() => PaintingBinding.instance!.imageCache!.evict(key));
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
  Future<FirebaseImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture<FirebaseImage>(this);

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
    if (stream.completer != null || PaintingBinding.instance!.imageCache!.containsKey(key)) {
      super.resolveStreamForKey(configuration, stream, key, handleError);
      return;
    }
    // The context has gone out of the tree - ignore it.
    if (scrollAwareContext!.context == null) {
      return;
    }
    // Something still wants this image, but check if the context is scrolling
    // too fast before scheduling work that might never show on screen.
    // Try to get to end of the frame callbacks of the next frame, and then
    // check again.
    if (Scrollable.recommendDeferredLoadingForContext(scrollAwareContext!.context!)) {
      SchedulerBinding.instance!.scheduleFrameCallback((_) {
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
        other.regularURL == regularURL &&
        other.thumbnailURL == thumbnailURL &&
        other.scale == scale &&
        other.type == type &&
        other.size == size &&
        other.cacheSize == cacheSize &&
        other.showLarge == other.showLarge;
  }

  @override
  int get hashCode => hashValues(path, scale, type, size, cacheSize, showLarge);

  @override
  String toString() {
    return 'FirebaseImage @ $path, size: $size, cacheSize: $cacheSize';
  }

  /// Overwrite the [scrollAwareContext] of this [FirebaseImage].
  void setScrollAwareContext(DisposableBuildContext<State>? context) => scrollAwareContext = context;

  /// Overwrite the [cacheSize] of this [FirebaseImage].
  void setCacheSize(Size cacheSize) => cacheSize = cacheSize;

  /// Creates a copy of this [FirebaseImage].
  FirebaseImage copyWith({
    Size? cacheSize,
  }) =>
      FirebaseImage(
        path,
        hash,
        regularURL,
        thumbnailURL,
        size,
        scale: scale,
        showLarge: showLarge,
        blur: blur,
        cacheSize: cacheSize ?? this.cacheSize,
        scrollAwareContext: scrollAwareContext,
      );
}

/// Scroll aware image provider of [FirebaseImage].
class AwareFirebaseImage<T extends StatefulWidget> extends ScrollAwareImageProvider<FirebaseImage> {
  /// Creates a [AwareFirebaseImage] of a regular type [FirestoreImage].
  AwareFirebaseImage.from(
    SwitchingFirebaseImageState<T> state,
    FirebasePhotoReference photo, [
    Size? cacheSize,
  ]) : super(
          context: state.scrollAwareContext,
          imageProvider: FirebaseImage.from(photo, cacheSize),
        );

  /// Creates a [AwareFirebaseImage] of a thumbnail type [FirestoreImage].
  AwareFirebaseImage.thumbnailFrom(
    SwitchingFirebaseImageState<T> state,
    FirebasePhotoReference photo, [
    Size? cacheSize,
  ]) : super(
          context: state.scrollAwareContext,
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
