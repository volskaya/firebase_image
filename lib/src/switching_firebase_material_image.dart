import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

/// [SwitchingMaterialImage], except internally using [SwitchingFirebaseImage].
@Deprecated('Ink decorations now paint on the foreground. Stop using this widget.')
class SwitchingFirebaseMaterialImage extends StatelessWidget {
  /// Creates [SwitchingFirebaseMaterialImage].
  const SwitchingFirebaseMaterialImage({
    Key? key,
    required this.imageProvider,
    required this.child,
    this.idleChild,
    this.layoutChildren = const <Widget>[],
    this.borderRadius,
    this.type,
    this.shape,
    this.duration,
    this.curve,
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.cover,
    this.scrollAware = false,
    this.expandBox = true,
    this.inherit = false,
    this.paintInheritedAnimations = false,
    this.wrapInheritBoundary = false,
  }) : super(key: key);

  /// [FirebaseImage] to switch to.
  final FirebaseImage? imageProvider;

  /// While [SwitchingImage.imageProvider] is not loaded an optional
  /// [idleChild] will be built instead.
  final Widget? idleChild;

  /// Clip rect shape of the animated switcher image.
  final BorderRadius? borderRadius;

  /// Clip shape of the animated switcher image.
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

  /// Don't decode the image, if a parent scrollable is scrolling too fast.
  final bool scrollAware;

  /// Child [Widget] of the [Material].
  final Widget child;

  /// Children [Widget]'s on top of the [Material], in the switcher's layout builder.
  final Iterable<Widget> layoutChildren;

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

  @override
  Widget build(BuildContext context) => SwitchingFirebaseImage(
        imageProvider: imageProvider,
        idleChild: idleChild,
        borderRadius: borderRadius,
        shape: shape,
        scrollAware: scrollAware,
        duration: duration,
        curve: curve,
        type: type,
        filterQuality: filterQuality,
        fit: fit,
        expandBox: expandBox,
        inherit: inherit,
        paintInheritedAnimations: paintInheritedAnimations,
        wrapInheritBoundary: wrapInheritBoundary,
        layoutChildren: [
          InkFeaturesWidget(
            key: const ValueKey(#inkFeaturesWidget),
            child: child,
          ),
          ...layoutChildren,
        ],
      );
}
