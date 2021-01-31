// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'firebase_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
FirebasePhotoBlurData _$FirebasePhotoBlurDataFromJson(
    Map<String, dynamic> json) {
  return _FirebasePhotoBlurData.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoBlurDataTearOff {
  const _$FirebasePhotoBlurDataTearOff();

// ignore: unused_element
  _FirebasePhotoBlurData call(
      {@required @JsonKey() String hash,
      @required @JsonKey() num width,
      @required @JsonKey() num height}) {
    return _FirebasePhotoBlurData(
      hash: hash,
      width: width,
      height: height,
    );
  }

// ignore: unused_element
  FirebasePhotoBlurData fromJson(Map<String, Object> json) {
    return FirebasePhotoBlurData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $FirebasePhotoBlurData = _$FirebasePhotoBlurDataTearOff();

/// @nodoc
mixin _$FirebasePhotoBlurData {
  /// Blurhash.
  @JsonKey()
  String get hash;

  /// Width of the blurhash.
  @JsonKey()
  num get width;

  /// Height of the blurhash.
  @JsonKey()
  num get height;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FirebasePhotoBlurDataCopyWith<FirebasePhotoBlurData> get copyWith;
}

/// @nodoc
abstract class $FirebasePhotoBlurDataCopyWith<$Res> {
  factory $FirebasePhotoBlurDataCopyWith(FirebasePhotoBlurData value,
          $Res Function(FirebasePhotoBlurData) then) =
      _$FirebasePhotoBlurDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() String hash, @JsonKey() num width, @JsonKey() num height});
}

/// @nodoc
class _$FirebasePhotoBlurDataCopyWithImpl<$Res>
    implements $FirebasePhotoBlurDataCopyWith<$Res> {
  _$FirebasePhotoBlurDataCopyWithImpl(this._value, this._then);

  final FirebasePhotoBlurData _value;
  // ignore: unused_field
  final $Res Function(FirebasePhotoBlurData) _then;

  @override
  $Res call({
    Object hash = freezed,
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_value.copyWith(
      hash: hash == freezed ? _value.hash : hash as String,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
    ));
  }
}

/// @nodoc
abstract class _$FirebasePhotoBlurDataCopyWith<$Res>
    implements $FirebasePhotoBlurDataCopyWith<$Res> {
  factory _$FirebasePhotoBlurDataCopyWith(_FirebasePhotoBlurData value,
          $Res Function(_FirebasePhotoBlurData) then) =
      __$FirebasePhotoBlurDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey() String hash, @JsonKey() num width, @JsonKey() num height});
}

/// @nodoc
class __$FirebasePhotoBlurDataCopyWithImpl<$Res>
    extends _$FirebasePhotoBlurDataCopyWithImpl<$Res>
    implements _$FirebasePhotoBlurDataCopyWith<$Res> {
  __$FirebasePhotoBlurDataCopyWithImpl(_FirebasePhotoBlurData _value,
      $Res Function(_FirebasePhotoBlurData) _then)
      : super(_value, (v) => _then(v as _FirebasePhotoBlurData));

  @override
  _FirebasePhotoBlurData get _value => super._value as _FirebasePhotoBlurData;

  @override
  $Res call({
    Object hash = freezed,
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_FirebasePhotoBlurData(
      hash: hash == freezed ? _value.hash : hash as String,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirebasePhotoBlurData
    with DiagnosticableTreeMixin
    implements _FirebasePhotoBlurData {
  _$_FirebasePhotoBlurData(
      {@required @JsonKey() this.hash,
      @required @JsonKey() this.width,
      @required @JsonKey() this.height})
      : assert(hash != null),
        assert(width != null),
        assert(height != null);

  factory _$_FirebasePhotoBlurData.fromJson(Map<String, dynamic> json) =>
      _$_$_FirebasePhotoBlurDataFromJson(json);

  @override

  /// Blurhash.
  @JsonKey()
  final String hash;
  @override

  /// Width of the blurhash.
  @JsonKey()
  final num width;
  @override

  /// Height of the blurhash.
  @JsonKey()
  final num height;

  bool _didsize = false;
  Size _size;

  @override
  Size get size {
    if (_didsize == false) {
      _didsize = true;
      _size = Size(width.toDouble(), height.toDouble());
    }
    return _size;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhotoBlurData(hash: $hash, width: $width, height: $height, size: $size)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirebasePhotoBlurData'))
      ..add(DiagnosticsProperty('hash', hash))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('size', size));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirebasePhotoBlurData &&
            (identical(other.hash, hash) ||
                const DeepCollectionEquality().equals(other.hash, hash)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(hash) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height);

  @JsonKey(ignore: true)
  @override
  _$FirebasePhotoBlurDataCopyWith<_FirebasePhotoBlurData> get copyWith =>
      __$FirebasePhotoBlurDataCopyWithImpl<_FirebasePhotoBlurData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirebasePhotoBlurDataToJson(this);
  }
}

abstract class _FirebasePhotoBlurData implements FirebasePhotoBlurData {
  factory _FirebasePhotoBlurData(
      {@required @JsonKey() String hash,
      @required @JsonKey() num width,
      @required @JsonKey() num height}) = _$_FirebasePhotoBlurData;

  factory _FirebasePhotoBlurData.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhotoBlurData.fromJson;

  @override

  /// Blurhash.
  @JsonKey()
  String get hash;
  @override

  /// Width of the blurhash.
  @JsonKey()
  num get width;
  @override

  /// Height of the blurhash.
  @JsonKey()
  num get height;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoBlurDataCopyWith<_FirebasePhotoBlurData> get copyWith;
}

FirebasePhotoFaceData _$FirebasePhotoFaceDataFromJson(
    Map<String, dynamic> json) {
  return _FirebasePhotoFaceData.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoFaceDataTearOff {
  const _$FirebasePhotoFaceDataTearOff();

// ignore: unused_element
  _FirebasePhotoFaceData call(
      {@required @JsonKey() num x,
      @required @JsonKey() num y,
      @required @JsonKey() num width,
      @required @JsonKey() num height,
      @required @JsonKey() @SizeConverter() Size size}) {
    return _FirebasePhotoFaceData(
      x: x,
      y: y,
      width: width,
      height: height,
      size: size,
    );
  }

// ignore: unused_element
  FirebasePhotoFaceData fromJson(Map<String, Object> json) {
    return FirebasePhotoFaceData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $FirebasePhotoFaceData = _$FirebasePhotoFaceDataTearOff();

/// @nodoc
mixin _$FirebasePhotoFaceData {
  /// Left side of the face rect.
  @JsonKey()
  num get x;

  /// Top side of the face rect.
  @JsonKey()
  num get y;

  /// Width of the face rect.
  @JsonKey()
  num get width;

  /// Height of the face rect.
  @JsonKey()
  num get height;

  /// Size of the image that overlaps this face rect.
  @JsonKey()
  @SizeConverter()
  Size get size;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FirebasePhotoFaceDataCopyWith<FirebasePhotoFaceData> get copyWith;
}

/// @nodoc
abstract class $FirebasePhotoFaceDataCopyWith<$Res> {
  factory $FirebasePhotoFaceDataCopyWith(FirebasePhotoFaceData value,
          $Res Function(FirebasePhotoFaceData) then) =
      _$FirebasePhotoFaceDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() num x,
      @JsonKey() num y,
      @JsonKey() num width,
      @JsonKey() num height,
      @JsonKey() @SizeConverter() Size size});
}

/// @nodoc
class _$FirebasePhotoFaceDataCopyWithImpl<$Res>
    implements $FirebasePhotoFaceDataCopyWith<$Res> {
  _$FirebasePhotoFaceDataCopyWithImpl(this._value, this._then);

  final FirebasePhotoFaceData _value;
  // ignore: unused_field
  final $Res Function(FirebasePhotoFaceData) _then;

  @override
  $Res call({
    Object x = freezed,
    Object y = freezed,
    Object width = freezed,
    Object height = freezed,
    Object size = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed ? _value.x : x as num,
      y: y == freezed ? _value.y : y as num,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
      size: size == freezed ? _value.size : size as Size,
    ));
  }
}

/// @nodoc
abstract class _$FirebasePhotoFaceDataCopyWith<$Res>
    implements $FirebasePhotoFaceDataCopyWith<$Res> {
  factory _$FirebasePhotoFaceDataCopyWith(_FirebasePhotoFaceData value,
          $Res Function(_FirebasePhotoFaceData) then) =
      __$FirebasePhotoFaceDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey() num x,
      @JsonKey() num y,
      @JsonKey() num width,
      @JsonKey() num height,
      @JsonKey() @SizeConverter() Size size});
}

/// @nodoc
class __$FirebasePhotoFaceDataCopyWithImpl<$Res>
    extends _$FirebasePhotoFaceDataCopyWithImpl<$Res>
    implements _$FirebasePhotoFaceDataCopyWith<$Res> {
  __$FirebasePhotoFaceDataCopyWithImpl(_FirebasePhotoFaceData _value,
      $Res Function(_FirebasePhotoFaceData) _then)
      : super(_value, (v) => _then(v as _FirebasePhotoFaceData));

  @override
  _FirebasePhotoFaceData get _value => super._value as _FirebasePhotoFaceData;

  @override
  $Res call({
    Object x = freezed,
    Object y = freezed,
    Object width = freezed,
    Object height = freezed,
    Object size = freezed,
  }) {
    return _then(_FirebasePhotoFaceData(
      x: x == freezed ? _value.x : x as num,
      y: y == freezed ? _value.y : y as num,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
      size: size == freezed ? _value.size : size as Size,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirebasePhotoFaceData
    with DiagnosticableTreeMixin
    implements _FirebasePhotoFaceData {
  _$_FirebasePhotoFaceData(
      {@required @JsonKey() this.x,
      @required @JsonKey() this.y,
      @required @JsonKey() this.width,
      @required @JsonKey() this.height,
      @required @JsonKey() @SizeConverter() this.size})
      : assert(x != null),
        assert(y != null),
        assert(width != null),
        assert(height != null),
        assert(size != null);

  factory _$_FirebasePhotoFaceData.fromJson(Map<String, dynamic> json) =>
      _$_$_FirebasePhotoFaceDataFromJson(json);

  @override

  /// Left side of the face rect.
  @JsonKey()
  final num x;
  @override

  /// Top side of the face rect.
  @JsonKey()
  final num y;
  @override

  /// Width of the face rect.
  @JsonKey()
  final num width;
  @override

  /// Height of the face rect.
  @JsonKey()
  final num height;
  @override

  /// Size of the image that overlaps this face rect.
  @JsonKey()
  @SizeConverter()
  final Size size;

  bool _didrect = false;
  Rect _rect;

  @override
  Rect get rect {
    if (_didrect == false) {
      _didrect = true;
      _rect = Rect.fromLTWH(
          x.toDouble(), y.toDouble(), width.toDouble(), height.toDouble());
    }
    return _rect;
  }

  bool _didimageRect = false;
  Rect _imageRect;

  @override
  Rect get imageRect {
    if (_didimageRect == false) {
      _didimageRect = true;
      _imageRect = Offset.zero & size;
    }
    return _imageRect;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhotoFaceData(x: $x, y: $y, width: $width, height: $height, size: $size, rect: $rect, imageRect: $imageRect)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirebasePhotoFaceData'))
      ..add(DiagnosticsProperty('x', x))
      ..add(DiagnosticsProperty('y', y))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('size', size))
      ..add(DiagnosticsProperty('rect', rect))
      ..add(DiagnosticsProperty('imageRect', imageRect));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirebasePhotoFaceData &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.y, y) ||
                const DeepCollectionEquality().equals(other.y, y)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(y) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(size);

  @JsonKey(ignore: true)
  @override
  _$FirebasePhotoFaceDataCopyWith<_FirebasePhotoFaceData> get copyWith =>
      __$FirebasePhotoFaceDataCopyWithImpl<_FirebasePhotoFaceData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirebasePhotoFaceDataToJson(this);
  }
}

abstract class _FirebasePhotoFaceData implements FirebasePhotoFaceData {
  factory _FirebasePhotoFaceData(
          {@required @JsonKey() num x,
          @required @JsonKey() num y,
          @required @JsonKey() num width,
          @required @JsonKey() num height,
          @required @JsonKey() @SizeConverter() Size size}) =
      _$_FirebasePhotoFaceData;

  factory _FirebasePhotoFaceData.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhotoFaceData.fromJson;

  @override

  /// Left side of the face rect.
  @JsonKey()
  num get x;
  @override

  /// Top side of the face rect.
  @JsonKey()
  num get y;
  @override

  /// Width of the face rect.
  @JsonKey()
  num get width;
  @override

  /// Height of the face rect.
  @JsonKey()
  num get height;
  @override

  /// Size of the image that overlaps this face rect.
  @JsonKey()
  @SizeConverter()
  Size get size;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoFaceDataCopyWith<_FirebasePhotoFaceData> get copyWith;
}

FirebasePhotoPalette _$FirebasePhotoPaletteFromJson(Map<String, dynamic> json) {
  return _FirebasePhotoPalette.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoPaletteTearOff {
  const _$FirebasePhotoPaletteTearOff();

// ignore: unused_element
  _FirebasePhotoPalette call(
      {@JsonKey() @HexStringColorConverter() Color vibrant,
      @JsonKey() @HexStringColorConverter() Color muted,
      @JsonKey() @HexStringColorConverter() Color lightMuted,
      @JsonKey() @HexStringColorConverter() Color darkMuted,
      @JsonKey() @HexStringColorConverter() Color lightVibrant,
      @JsonKey() @HexStringColorConverter() Color darkVibrant}) {
    return _FirebasePhotoPalette(
      vibrant: vibrant,
      muted: muted,
      lightMuted: lightMuted,
      darkMuted: darkMuted,
      lightVibrant: lightVibrant,
      darkVibrant: darkVibrant,
    );
  }

// ignore: unused_element
  FirebasePhotoPalette fromJson(Map<String, Object> json) {
    return FirebasePhotoPalette.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $FirebasePhotoPalette = _$FirebasePhotoPaletteTearOff();

/// @nodoc
mixin _$FirebasePhotoPalette {
  @JsonKey()
  @HexStringColorConverter()
  Color get vibrant;
  @JsonKey()
  @HexStringColorConverter()
  Color get muted;
  @JsonKey()
  @HexStringColorConverter()
  Color get lightMuted;
  @JsonKey()
  @HexStringColorConverter()
  Color get darkMuted;
  @JsonKey()
  @HexStringColorConverter()
  Color get lightVibrant;
  @JsonKey()
  @HexStringColorConverter()
  Color get darkVibrant;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FirebasePhotoPaletteCopyWith<FirebasePhotoPalette> get copyWith;
}

/// @nodoc
abstract class $FirebasePhotoPaletteCopyWith<$Res> {
  factory $FirebasePhotoPaletteCopyWith(FirebasePhotoPalette value,
          $Res Function(FirebasePhotoPalette) then) =
      _$FirebasePhotoPaletteCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() @HexStringColorConverter() Color vibrant,
      @JsonKey() @HexStringColorConverter() Color muted,
      @JsonKey() @HexStringColorConverter() Color lightMuted,
      @JsonKey() @HexStringColorConverter() Color darkMuted,
      @JsonKey() @HexStringColorConverter() Color lightVibrant,
      @JsonKey() @HexStringColorConverter() Color darkVibrant});
}

/// @nodoc
class _$FirebasePhotoPaletteCopyWithImpl<$Res>
    implements $FirebasePhotoPaletteCopyWith<$Res> {
  _$FirebasePhotoPaletteCopyWithImpl(this._value, this._then);

  final FirebasePhotoPalette _value;
  // ignore: unused_field
  final $Res Function(FirebasePhotoPalette) _then;

  @override
  $Res call({
    Object vibrant = freezed,
    Object muted = freezed,
    Object lightMuted = freezed,
    Object darkMuted = freezed,
    Object lightVibrant = freezed,
    Object darkVibrant = freezed,
  }) {
    return _then(_value.copyWith(
      vibrant: vibrant == freezed ? _value.vibrant : vibrant as Color,
      muted: muted == freezed ? _value.muted : muted as Color,
      lightMuted:
          lightMuted == freezed ? _value.lightMuted : lightMuted as Color,
      darkMuted: darkMuted == freezed ? _value.darkMuted : darkMuted as Color,
      lightVibrant:
          lightVibrant == freezed ? _value.lightVibrant : lightVibrant as Color,
      darkVibrant:
          darkVibrant == freezed ? _value.darkVibrant : darkVibrant as Color,
    ));
  }
}

/// @nodoc
abstract class _$FirebasePhotoPaletteCopyWith<$Res>
    implements $FirebasePhotoPaletteCopyWith<$Res> {
  factory _$FirebasePhotoPaletteCopyWith(_FirebasePhotoPalette value,
          $Res Function(_FirebasePhotoPalette) then) =
      __$FirebasePhotoPaletteCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey() @HexStringColorConverter() Color vibrant,
      @JsonKey() @HexStringColorConverter() Color muted,
      @JsonKey() @HexStringColorConverter() Color lightMuted,
      @JsonKey() @HexStringColorConverter() Color darkMuted,
      @JsonKey() @HexStringColorConverter() Color lightVibrant,
      @JsonKey() @HexStringColorConverter() Color darkVibrant});
}

/// @nodoc
class __$FirebasePhotoPaletteCopyWithImpl<$Res>
    extends _$FirebasePhotoPaletteCopyWithImpl<$Res>
    implements _$FirebasePhotoPaletteCopyWith<$Res> {
  __$FirebasePhotoPaletteCopyWithImpl(
      _FirebasePhotoPalette _value, $Res Function(_FirebasePhotoPalette) _then)
      : super(_value, (v) => _then(v as _FirebasePhotoPalette));

  @override
  _FirebasePhotoPalette get _value => super._value as _FirebasePhotoPalette;

  @override
  $Res call({
    Object vibrant = freezed,
    Object muted = freezed,
    Object lightMuted = freezed,
    Object darkMuted = freezed,
    Object lightVibrant = freezed,
    Object darkVibrant = freezed,
  }) {
    return _then(_FirebasePhotoPalette(
      vibrant: vibrant == freezed ? _value.vibrant : vibrant as Color,
      muted: muted == freezed ? _value.muted : muted as Color,
      lightMuted:
          lightMuted == freezed ? _value.lightMuted : lightMuted as Color,
      darkMuted: darkMuted == freezed ? _value.darkMuted : darkMuted as Color,
      lightVibrant:
          lightVibrant == freezed ? _value.lightVibrant : lightVibrant as Color,
      darkVibrant:
          darkVibrant == freezed ? _value.darkVibrant : darkVibrant as Color,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirebasePhotoPalette
    with DiagnosticableTreeMixin
    implements _FirebasePhotoPalette {
  _$_FirebasePhotoPalette(
      {@JsonKey() @HexStringColorConverter() this.vibrant,
      @JsonKey() @HexStringColorConverter() this.muted,
      @JsonKey() @HexStringColorConverter() this.lightMuted,
      @JsonKey() @HexStringColorConverter() this.darkMuted,
      @JsonKey() @HexStringColorConverter() this.lightVibrant,
      @JsonKey() @HexStringColorConverter() this.darkVibrant});

  factory _$_FirebasePhotoPalette.fromJson(Map<String, dynamic> json) =>
      _$_$_FirebasePhotoPaletteFromJson(json);

  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color vibrant;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color muted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color lightMuted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color darkMuted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color lightVibrant;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color darkVibrant;

  bool _diddominant = false;
  Color _dominant;

  @override
  Color get dominant {
    if (_diddominant == false) {
      _diddominant = true;
      _dominant = vibrant ??
          muted ??
          lightVibrant ??
          lightMuted ??
          darkVibrant ??
          darkMuted;
    }
    return _dominant;
  }

  bool _didfirstVibrant = false;
  Color _firstVibrant;

  @override
  Color get firstVibrant {
    if (_didfirstVibrant == false) {
      _didfirstVibrant = true;
      _firstVibrant = vibrant ?? lightVibrant ?? darkVibrant;
    }
    return _firstVibrant;
  }

  bool _didfirstMuted = false;
  Color _firstMuted;

  @override
  Color get firstMuted {
    if (_didfirstMuted == false) {
      _didfirstMuted = true;
      _firstMuted = muted ?? lightMuted ?? darkMuted;
    }
    return _firstMuted;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhotoPalette(vibrant: $vibrant, muted: $muted, lightMuted: $lightMuted, darkMuted: $darkMuted, lightVibrant: $lightVibrant, darkVibrant: $darkVibrant, dominant: $dominant, firstVibrant: $firstVibrant, firstMuted: $firstMuted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirebasePhotoPalette'))
      ..add(DiagnosticsProperty('vibrant', vibrant))
      ..add(DiagnosticsProperty('muted', muted))
      ..add(DiagnosticsProperty('lightMuted', lightMuted))
      ..add(DiagnosticsProperty('darkMuted', darkMuted))
      ..add(DiagnosticsProperty('lightVibrant', lightVibrant))
      ..add(DiagnosticsProperty('darkVibrant', darkVibrant))
      ..add(DiagnosticsProperty('dominant', dominant))
      ..add(DiagnosticsProperty('firstVibrant', firstVibrant))
      ..add(DiagnosticsProperty('firstMuted', firstMuted));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirebasePhotoPalette &&
            (identical(other.vibrant, vibrant) ||
                const DeepCollectionEquality()
                    .equals(other.vibrant, vibrant)) &&
            (identical(other.muted, muted) ||
                const DeepCollectionEquality().equals(other.muted, muted)) &&
            (identical(other.lightMuted, lightMuted) ||
                const DeepCollectionEquality()
                    .equals(other.lightMuted, lightMuted)) &&
            (identical(other.darkMuted, darkMuted) ||
                const DeepCollectionEquality()
                    .equals(other.darkMuted, darkMuted)) &&
            (identical(other.lightVibrant, lightVibrant) ||
                const DeepCollectionEquality()
                    .equals(other.lightVibrant, lightVibrant)) &&
            (identical(other.darkVibrant, darkVibrant) ||
                const DeepCollectionEquality()
                    .equals(other.darkVibrant, darkVibrant)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(vibrant) ^
      const DeepCollectionEquality().hash(muted) ^
      const DeepCollectionEquality().hash(lightMuted) ^
      const DeepCollectionEquality().hash(darkMuted) ^
      const DeepCollectionEquality().hash(lightVibrant) ^
      const DeepCollectionEquality().hash(darkVibrant);

  @JsonKey(ignore: true)
  @override
  _$FirebasePhotoPaletteCopyWith<_FirebasePhotoPalette> get copyWith =>
      __$FirebasePhotoPaletteCopyWithImpl<_FirebasePhotoPalette>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirebasePhotoPaletteToJson(this);
  }
}

abstract class _FirebasePhotoPalette implements FirebasePhotoPalette {
  factory _FirebasePhotoPalette(
          {@JsonKey() @HexStringColorConverter() Color vibrant,
          @JsonKey() @HexStringColorConverter() Color muted,
          @JsonKey() @HexStringColorConverter() Color lightMuted,
          @JsonKey() @HexStringColorConverter() Color darkMuted,
          @JsonKey() @HexStringColorConverter() Color lightVibrant,
          @JsonKey() @HexStringColorConverter() Color darkVibrant}) =
      _$_FirebasePhotoPalette;

  factory _FirebasePhotoPalette.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhotoPalette.fromJson;

  @override
  @JsonKey()
  @HexStringColorConverter()
  Color get vibrant;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color get muted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color get lightMuted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color get darkMuted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color get lightVibrant;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color get darkVibrant;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoPaletteCopyWith<_FirebasePhotoPalette> get copyWith;
}

FirebasePhoto _$FirebasePhotoFromJson(Map<String, dynamic> json) {
  return _FirebasePhoto.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoTearOff {
  const _$FirebasePhotoTearOff();

// ignore: unused_element
  _FirebasePhoto call(
      {@required @JsonKey() FirebasePhotoType type,
      @required @JsonKey() String id,
      @required @JsonKey() String hash,
      @JsonKey() FirebasePhotoBlurData blur,
      @JsonKey() FirebasePhotoPalette palette,
      @JsonKey() FirebasePhotoFaceData face,
      @required @JsonKey() num width,
      @required @JsonKey() num height,
      @JsonKey(defaultValue: false) bool hasLarge = false}) {
    return _FirebasePhoto(
      type: type,
      id: id,
      hash: hash,
      blur: blur,
      palette: palette,
      face: face,
      width: width,
      height: height,
      hasLarge: hasLarge,
    );
  }

// ignore: unused_element
  FirebasePhoto fromJson(Map<String, Object> json) {
    return FirebasePhoto.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $FirebasePhoto = _$FirebasePhotoTearOff();

/// @nodoc
mixin _$FirebasePhoto {
  /// Type of this [FirebasePhoto].
  @JsonKey()
  FirebasePhotoType get type;

  /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
  @JsonKey()
  String get id;

  /// Hash that serves as the filename of this photo.
  @JsonKey()
  String get hash;

  /// Blurhash of the photo.
  @JsonKey()
  FirebasePhotoBlurData get blur;

  /// Color palette of the photo.
  @JsonKey()
  FirebasePhotoPalette get palette;

  /// Face rect inside the photo.
  @JsonKey()
  FirebasePhotoFaceData get face;

  /// Width of the photo.
  @JsonKey()
  num get width;

  /// Height of the photo.
  @JsonKey()
  num get height;

  /// Wether the photo also has a large version.
  @JsonKey(defaultValue: false)
  bool get hasLarge;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $FirebasePhotoCopyWith<FirebasePhoto> get copyWith;
}

/// @nodoc
abstract class $FirebasePhotoCopyWith<$Res> {
  factory $FirebasePhotoCopyWith(
          FirebasePhoto value, $Res Function(FirebasePhoto) then) =
      _$FirebasePhotoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() FirebasePhotoType type,
      @JsonKey() String id,
      @JsonKey() String hash,
      @JsonKey() FirebasePhotoBlurData blur,
      @JsonKey() FirebasePhotoPalette palette,
      @JsonKey() FirebasePhotoFaceData face,
      @JsonKey() num width,
      @JsonKey() num height,
      @JsonKey(defaultValue: false) bool hasLarge});

  $FirebasePhotoBlurDataCopyWith<$Res> get blur;
  $FirebasePhotoPaletteCopyWith<$Res> get palette;
  $FirebasePhotoFaceDataCopyWith<$Res> get face;
}

/// @nodoc
class _$FirebasePhotoCopyWithImpl<$Res>
    implements $FirebasePhotoCopyWith<$Res> {
  _$FirebasePhotoCopyWithImpl(this._value, this._then);

  final FirebasePhoto _value;
  // ignore: unused_field
  final $Res Function(FirebasePhoto) _then;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object hash = freezed,
    Object blur = freezed,
    Object palette = freezed,
    Object face = freezed,
    Object width = freezed,
    Object height = freezed,
    Object hasLarge = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as FirebasePhotoType,
      id: id == freezed ? _value.id : id as String,
      hash: hash == freezed ? _value.hash : hash as String,
      blur: blur == freezed ? _value.blur : blur as FirebasePhotoBlurData,
      palette:
          palette == freezed ? _value.palette : palette as FirebasePhotoPalette,
      face: face == freezed ? _value.face : face as FirebasePhotoFaceData,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
      hasLarge: hasLarge == freezed ? _value.hasLarge : hasLarge as bool,
    ));
  }

  @override
  $FirebasePhotoBlurDataCopyWith<$Res> get blur {
    if (_value.blur == null) {
      return null;
    }
    return $FirebasePhotoBlurDataCopyWith<$Res>(_value.blur, (value) {
      return _then(_value.copyWith(blur: value));
    });
  }

  @override
  $FirebasePhotoPaletteCopyWith<$Res> get palette {
    if (_value.palette == null) {
      return null;
    }
    return $FirebasePhotoPaletteCopyWith<$Res>(_value.palette, (value) {
      return _then(_value.copyWith(palette: value));
    });
  }

  @override
  $FirebasePhotoFaceDataCopyWith<$Res> get face {
    if (_value.face == null) {
      return null;
    }
    return $FirebasePhotoFaceDataCopyWith<$Res>(_value.face, (value) {
      return _then(_value.copyWith(face: value));
    });
  }
}

/// @nodoc
abstract class _$FirebasePhotoCopyWith<$Res>
    implements $FirebasePhotoCopyWith<$Res> {
  factory _$FirebasePhotoCopyWith(
          _FirebasePhoto value, $Res Function(_FirebasePhoto) then) =
      __$FirebasePhotoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey() FirebasePhotoType type,
      @JsonKey() String id,
      @JsonKey() String hash,
      @JsonKey() FirebasePhotoBlurData blur,
      @JsonKey() FirebasePhotoPalette palette,
      @JsonKey() FirebasePhotoFaceData face,
      @JsonKey() num width,
      @JsonKey() num height,
      @JsonKey(defaultValue: false) bool hasLarge});

  @override
  $FirebasePhotoBlurDataCopyWith<$Res> get blur;
  @override
  $FirebasePhotoPaletteCopyWith<$Res> get palette;
  @override
  $FirebasePhotoFaceDataCopyWith<$Res> get face;
}

/// @nodoc
class __$FirebasePhotoCopyWithImpl<$Res>
    extends _$FirebasePhotoCopyWithImpl<$Res>
    implements _$FirebasePhotoCopyWith<$Res> {
  __$FirebasePhotoCopyWithImpl(
      _FirebasePhoto _value, $Res Function(_FirebasePhoto) _then)
      : super(_value, (v) => _then(v as _FirebasePhoto));

  @override
  _FirebasePhoto get _value => super._value as _FirebasePhoto;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object hash = freezed,
    Object blur = freezed,
    Object palette = freezed,
    Object face = freezed,
    Object width = freezed,
    Object height = freezed,
    Object hasLarge = freezed,
  }) {
    return _then(_FirebasePhoto(
      type: type == freezed ? _value.type : type as FirebasePhotoType,
      id: id == freezed ? _value.id : id as String,
      hash: hash == freezed ? _value.hash : hash as String,
      blur: blur == freezed ? _value.blur : blur as FirebasePhotoBlurData,
      palette:
          palette == freezed ? _value.palette : palette as FirebasePhotoPalette,
      face: face == freezed ? _value.face : face as FirebasePhotoFaceData,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
      hasLarge: hasLarge == freezed ? _value.hasLarge : hasLarge as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_FirebasePhoto extends _FirebasePhoto with DiagnosticableTreeMixin {
  _$_FirebasePhoto(
      {@required @JsonKey() this.type,
      @required @JsonKey() this.id,
      @required @JsonKey() this.hash,
      @JsonKey() this.blur,
      @JsonKey() this.palette,
      @JsonKey() this.face,
      @required @JsonKey() this.width,
      @required @JsonKey() this.height,
      @JsonKey(defaultValue: false) this.hasLarge = false})
      : assert(type != null),
        assert(id != null),
        assert(hash != null),
        assert(width != null),
        assert(height != null),
        assert(hasLarge != null),
        super._();

  factory _$_FirebasePhoto.fromJson(Map<String, dynamic> json) =>
      _$_$_FirebasePhotoFromJson(json);

  @override

  /// Type of this [FirebasePhoto].
  @JsonKey()
  final FirebasePhotoType type;
  @override

  /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
  @JsonKey()
  final String id;
  @override

  /// Hash that serves as the filename of this photo.
  @JsonKey()
  final String hash;
  @override

  /// Blurhash of the photo.
  @JsonKey()
  final FirebasePhotoBlurData blur;
  @override

  /// Color palette of the photo.
  @JsonKey()
  final FirebasePhotoPalette palette;
  @override

  /// Face rect inside the photo.
  @JsonKey()
  final FirebasePhotoFaceData face;
  @override

  /// Width of the photo.
  @JsonKey()
  final num width;
  @override

  /// Height of the photo.
  @JsonKey()
  final num height;
  @override

  /// Wether the photo also has a large version.
  @JsonKey(defaultValue: false)
  final bool hasLarge;

  bool _didsize = false;
  Size _size;

  @override
  Size get size {
    if (_didsize == false) {
      _didsize = true;
      _size = Size(width.toDouble(), height.toDouble());
    }
    return _size;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhoto(type: $type, id: $id, hash: $hash, blur: $blur, palette: $palette, face: $face, width: $width, height: $height, hasLarge: $hasLarge, size: $size)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirebasePhoto'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('hash', hash))
      ..add(DiagnosticsProperty('blur', blur))
      ..add(DiagnosticsProperty('palette', palette))
      ..add(DiagnosticsProperty('face', face))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('hasLarge', hasLarge))
      ..add(DiagnosticsProperty('size', size));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirebasePhoto &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.hash, hash) ||
                const DeepCollectionEquality().equals(other.hash, hash)) &&
            (identical(other.blur, blur) ||
                const DeepCollectionEquality().equals(other.blur, blur)) &&
            (identical(other.palette, palette) ||
                const DeepCollectionEquality()
                    .equals(other.palette, palette)) &&
            (identical(other.face, face) ||
                const DeepCollectionEquality().equals(other.face, face)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.hasLarge, hasLarge) ||
                const DeepCollectionEquality()
                    .equals(other.hasLarge, hasLarge)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(hash) ^
      const DeepCollectionEquality().hash(blur) ^
      const DeepCollectionEquality().hash(palette) ^
      const DeepCollectionEquality().hash(face) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(hasLarge);

  @JsonKey(ignore: true)
  @override
  _$FirebasePhotoCopyWith<_FirebasePhoto> get copyWith =>
      __$FirebasePhotoCopyWithImpl<_FirebasePhoto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FirebasePhotoToJson(this);
  }
}

abstract class _FirebasePhoto extends FirebasePhoto {
  _FirebasePhoto._() : super._();
  factory _FirebasePhoto(
      {@required @JsonKey() FirebasePhotoType type,
      @required @JsonKey() String id,
      @required @JsonKey() String hash,
      @JsonKey() FirebasePhotoBlurData blur,
      @JsonKey() FirebasePhotoPalette palette,
      @JsonKey() FirebasePhotoFaceData face,
      @required @JsonKey() num width,
      @required @JsonKey() num height,
      @JsonKey(defaultValue: false) bool hasLarge}) = _$_FirebasePhoto;

  factory _FirebasePhoto.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhoto.fromJson;

  @override

  /// Type of this [FirebasePhoto].
  @JsonKey()
  FirebasePhotoType get type;
  @override

  /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
  @JsonKey()
  String get id;
  @override

  /// Hash that serves as the filename of this photo.
  @JsonKey()
  String get hash;
  @override

  /// Blurhash of the photo.
  @JsonKey()
  FirebasePhotoBlurData get blur;
  @override

  /// Color palette of the photo.
  @JsonKey()
  FirebasePhotoPalette get palette;
  @override

  /// Face rect inside the photo.
  @JsonKey()
  FirebasePhotoFaceData get face;
  @override

  /// Width of the photo.
  @JsonKey()
  num get width;
  @override

  /// Height of the photo.
  @JsonKey()
  num get height;
  @override

  /// Wether the photo also has a large version.
  @JsonKey(defaultValue: false)
  bool get hasLarge;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoCopyWith<_FirebasePhoto> get copyWith;
}
