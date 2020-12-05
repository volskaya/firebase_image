import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_image/src/switching_firebase_image.dart';
import 'package:flutter/material.dart';

/// [SwitchingMaterialImage], except internally using [SwitchingFirebaseImage].
class SwitchingFirebaseMaterialImage extends StatelessWidget {
  /// Creates [SwitchingFirebaseMaterialImage].
  const SwitchingFirebaseMaterialImage({
    Key key,
    @required this.imageProvider,
    @required this.child,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.shape,
    this.duration = const Duration(milliseconds: 300),
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.elevation = 0,
    this.color,
    this.shadowColor,
  }) : super(key: key);

  /// [FirebaseImage] to switch to.
  final FirebaseImage imageProvider;

  /// While [SwitchingImage.imageProvider] is not loaded an optional
  /// [idleChild] will be built instead.
  final Widget idleChild;

  /// Clip shape of the animated switcher box.
  final ShapeBorder shape;

  /// Duration of the switch transition.
  final Duration duration;

  /// Filter quality of the image.
  final FilterQuality filterQuality;

  /// Box fit of the image.
  final BoxFit fit;

  /// Child [Widget] of the [Material].
  final Widget child;

  /// Children [Widget]'s on top of the [Material], in the switcher's layout builder.
  final Iterable<Widget> layoutChildren;

  /// [Material]'s elevation. Must define [color] to draw elevation.
  final double elevation;

  /// [Material]'s color. Must be defined to draw elevation.
  final Color color;

  /// [Material]'s shadow color.
  final Color shadowColor;

  @override
  Widget build(BuildContext context) => SwitchingFirebaseImage(
        imageProvider: imageProvider,
        idleChild: idleChild,
        shape: shape,
        duration: duration,
        filterQuality: filterQuality,
        fit: fit,
        layoutChildren: [
          RepaintBoundary(
            child: Material(
              type: color != null ? MaterialType.canvas : MaterialType.transparency,
              color: color,
              elevation: elevation,
              shape: shape,
              child: child,
              shadowColor: shadowColor,
            ),
          ),
          ...layoutChildren,
        ],
      );
}