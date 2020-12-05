import 'dart:developer' as developer;

import 'package:await_route/await_route.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_image/src/firebase_image_cache_listener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Wrapped [SwitchingImage] to first load thumbnail provider,
/// if its cached in [WidgetsBinding] already, before resolving
/// the regular image.
class SwitchingFirebaseImage extends StatefulWidget {
  /// Creates [SwitchingFirebaseImage].
  const SwitchingFirebaseImage({
    Key key,
    @required this.imageProvider,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.shape,
    this.duration = const Duration(milliseconds: 300),
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.alignment = AlignmentDirectional.topStart,
  })  : colorBlendMode = null,
        color = null,
        filter = false,
        super(key: key);

  /// Creates filter variant of [SwitchingFirebaseImage].
  const SwitchingFirebaseImage.filter({
    Key key,
    @required this.imageProvider,
    @required this.color,
    this.colorBlendMode = BlendMode.saturation,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.shape,
    this.duration = const Duration(milliseconds: 300),
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.alignment = AlignmentDirectional.topStart,
  })  : filter = true,
        super(key: key);

  /// [FirebaseImage] to switch to.
  final FirebaseImage imageProvider;

  /// While [SwitchingImage.imageProvider] is not loaded an optional
  /// [idleChild] will be built instead.
  final Widget idleChild;

  /// Children [Widget]'s on top of the [Material], in the switcher's layout builder.
  final Iterable<Widget> layoutChildren;

  /// Clip shape of the animated switcher box.
  final ShapeBorder shape;

  /// Duration of the switch transition.
  final Duration duration;

  /// Filter quality of the image.
  final FilterQuality filterQuality;

  /// Box fit of the image.
  final BoxFit fit;

  /// Opacity override when you wish to animate the image without having to overlap
  /// multiple opacity shaders.
  final ValueListenable<double> opacity;

  /// Alignment of the children in the switchers.
  final AlignmentGeometry alignment;

  /// Blend mode of the internal [ColorFiltered] filter.
  final BlendMode colorBlendMode;

  /// Color of the internal [ColorFiltered] filter.
  final Color color;

  /// Whether to wrap images in a [ColorFiltered] widget.
  final bool filter;

  /// Convenience copy method.
  SwitchingFirebaseImage copyWith({
    FirebaseImage imageProvider,
    Widget idleChild,
    ShapeBorder shape,
    ValueListenable<double> opacity,
  }) =>
      SwitchingFirebaseImage(
        key: key,
        imageProvider: imageProvider ?? this.imageProvider,
        idleChild: idleChild ?? this.idleChild,
        shape: shape ?? this.shape,
        opacity: opacity ?? this.opacity,
        alignment: alignment,
        duration: duration,
        filterQuality: filterQuality,
        fit: fit,
        layoutChildren: layoutChildren,
      );

  @override
  _SwitchingFirebaseImageState createState() => _SwitchingFirebaseImageState();
}

class _SwitchingFirebaseImageState extends State<SwitchingFirebaseImage> {
  FirebaseImageCacheListener _cacheListener;
  FirebaseImage _provider;

  static double _getImageArea(FirebaseImage image) {
    final size = image.cacheSize ?? image.size;
    return size.width * size.height;
  }

  static FirebaseImage _getBetterQuality(FirebaseImage a, FirebaseImage b) =>
      _getImageArea(a) > _getImageArea(b) ? a : b;

  Future _delayDecodeOf(FirebaseImage image) async {
    if (!mounted || image != widget.imageProvider) return;
    await AwaitRoute.of(context, postFrame: true);
    setState(() => _provider = image);
  }

  void _handleNewImage(Object key) {
    if (key is FirebaseImage && key.path == widget.imageProvider.path) {
      assert(_provider.path == key.path);
      final betterQualityImage = _getBetterQuality(key, _provider);
      if (betterQualityImage != _provider) {
        setState(() => _provider = betterQualityImage);
      }
    }
  }

  void _cycleThumbnail() {
    developer.log('Cycling thumbnail: ${widget.imageProvider?.path}', name: 'firebase_image');

    if (widget.imageProvider == null) {
      _provider = null;
      return; // Image removed.
    }

    // If the widget targets a thumbnail, look for smallest cached image instead, to prevent tiny tiles from
    // garbage collecting big images.
    final cachedImage = _cacheListener?.getHighestCachedSize(
      widget.imageProvider.regular,
      lowestInstead: widget.imageProvider.type == FirebaseImageType.thumbnail,
    );

    bool decodeWidgetsImageProvider = true; // If a higher res image is already cached, that one is used instead.
    bool delayDecode = false; // To paint a cached image and later decode a different image, the frame must be delayed.

    if (cachedImage != null) {
      // Calculate size differences between the cached and widget's selected image.
      final cachedArea = _getImageArea(cachedImage);
      final widgetImageArea = _getImageArea(widget.imageProvider);

      // Widget image should have a different resolution.
      decodeWidgetsImageProvider = widgetImageArea > cachedArea;
      delayDecode = true;
      _provider = cachedImage; // Use the cached image for the current frame.
    }

    if (decodeWidgetsImageProvider) {
      if (delayDecode) {
        _delayDecodeOf(widget.imageProvider);
      } else {
        _provider = widget.imageProvider;
      }
    }
  }

  @override
  void initState() {
    _cacheListener = FirebaseImageCacheListener.of(context);
    _cycleThumbnail();
    PaintingBinding.instance.imageCache.keyAddedCallbacks.add(_handleNewImage);
    super.initState();
  }

  @override
  void didUpdateWidget(SwitchingFirebaseImage oldWidget) {
    if (oldWidget.imageProvider != widget.imageProvider) _cycleThumbnail();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    PaintingBinding.instance.imageCache.keyAddedCallbacks.remove(_handleNewImage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.filter
      ? SwitchingImage.filter(
          imageProvider: _provider,
          idleChild: widget.idleChild,
          shape: widget.shape,
          opacity: widget.opacity,
          duration: widget.duration,
          alignment: widget.alignment,
          filterQuality: widget.filterQuality,
          fit: widget.fit,
          layoutChildren: widget.layoutChildren,
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
        )
      : SwitchingImage(
          imageProvider: _provider,
          idleChild: widget.idleChild,
          shape: widget.shape,
          opacity: widget.opacity,
          duration: widget.duration,
          alignment: widget.alignment,
          filterQuality: widget.filterQuality,
          fit: widget.fit,
          layoutChildren: widget.layoutChildren,
          type: SwitchingImageType.fade,
        );
}
