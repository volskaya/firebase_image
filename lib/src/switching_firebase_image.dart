import 'package:await_route/await_route.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_image/src/firebase_image_cache_listener.dart';
import 'package:firebase_image/src/utils/switching_firebase_image_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Wrapped [SwitchingImage] to first load thumbnail provider,
/// if its cached in [WidgetsBinding] already, before resolving
/// the regular image.
class SwitchingFirebaseImage extends StatefulWidget {
  /// Creates [SwitchingFirebaseImage].
  const SwitchingFirebaseImage({
    Key? key,
    required this.imageProvider,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.shape,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 300),
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.alignment = AlignmentDirectional.topStart,
    this.scrollAware = false,
    this.type = SwitchingImageType.fade,
  })  : colorBlendMode = null,
        color = null,
        filter = false,
        super(key: key);

  /// Creates filter variant of [SwitchingFirebaseImage].
  const SwitchingFirebaseImage.filter({
    Key? key,
    required this.imageProvider,
    required this.color,
    this.colorBlendMode = BlendMode.saturation,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.shape,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 300),
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.alignment = AlignmentDirectional.topStart,
    this.scrollAware = false,
  })  : type = SwitchingImageType.fade,
        filter = true,
        super(key: key);

  /// [FirebaseImage] to switch to.
  final ImageProvider? imageProvider;

  /// While [SwitchingImage.imageProvider] is not loaded an optional
  /// [idleChild] will be built instead.
  final Widget? idleChild;

  /// Children [Widget]'s on top of the [Material], in the switcher's layout builder.
  final Iterable<Widget> layoutChildren;

  /// Border radius of the animated switcher images.
  final BorderRadius? borderRadius;

  /// Shape of the animated switcher images.
  final ShapeBorder? shape;

  /// Duration of the switch transition.
  final Duration duration;

  /// Filter quality of the image.
  final FilterQuality filterQuality;

  /// Box fit of the image.
  final BoxFit fit;

  /// Transition type used by the animated switcher within [SwitchingImage].
  final SwitchingImageType type;

  /// Opacity override when you wish to animate the image without having to overlap
  /// multiple opacity shaders.
  final ValueListenable<double>? opacity;

  /// Alignment of the children in the switchers.
  final AlignmentGeometry alignment;

  /// Blend mode of the internal [ColorFiltered] filter.
  final BlendMode? colorBlendMode;

  /// Color of the internal [ColorFiltered] filter.
  final Color? color;

  /// Whether to wrap images in a [ColorFiltered] widget.
  final bool filter;

  /// Don't decode the image, if a parent scrollable is scrolling too fast.
  final bool scrollAware;

  /// Convenience copy method.
  SwitchingFirebaseImage copyWith({
    FirebaseImage? imageProvider,
    Widget? idleChild,
    BorderRadius? borderRadius,
    ShapeBorder? shape,
    ValueListenable<double>? opacity,
  }) =>
      SwitchingFirebaseImage(
        key: key,
        imageProvider: imageProvider ?? this.imageProvider,
        idleChild: idleChild ?? this.idleChild,
        borderRadius: borderRadius ?? this.borderRadius,
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

class _SwitchingFirebaseImageState extends State<SwitchingFirebaseImage>
    with SwitchingFirebaseImageState<SwitchingFirebaseImage> {
  FirebaseImageCacheListener? _cacheListener;
  ImageProvider? _provider;

  /// Sets scroll awarness, if necessary.
  void _setProvider(FirebaseImage? provider) {
    // Unbind context from the previous provider, in case it's causing memory leaks.
    if (_provider != null && _provider is FirebaseImage) {
      (_provider as FirebaseImage).setScrollAwareContext(null);
    }

    _provider = provider != null
        ? !widget.scrollAware
            ? provider
            : (provider..setScrollAwareContext(scrollAwareContext))
        : null;
  }

  Future _delayDecodeOf(FirebaseImage image) async {
    if (!mounted || image != widget.imageProvider) return;
    await AwaitRoute.of(context, postFrame: true);
    if (mounted) setState(() => _setProvider(image));
  }

  void _handleNewImage(Object key) {
    assert(widget.imageProvider is FirebaseImage);
    assert(mounted);

    if (key is FirebaseImage && key.path == (widget.imageProvider as FirebaseImage).path) {
      assert((_provider as FirebaseImage).path == key.path);

      final betterQualityImage = FirebaseImage.getBetterQuality(key, _provider as FirebaseImage);
      if (betterQualityImage != _provider) {
        setState(() => _setProvider(betterQualityImage));
      }
    }
  }

  void _cycleImage() {
    assert(widget.imageProvider is FirebaseImage);

    if (widget.imageProvider == null) {
      _setProvider(null);
      return; // Image removed.
    }

    final widgetImage = widget.imageProvider as FirebaseImage;

    // If the widget targets a thumbnail, look for smallest cached image instead, to prevent tiny tiles from
    // garbage collecting big images.
    final cachedImage = _cacheListener?.getHighestCachedSize(widgetImage.regular);

    bool decodeWidgetsImageProvider = true; // If a higher res image is already cached, that one is used instead.
    bool delayDecode = false; // To paint a cached image and later decode a different image, the frame must be delayed.

    if (cachedImage != null) {
      // Widget image should have a different resolution.
      // Delay decode only if the cached image is smaller than the requested one.
      decodeWidgetsImageProvider = FirebaseImage.isImageBigger(widgetImage, than: cachedImage);
      delayDecode = decodeWidgetsImageProvider;
      _setProvider(cachedImage); // Use the cached image for the current frame.
    }

    if (decodeWidgetsImageProvider) {
      if (delayDecode) {
        _delayDecodeOf(widgetImage);
      } else {
        _setProvider(widgetImage);
      }
    }
  }

  bool _listening = false;
  void _listenForBetterImages() {
    if (_listening) return;
    PaintingBinding.instance!.imageCache!.keyAddedCallbacks.add(_handleNewImage);
    _listening = true;
  }

  void _stopListeningForBetterImages() {
    if (!_listening) return;
    PaintingBinding.instance!.imageCache!.keyAddedCallbacks.remove(_handleNewImage);
    _listening = false;
  }

  @override
  void initState() {
    super.initState();
    _cacheListener = FirebaseImageCacheListener.of(context);

    if (widget.imageProvider != null && widget.imageProvider is FirebaseImage) {
      _cycleImage();
      _listenForBetterImages();
    }
  }

  @override
  void didUpdateWidget(SwitchingFirebaseImage oldWidget) {
    if (oldWidget.imageProvider != widget.imageProvider) {
      if (widget.imageProvider is FirebaseImage) {
        _cycleImage();
        _listenForBetterImages();
      } else {
        _stopListeningForBetterImages();
        _provider = widget.imageProvider;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _stopListeningForBetterImages();
    _setProvider(null); // Unbind the build context from the current provider.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.filter
      ? SwitchingImage.filter(
          imageProvider: _provider,
          idleChild: widget.idleChild,
          borderRadius: widget.borderRadius,
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
          borderRadius: widget.borderRadius,
          shape: widget.shape,
          opacity: widget.opacity,
          duration: widget.duration,
          alignment: widget.alignment,
          filterQuality: widget.filterQuality,
          fit: widget.fit,
          layoutChildren: widget.layoutChildren,
          type: widget.type,
        );
}
