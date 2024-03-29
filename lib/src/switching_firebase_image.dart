import 'package:await_route/await_route.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_image/src/firebase_image_cache_listener.dart';
import 'package:firebase_image/src/utils/switching_firebase_image_state.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

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
    this.duration,
    this.curve,
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.wrap,
    this.alignment = AlignmentDirectional.topStart,
    this.scrollAware = false,
    this.type,
    this.expandBox = true,
    this.inherit = false,
    this.paintInheritedAnimations = false,
    this.wrapInheritBoundary = false,
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
    this.duration,
    this.curve,
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.opacity,
    this.wrap,
    this.alignment = AlignmentDirectional.topStart,
    this.scrollAware = false,
    this.expandBox = true,
    this.inherit = false,
    this.paintInheritedAnimations = false,
    this.wrapInheritBoundary = false,
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
  final Duration? duration;

  /// Curve of the switch transition.
  final Curve? curve;

  /// Filter quality of the image.
  final FilterQuality filterQuality;

  /// Box fit of the image.
  final BoxFit fit;

  /// Transition type used by the animated switcher within [SwitchingImage].
  final SwitchingImageType? type;

  /// Opacity override when you wish to animate the image without having to overlap
  /// multiple opacity shaders.
  final Animation<double>? opacity;

  /// Optional wrap builder.
  final SwitchingImageWrapBuilder? wrap;

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

  /// Whether to wrap the widget in [SizedBox.expand].
  final bool expandBox;

  /// Whether to defer the animations to [InheritedAnimationCoordinator].
  ///
  /// If this is toggled, you are responsible for building [InheritedAnimation]
  /// somewhere down the widget tree.
  final bool inherit;

  /// Whether to paint any deferred animations before the child.
  final bool paintInheritedAnimations;

  /// Whether to add an [InheritedAnimationCoordinator.boundary] to avoid inheriting parent animations.
  final bool wrapInheritBoundary;

  /// Consider similar if a and b are 2 [FirebaseImage]s with the same path.
  static bool similarImageCheck(ImageInfo? a, ImageInfo? b) {
    final aProvider = a?.provider != null && a!.provider is FirebaseImage ? a.provider as FirebaseImage : null;
    final bProvider = b?.provider != null && b!.provider is FirebaseImage ? b.provider as FirebaseImage : null;

    return aProvider == null && bProvider == null ? false : aProvider?.path == bProvider?.path;
  }

  @override
  _SwitchingFirebaseImageState createState() => _SwitchingFirebaseImageState();
}

class _SwitchingFirebaseImageState extends State<SwitchingFirebaseImage>
    with SwitchingFirebaseImageState<SwitchingFirebaseImage>, InitialDependencies {
  ModalRoute? _route;
  bool _routeAwaited = false;
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

    markNeedsBuild();
  }

  Future _delayDecodeOf(FirebaseImage image) async {
    if (!mounted || image != widget.imageProvider) return;

    try {
      await Future.wait([
        Utils.awaitPostframe(),
        if (!_routeAwaited && _route != null)
          (() async {
            await AwaitRoute.waitFor<dynamic>(_route!);
            _routeAwaited = true;
          })(),
      ]);
    } catch (_) {}

    if (mounted) {
      _setProvider(image);
    }
  }

  void _handleNewImage(Object key) {
    assert(widget.imageProvider is FirebaseImage);
    assert(mounted);

    if (key is FirebaseImage && key.path == (widget.imageProvider as FirebaseImage).path) {
      assert((_provider as FirebaseImage).path == key.path);

      final betterQualityImage = FirebaseImage.getBetterQuality(key, _provider as FirebaseImage);
      if (betterQualityImage != _provider) {
        _setProvider(betterQualityImage);
      }
    }
  }

  void _cycleImage() {
    assert(widget.imageProvider is FirebaseImage);

    if (widget.imageProvider == null) {
      _setProvider(null);
      return; // Image removed, nothing to cycle anymore.
    }

    final widgetImage = widget.imageProvider as FirebaseImage;

    // If the widget targets a thumbnail, look for smallest cached image instead, to prevent tiny tiles from
    // garbage collecting big images.
    final cachedImage = FirebaseImageCacheListener.instance!.getHighestCachedSize(widgetImage.regular);

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
    assert(PaintingBinding.instance.imageCache == FirebaseImageCacheListener.instance!.imageCache);
    FirebaseImageCacheListener.instance!.imageCache.keyAddedCallbacks.add(_handleNewImage);
    _listening = true;
  }

  void _stopListeningForBetterImages() {
    if (!_listening) return;
    FirebaseImageCacheListener.instance!.imageCache.keyAddedCallbacks.remove(_handleNewImage);
    _listening = false;
  }

  @override
  void initDependencies() {
    // Make sure this is called after the `_route` is set.
    if (widget.imageProvider != null && widget.imageProvider is FirebaseImage) {
      _cycleImage();
      _listenForBetterImages();
    } else {
      _provider = widget.imageProvider;
    }
  }

  @override
  void didChangeDependencies() {
    if (!_routeAwaited) {
      final route = ModalRoute.of(context);
      if (route?.animation?.isCompleted == false) {
        _route = route;
      }
    }
    super.didChangeDependencies();
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
    _provider = null; // Unbind the build context from the current provider.
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
          wrap: widget.wrap,
          duration: widget.duration,
          curve: widget.curve,
          alignment: widget.alignment,
          filterQuality: widget.filterQuality,
          fit: widget.fit,
          layoutChildren: widget.layoutChildren,
          color: widget.color,
          colorBlendMode: widget.colorBlendMode,
          expandBox: widget.expandBox,
          inherit: widget.inherit,
          paintInheritedAnimations: widget.paintInheritedAnimations,
          wrapInheritBoundary: widget.wrapInheritBoundary,
          areSimilar: SwitchingFirebaseImage.similarImageCheck,
        )
      : SwitchingImage(
          imageProvider: _provider,
          idleChild: widget.idleChild,
          borderRadius: widget.borderRadius,
          shape: widget.shape,
          opacity: widget.opacity,
          wrap: widget.wrap,
          duration: widget.duration,
          curve: widget.curve,
          alignment: widget.alignment,
          filterQuality: widget.filterQuality,
          fit: widget.fit,
          layoutChildren: widget.layoutChildren,
          type: widget.type,
          expandBox: widget.expandBox,
          inherit: widget.inherit,
          paintInheritedAnimations: widget.paintInheritedAnimations,
          wrapInheritBoundary: widget.wrapInheritBoundary,
          areSimilar: SwitchingFirebaseImage.similarImageCheck,
        );
}
