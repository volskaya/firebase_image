import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_image/src/utils/firebase_image_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// A wrapper around [NetworkImage] to use [FirebaseImage] cache.
class CachedNetworkImage extends ImageProvider<CachedNetworkImage> {
  /// Constructs [CachedNetworkImage].
  const CachedNetworkImage(
    this.url, {
    this.scale = 1.0,
    this.headers,
  });

  /// The URL from which the image will be fetched.
  final String url;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  ///
  /// When running flutter on the web, headers are not used.
  final Map<String, String> headers;

  @override
  Future<CachedNetworkImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture<CachedNetworkImage>(this);

  @override
  ImageStreamCompleter load(CachedNetworkImage key, DecoderCallback decode) {
    // NOTE: Close the stream in [_loadAsync].
    final chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      provider: this,
      codec: _loadAsync(key, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.url,
      informationCollector: () {
        return <DiagnosticsNode>[
          DiagnosticsProperty<ImageProvider>('Image provider', this),
          DiagnosticsProperty<CachedNetworkImage>('Image key', key),
        ];
      },
    );
  }

  Future<ui.Codec> _loadAsync(
    CachedNetworkImage key,
    StreamController<ImageChunkEvent> chunkEvents,
    DecoderCallback decode,
  ) async {
    try {
      assert(key == this);

      final bytes = await FirebaseImageStorage.instance.downloadNetworkFile(
        url: key.url,
        chunkEvents: chunkEvents,
        headers: headers,
      );

      if ((bytes?.lengthInBytes ?? 0) == 0) throw Exception('CachedNetworkImage is an empty file: $url');
      return decode(bytes);
    } catch (e) {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      chunkEvents.close();
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is CachedNetworkImage && other.url == url && other.scale == scale;
  }

  @override
  int get hashCode => ui.hashValues(url, scale);

  @override
  String toString() => '${objectRuntimeType(this, 'CachedNetworkImage')}("$url", scale: $scale)';
}
