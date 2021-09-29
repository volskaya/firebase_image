import 'package:flutter/rendering.dart';

class ComparableSize extends Size implements Comparable {
  /// Creates a [ComparableSize] with the given [width] and [height].
  const ComparableSize(double width, double height) : super(width, height);

  /// Creates an instance of [ComparableSize] that has the same values as another.
  // Used by the rendering library's _DebugSize hack.
  ComparableSize.copy(ComparableSize source) : super(source.width, source.height);

  /// Creates a square [ComparableSize] whose [width] and [height] are the given dimension.
  ///
  /// See also:
  ///
  ///  * [ComparableSize.fromRadius], which is more convenient when the available size
  ///    is the radius of a circle.
  const ComparableSize.square(double dimension) : super(dimension, dimension);

  /// Creates a [ComparableSize] with the given [width] and an infinite [height].
  const ComparableSize.fromWidth(double width) : super(width, double.infinity);

  /// Creates a [ComparableSize] with the given [height] and an infinite [width].
  const ComparableSize.fromHeight(double height) : super(double.infinity, height);

  /// Creates a square [ComparableSize] whose [width] and [height] are twice the given
  /// dimension.
  ///
  /// This is a square that contains a circle with the given radius.
  ///
  /// See also:
  ///
  ///  * [ComparableSize.square], which creates a square with the given dimension.
  const ComparableSize.fromRadius(double radius) : super(radius * 2.0, radius * 2.0);

  @override
  int compareTo(dynamic other) =>
      other is ComparableSize ? -((width * height).compareTo(other.width * other.height)) : 0;
}
