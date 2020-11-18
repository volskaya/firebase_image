import 'dart:developer' as developer;

import 'package:await_route/await_route.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:firebase_image/src/firebase_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
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
  }) : super(key: key);

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
      );

  @override
  _SwitchingFirebaseImageState createState() => _SwitchingFirebaseImageState();
}

class _SwitchingFirebaseImageState extends State<SwitchingFirebaseImage> {
  FirebaseImage _provider;

  void _cycleThumbnail() {
    developer.log(
      'Cycling thumbnail: ${widget.imageProvider?.path?.toString()}',
      name: 'firebase_image',
    );

    if (widget.imageProvider == null) {
      _provider = null;
      return;
    }

    switch (widget.imageProvider.type) {
      case FirebaseImageType.thumbnail:
        _provider = widget.imageProvider;
        break;
      case FirebaseImageType.regular:
        final path = widget.imageProvider.path.toString();
        final thumbnail = FirebaseImage.thumbnail(path, scale: widget.imageProvider.scale);
        final containsImage = PaintingBinding.instance.imageCache.containsKey(widget.imageProvider);
        final containsThumbnail = PaintingBinding.instance.imageCache.containsKey(thumbnail);

        if (!containsImage && containsThumbnail) {
          _provider = thumbnail;

          // If state currently targets a thumbnail, but the widget intended
          // to show a regular image, begin the switch process.
          //
          // NOTE: Waits till the route animation is finished
          if (_provider?.type == FirebaseImageType.thumbnail &&
              widget.imageProvider.type == FirebaseImageType.regular &&
              _provider?.path == path &&
              widget.imageProvider.path == path &&
              mounted) {
            // Set the real imageProvider, to begin [SwitchingImage] decode process
            AwaitRoute.of(context, postFrame: true).then(
              (_) => SchedulerBinding.instance.scheduleTask(
                () => setState(() => _provider = widget.imageProvider),
                Priority.touch,
              ),
            );
          }
        } else {
          _provider = widget.imageProvider;
        }

        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _cycleThumbnail();
  }

  @override
  void didUpdateWidget(SwitchingFirebaseImage oldWidget) {
    if (oldWidget.imageProvider != widget.imageProvider) _cycleThumbnail();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => SwitchingImage(
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
