import 'dart:async';
import 'dart:ui' as ui;

// import 'package:blurhash/blurhash.dart';
import 'package:firebase_image/src/firebase_photo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Blurhash image provider.
class BlurHashImage extends ImageProvider<BlurHashImage> {
  /// Creates [BlurHashImage].
  BlurHashImage(
    this.hash,
    this.size, {
    this.scale = 1,
  });

  /// Blurhash of the image.
  final String hash;

  /// Size of the decoded image.
  final Size size;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  // ImageConfiguration _configuration = ImageConfiguration.empty;

  Future<ui.Codec> _loadAsync(
    BlurHashImage key,
    DecoderCallback decode,
  ) async {
    try {
      assert(key == this);

      // final bytes = await BlurHash.decode(hash, size.width.toInt(), size.height.toInt());
      // if ((bytes?.lengthInBytes ?? 0) == 0) throw Exception('Couldn\'t decode BlurHashImage: $hash, $size');
      // return decode(bytes);

      throw 'Disabled';
    } catch (e) {
      scheduleMicrotask(() => PaintingBinding.instance!.imageCache!.evict(key));
      rethrow;
    }
  }

  @override
  ImageStreamCompleter load(BlurHashImage key, DecoderCallback decode) => MultiFrameImageStreamCompleter(
        provider: this,
        loop: true,
        codec: _loadAsync(key, decode),
        scale: key.scale,
        informationCollector: () sync* {
          yield ErrorDescription('Hash: $hash');
        },
      );

  @override
  Future<BlurHashImage> obtainKey(ImageConfiguration configuration) {
    // _configuration = configuration;
    return SynchronousFuture<BlurHashImage>(this);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is BlurHashImage && other.hash == hash && other.scale == scale && other.size == size;
  }

  @override
  int get hashCode => hashValues(hash, scale, size);
}

/// Scroll aware image provider of [BlurHashImage].
class AwareBlurHashImage<T extends StatefulWidget> extends ScrollAwareImageProvider<BlurHashImage> {
  /// Creates a [AwareBlurHashImage] of a regular type [FirestoreImage].
  AwareBlurHashImage.from(State<T> state, FirebasePhotoReference photo)
      : super(
          context: DisposableBuildContext<State<T>>(state),
          imageProvider: BlurHashImage(photo.image.blur!.hash, photo.size),
        );

  /// Creates a [AwareBlurHashImage] of a thumbnail type [FirestoreImage].
  AwareBlurHashImage.thumbnailFrom(State<T> state, FirebasePhotoReference photo)
      : super(
          context: DisposableBuildContext<State<T>>(state),
          imageProvider: BlurHashImage(photo.thumbnail.blur!.hash, photo.size),
        );

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is AwareBlurHashImage && other.imageProvider == imageProvider;
  }

  @override
  int get hashCode => imageProvider.hashCode;
}
