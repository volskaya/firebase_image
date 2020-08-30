import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io' as io;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
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
    this.path, {
    this.scale = 1,
    this.size = true,
  }) : type = FirebaseImageType.regular;

  /// Creates [FirebaseImage] of type [FirebaseImageType.thumbnail].
  FirebaseImage.thumbnail(
    this.path, {
    this.scale = 1,
  })  : type = FirebaseImageType.thumbnail,
        size = true;

  /// Creates a regular [FirebaseImage] from the path of [FirebasePhotoReference].
  factory FirebaseImage.from(FirebasePhotoReference photo) {
    switch (photo.type) {
      case FirebasePhotoType.image:
        return FirebaseImage(photo.path);
      case FirebasePhotoType.animation:
        return FirebaseImage(photo.path, size: false);
      case FirebasePhotoType.video:
        throw UnsupportedError('Theres no video image provider');
      default:
        throw UnimplementedError();
    }
  }

  /// Creates a thumbnail [FirebaseImage] from the path of [FirebasePhotoReference].
  factory FirebaseImage.thumbnailFrom(FirebasePhotoReference photo) {
    switch (photo.type) {
      case FirebasePhotoType.image:
        return FirebaseImage.thumbnail(photo.path);
      case FirebasePhotoType.animation:
        return FirebaseImage(photo.path, size: false);
      case FirebasePhotoType.video:
        throw UnsupportedError('Theres no video image provider');
      default:
        throw UnimplementedError();
    }
  }

  /// Optional global storage bucket override for [FirebaseImageStorage].
  ///
  /// Leave this null to fallback to the default storage bucket of this project.
  static String storageBucket;

  /// Firebase storage path to the image file.
  final String path;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// Type of this [FirebaseImageProvider]
  final FirebaseImageType type;

  /// Whether to automatically attempt to fetch large images before regular.
  final bool size;

  /// Filenames for firebase image sizes.
  static FirebaseImageNames names = const FirebaseImageNames();

  /// Thumbnail [FirebaseImage] from this providers path.
  FirebaseImage get thumbnail {
    assert(type != FirebaseImageType.thumbnail);
    return FirebaseImage.thumbnail(path, scale: scale);
  }

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

  Future<io.File> _getPhoto(String path) async {
    switch (type) {
      case FirebaseImageType.thumbnail:
        return FirebaseImageStorage.instance.downloadFile(path: path);
      case FirebaseImageType.regular:
        return FirebaseImageStorage.instance.downloadFirebasePhoto(path);
      default:
        throw UnimplementedError();
    }
  }

  Future<ui.Codec> _loadAsync(FirebaseImage key, DecoderCallback decode) async {
    assert(_configuration != null);
    assert(key == this);
    if (isEmpty(this.path)) return null;

    final path = _buildPathWithScale(_pixelRatio, disableScaling: !size);
    developer.log('Getting image $path, scale: $_pixelRatio', name: 'firebase_image');
    var image = await _getPhoto(path);

    // Attempt to fetch regular size image
    if (size && _pixelRatio > _kLargeDpiBreakPoint && image == null) {
      final path = _buildPathWithScale(1);
      developer.log('Falling back to regular image $path, scale: 1', name: 'firebase_image');
      image = await _getPhoto(path);
    }

    if (image != null) {
      final bytes = await image.readAsBytes();
      if (bytes.lengthInBytes > 0) return decode(bytes);
    }

    PaintingBinding.instance.imageCache.evict(key);
    return null;
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
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FirebaseImage &&
        other.path == path &&
        other.scale == scale &&
        other.type == type &&
        other.size == size;
  }

  @override
  int get hashCode => hashValues(path, scale, type, size);
}

/// Scroll aware image provider of [FirebaseImage].
class AwareFirebaseImage<T extends StatefulWidget> extends ScrollAwareImageProvider<FirebaseImage> {
  /// Creates a [AwareFirebaseImage] of a regular type [FirestoreImage].
  AwareFirebaseImage.from(State<T> state, FirebasePhotoReference photo)
      : super(
          context: DisposableBuildContext<State<T>>(state),
          imageProvider: FirebaseImage.from(photo),
        );

  /// Creates a [AwareFirebaseImage] of a thumbnail type [FirestoreImage].
  AwareFirebaseImage.thumbnailFrom(State<T> state, FirebasePhotoReference photo)
      : super(
          context: DisposableBuildContext<State<T>>(state),
          imageProvider: FirebaseImage.thumbnailFrom(photo),
        );

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is AwareFirebaseImage && other.imageProvider == imageProvider;
  }

  @override
  int get hashCode => imageProvider.hashCode;
}
