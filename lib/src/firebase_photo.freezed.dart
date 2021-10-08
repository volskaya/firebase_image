// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'firebase_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirebasePhotoBlurData _$FirebasePhotoBlurDataFromJson(
    Map<String, dynamic> json) {
  return _FirebasePhotoBlurData.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoBlurDataTearOff {
  const _$FirebasePhotoBlurDataTearOff();

  _FirebasePhotoBlurData call(
      {@JsonKey() required String hash,
      @JsonKey() required num width,
      @JsonKey() required num height}) {
    return _FirebasePhotoBlurData(
      hash: hash,
      width: width,
      height: height,
    );
  }

  FirebasePhotoBlurData fromJson(Map<String, Object> json) {
    return FirebasePhotoBlurData.fromJson(json);
  }
}

/// @nodoc
const $FirebasePhotoBlurData = _$FirebasePhotoBlurDataTearOff();

/// @nodoc
mixin _$FirebasePhotoBlurData {
  /// Blurhash.
  @JsonKey()
  String get hash => throw _privateConstructorUsedError;

  /// Width of the blurhash.
  @JsonKey()
  num get width => throw _privateConstructorUsedError;

  /// Height of the blurhash.
  @JsonKey()
  num get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebasePhotoBlurDataCopyWith<FirebasePhotoBlurData> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? hash = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as num,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as num,
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
    Object? hash = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_FirebasePhotoBlurData(
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as num,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirebasePhotoBlurData extends _FirebasePhotoBlurData
    with DiagnosticableTreeMixin {
  _$_FirebasePhotoBlurData(
      {@JsonKey() required this.hash,
      @JsonKey() required this.width,
      @JsonKey() required this.height})
      : super._();

  factory _$_FirebasePhotoBlurData.fromJson(Map<String, dynamic> json) =>
      _$$_FirebasePhotoBlurDataFromJson(json);

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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhotoBlurData(hash: $hash, width: $width, height: $height)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirebasePhotoBlurData'))
      ..add(DiagnosticsProperty('hash', hash))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height));
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
    return _$$_FirebasePhotoBlurDataToJson(this);
  }
}

abstract class _FirebasePhotoBlurData extends FirebasePhotoBlurData {
  factory _FirebasePhotoBlurData(
      {@JsonKey() required String hash,
      @JsonKey() required num width,
      @JsonKey() required num height}) = _$_FirebasePhotoBlurData;
  _FirebasePhotoBlurData._() : super._();

  factory _FirebasePhotoBlurData.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhotoBlurData.fromJson;

  @override

  /// Blurhash.
  @JsonKey()
  String get hash => throw _privateConstructorUsedError;
  @override

  /// Width of the blurhash.
  @JsonKey()
  num get width => throw _privateConstructorUsedError;
  @override

  /// Height of the blurhash.
  @JsonKey()
  num get height => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoBlurDataCopyWith<_FirebasePhotoBlurData> get copyWith =>
      throw _privateConstructorUsedError;
}

FirebasePhotoFaceData _$FirebasePhotoFaceDataFromJson(
    Map<String, dynamic> json) {
  return _FirebasePhotoFaceData.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoFaceDataTearOff {
  const _$FirebasePhotoFaceDataTearOff();

  _FirebasePhotoFaceData call(
      {@JsonKey() required num x,
      @JsonKey() required num y,
      @JsonKey() required num width,
      @JsonKey() required num height,
      @JsonKey() @SizeConverter() required Size size}) {
    return _FirebasePhotoFaceData(
      x: x,
      y: y,
      width: width,
      height: height,
      size: size,
    );
  }

  FirebasePhotoFaceData fromJson(Map<String, Object> json) {
    return FirebasePhotoFaceData.fromJson(json);
  }
}

/// @nodoc
const $FirebasePhotoFaceData = _$FirebasePhotoFaceDataTearOff();

/// @nodoc
mixin _$FirebasePhotoFaceData {
  /// Left side of the face rect.
  @JsonKey()
  num get x => throw _privateConstructorUsedError;

  /// Top side of the face rect.
  @JsonKey()
  num get y => throw _privateConstructorUsedError;

  /// Width of the face rect.
  @JsonKey()
  num get width => throw _privateConstructorUsedError;

  /// Height of the face rect.
  @JsonKey()
  num get height => throw _privateConstructorUsedError;

  /// Size of the image that overlaps this face rect.
  @JsonKey()
  @SizeConverter()
  Size get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebasePhotoFaceDataCopyWith<FirebasePhotoFaceData> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? x = freezed,
    Object? y = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as num,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as num,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as num,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as num,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
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
    Object? x = freezed,
    Object? y = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? size = freezed,
  }) {
    return _then(_FirebasePhotoFaceData(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as num,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as num,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as num,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as num,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirebasePhotoFaceData extends _FirebasePhotoFaceData
    with DiagnosticableTreeMixin {
  _$_FirebasePhotoFaceData(
      {@JsonKey() required this.x,
      @JsonKey() required this.y,
      @JsonKey() required this.width,
      @JsonKey() required this.height,
      @JsonKey() @SizeConverter() required this.size})
      : super._();

  factory _$_FirebasePhotoFaceData.fromJson(Map<String, dynamic> json) =>
      _$$_FirebasePhotoFaceDataFromJson(json);

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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhotoFaceData(x: $x, y: $y, width: $width, height: $height, size: $size)';
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
      ..add(DiagnosticsProperty('size', size));
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
    return _$$_FirebasePhotoFaceDataToJson(this);
  }
}

abstract class _FirebasePhotoFaceData extends FirebasePhotoFaceData {
  factory _FirebasePhotoFaceData(
          {@JsonKey() required num x,
          @JsonKey() required num y,
          @JsonKey() required num width,
          @JsonKey() required num height,
          @JsonKey() @SizeConverter() required Size size}) =
      _$_FirebasePhotoFaceData;
  _FirebasePhotoFaceData._() : super._();

  factory _FirebasePhotoFaceData.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhotoFaceData.fromJson;

  @override

  /// Left side of the face rect.
  @JsonKey()
  num get x => throw _privateConstructorUsedError;
  @override

  /// Top side of the face rect.
  @JsonKey()
  num get y => throw _privateConstructorUsedError;
  @override

  /// Width of the face rect.
  @JsonKey()
  num get width => throw _privateConstructorUsedError;
  @override

  /// Height of the face rect.
  @JsonKey()
  num get height => throw _privateConstructorUsedError;
  @override

  /// Size of the image that overlaps this face rect.
  @JsonKey()
  @SizeConverter()
  Size get size => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoFaceDataCopyWith<_FirebasePhotoFaceData> get copyWith =>
      throw _privateConstructorUsedError;
}

FirebasePhotoPalette _$FirebasePhotoPaletteFromJson(Map<String, dynamic> json) {
  return _FirebasePhotoPalette.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoPaletteTearOff {
  const _$FirebasePhotoPaletteTearOff();

  _FirebasePhotoPalette call(
      {@JsonKey() @HexStringColorConverter() Color? vibrant,
      @JsonKey() @HexStringColorConverter() Color? muted,
      @JsonKey() @HexStringColorConverter() Color? lightMuted,
      @JsonKey() @HexStringColorConverter() Color? darkMuted,
      @JsonKey() @HexStringColorConverter() Color? lightVibrant,
      @JsonKey() @HexStringColorConverter() Color? darkVibrant}) {
    return _FirebasePhotoPalette(
      vibrant: vibrant,
      muted: muted,
      lightMuted: lightMuted,
      darkMuted: darkMuted,
      lightVibrant: lightVibrant,
      darkVibrant: darkVibrant,
    );
  }

  FirebasePhotoPalette fromJson(Map<String, Object> json) {
    return FirebasePhotoPalette.fromJson(json);
  }
}

/// @nodoc
const $FirebasePhotoPalette = _$FirebasePhotoPaletteTearOff();

/// @nodoc
mixin _$FirebasePhotoPalette {
  @JsonKey()
  @HexStringColorConverter()
  Color? get vibrant => throw _privateConstructorUsedError;
  @JsonKey()
  @HexStringColorConverter()
  Color? get muted => throw _privateConstructorUsedError;
  @JsonKey()
  @HexStringColorConverter()
  Color? get lightMuted => throw _privateConstructorUsedError;
  @JsonKey()
  @HexStringColorConverter()
  Color? get darkMuted => throw _privateConstructorUsedError;
  @JsonKey()
  @HexStringColorConverter()
  Color? get lightVibrant => throw _privateConstructorUsedError;
  @JsonKey()
  @HexStringColorConverter()
  Color? get darkVibrant => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebasePhotoPaletteCopyWith<FirebasePhotoPalette> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebasePhotoPaletteCopyWith<$Res> {
  factory $FirebasePhotoPaletteCopyWith(FirebasePhotoPalette value,
          $Res Function(FirebasePhotoPalette) then) =
      _$FirebasePhotoPaletteCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() @HexStringColorConverter() Color? vibrant,
      @JsonKey() @HexStringColorConverter() Color? muted,
      @JsonKey() @HexStringColorConverter() Color? lightMuted,
      @JsonKey() @HexStringColorConverter() Color? darkMuted,
      @JsonKey() @HexStringColorConverter() Color? lightVibrant,
      @JsonKey() @HexStringColorConverter() Color? darkVibrant});
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
    Object? vibrant = freezed,
    Object? muted = freezed,
    Object? lightMuted = freezed,
    Object? darkMuted = freezed,
    Object? lightVibrant = freezed,
    Object? darkVibrant = freezed,
  }) {
    return _then(_value.copyWith(
      vibrant: vibrant == freezed
          ? _value.vibrant
          : vibrant // ignore: cast_nullable_to_non_nullable
              as Color?,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as Color?,
      lightMuted: lightMuted == freezed
          ? _value.lightMuted
          : lightMuted // ignore: cast_nullable_to_non_nullable
              as Color?,
      darkMuted: darkMuted == freezed
          ? _value.darkMuted
          : darkMuted // ignore: cast_nullable_to_non_nullable
              as Color?,
      lightVibrant: lightVibrant == freezed
          ? _value.lightVibrant
          : lightVibrant // ignore: cast_nullable_to_non_nullable
              as Color?,
      darkVibrant: darkVibrant == freezed
          ? _value.darkVibrant
          : darkVibrant // ignore: cast_nullable_to_non_nullable
              as Color?,
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
      {@JsonKey() @HexStringColorConverter() Color? vibrant,
      @JsonKey() @HexStringColorConverter() Color? muted,
      @JsonKey() @HexStringColorConverter() Color? lightMuted,
      @JsonKey() @HexStringColorConverter() Color? darkMuted,
      @JsonKey() @HexStringColorConverter() Color? lightVibrant,
      @JsonKey() @HexStringColorConverter() Color? darkVibrant});
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
    Object? vibrant = freezed,
    Object? muted = freezed,
    Object? lightMuted = freezed,
    Object? darkMuted = freezed,
    Object? lightVibrant = freezed,
    Object? darkVibrant = freezed,
  }) {
    return _then(_FirebasePhotoPalette(
      vibrant: vibrant == freezed
          ? _value.vibrant
          : vibrant // ignore: cast_nullable_to_non_nullable
              as Color?,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as Color?,
      lightMuted: lightMuted == freezed
          ? _value.lightMuted
          : lightMuted // ignore: cast_nullable_to_non_nullable
              as Color?,
      darkMuted: darkMuted == freezed
          ? _value.darkMuted
          : darkMuted // ignore: cast_nullable_to_non_nullable
              as Color?,
      lightVibrant: lightVibrant == freezed
          ? _value.lightVibrant
          : lightVibrant // ignore: cast_nullable_to_non_nullable
              as Color?,
      darkVibrant: darkVibrant == freezed
          ? _value.darkVibrant
          : darkVibrant // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirebasePhotoPalette extends _FirebasePhotoPalette
    with DiagnosticableTreeMixin {
  _$_FirebasePhotoPalette(
      {@JsonKey() @HexStringColorConverter() this.vibrant,
      @JsonKey() @HexStringColorConverter() this.muted,
      @JsonKey() @HexStringColorConverter() this.lightMuted,
      @JsonKey() @HexStringColorConverter() this.darkMuted,
      @JsonKey() @HexStringColorConverter() this.lightVibrant,
      @JsonKey() @HexStringColorConverter() this.darkVibrant})
      : super._();

  factory _$_FirebasePhotoPalette.fromJson(Map<String, dynamic> json) =>
      _$$_FirebasePhotoPaletteFromJson(json);

  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color? vibrant;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color? muted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color? lightMuted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color? darkMuted;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color? lightVibrant;
  @override
  @JsonKey()
  @HexStringColorConverter()
  final Color? darkVibrant;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhotoPalette(vibrant: $vibrant, muted: $muted, lightMuted: $lightMuted, darkMuted: $darkMuted, lightVibrant: $lightVibrant, darkVibrant: $darkVibrant)';
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
      ..add(DiagnosticsProperty('darkVibrant', darkVibrant));
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
    return _$$_FirebasePhotoPaletteToJson(this);
  }
}

abstract class _FirebasePhotoPalette extends FirebasePhotoPalette {
  factory _FirebasePhotoPalette(
          {@JsonKey() @HexStringColorConverter() Color? vibrant,
          @JsonKey() @HexStringColorConverter() Color? muted,
          @JsonKey() @HexStringColorConverter() Color? lightMuted,
          @JsonKey() @HexStringColorConverter() Color? darkMuted,
          @JsonKey() @HexStringColorConverter() Color? lightVibrant,
          @JsonKey() @HexStringColorConverter() Color? darkVibrant}) =
      _$_FirebasePhotoPalette;
  _FirebasePhotoPalette._() : super._();

  factory _FirebasePhotoPalette.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhotoPalette.fromJson;

  @override
  @JsonKey()
  @HexStringColorConverter()
  Color? get vibrant => throw _privateConstructorUsedError;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color? get muted => throw _privateConstructorUsedError;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color? get lightMuted => throw _privateConstructorUsedError;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color? get darkMuted => throw _privateConstructorUsedError;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color? get lightVibrant => throw _privateConstructorUsedError;
  @override
  @JsonKey()
  @HexStringColorConverter()
  Color? get darkVibrant => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoPaletteCopyWith<_FirebasePhotoPalette> get copyWith =>
      throw _privateConstructorUsedError;
}

FirebasePhoto _$FirebasePhotoFromJson(Map<String, dynamic> json) {
  return _FirebasePhoto.fromJson(json);
}

/// @nodoc
class _$FirebasePhotoTearOff {
  const _$FirebasePhotoTearOff();

  _FirebasePhoto call(
      {@JsonKey() required FirebasePhotoType type,
      @JsonKey() required String id,
      @JsonKey() required String hash,
      @JsonKey() FirebasePhotoBlurData? blur,
      @JsonKey() FirebasePhotoPalette? palette,
      @JsonKey() @HexStringColorConverter() Color? color,
      @JsonKey() FirebasePhotoFaceData? face,
      @JsonKey() required num width,
      @JsonKey() required num height,
      @JsonKey() bool hasLarge = false,
      @JsonKey() required String regularURL,
      @JsonKey() required String? thumbnailURL}) {
    return _FirebasePhoto(
      type: type,
      id: id,
      hash: hash,
      blur: blur,
      palette: palette,
      color: color,
      face: face,
      width: width,
      height: height,
      hasLarge: hasLarge,
      regularURL: regularURL,
      thumbnailURL: thumbnailURL,
    );
  }

  FirebasePhoto fromJson(Map<String, Object> json) {
    return FirebasePhoto.fromJson(json);
  }
}

/// @nodoc
const $FirebasePhoto = _$FirebasePhotoTearOff();

/// @nodoc
mixin _$FirebasePhoto {
  /// Type of this [FirebasePhoto].
  @JsonKey()
  FirebasePhotoType get type => throw _privateConstructorUsedError;

  /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
  @JsonKey()
  String get id => throw _privateConstructorUsedError;

  /// Hash that serves as the filename of this photo.
  @JsonKey()
  String get hash => throw _privateConstructorUsedError;

  /// Blurhash of the photo.
  @JsonKey()
  FirebasePhotoBlurData? get blur => throw _privateConstructorUsedError;

  /// Color palette of the photo.
  @JsonKey()
  FirebasePhotoPalette? get palette => throw _privateConstructorUsedError;

  /// Most used color in the photo.
  @JsonKey()
  @HexStringColorConverter()
  Color? get color => throw _privateConstructorUsedError;

  /// Face rect inside the photo.
  @JsonKey()
  FirebasePhotoFaceData? get face => throw _privateConstructorUsedError;

  /// Width of the photo.
  @JsonKey()
  num get width => throw _privateConstructorUsedError;

  /// Height of the photo.
  @JsonKey()
  num get height => throw _privateConstructorUsedError;

  /// Wether the photo also has a large version.
  @JsonKey()
  bool get hasLarge => throw _privateConstructorUsedError;

  /// Public URL of the regular photo.
  @JsonKey()
  String get regularURL => throw _privateConstructorUsedError;

  /// Public URL of the regular photo.
  @JsonKey()
  String? get thumbnailURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirebasePhotoCopyWith<FirebasePhoto> get copyWith =>
      throw _privateConstructorUsedError;
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
      @JsonKey() FirebasePhotoBlurData? blur,
      @JsonKey() FirebasePhotoPalette? palette,
      @JsonKey() @HexStringColorConverter() Color? color,
      @JsonKey() FirebasePhotoFaceData? face,
      @JsonKey() num width,
      @JsonKey() num height,
      @JsonKey() bool hasLarge,
      @JsonKey() String regularURL,
      @JsonKey() String? thumbnailURL});

  $FirebasePhotoBlurDataCopyWith<$Res>? get blur;
  $FirebasePhotoPaletteCopyWith<$Res>? get palette;
  $FirebasePhotoFaceDataCopyWith<$Res>? get face;
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
    Object? type = freezed,
    Object? id = freezed,
    Object? hash = freezed,
    Object? blur = freezed,
    Object? palette = freezed,
    Object? color = freezed,
    Object? face = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? hasLarge = freezed,
    Object? regularURL = freezed,
    Object? thumbnailURL = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoType,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      blur: blur == freezed
          ? _value.blur
          : blur // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoBlurData?,
      palette: palette == freezed
          ? _value.palette
          : palette // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoPalette?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      face: face == freezed
          ? _value.face
          : face // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoFaceData?,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as num,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as num,
      hasLarge: hasLarge == freezed
          ? _value.hasLarge
          : hasLarge // ignore: cast_nullable_to_non_nullable
              as bool,
      regularURL: regularURL == freezed
          ? _value.regularURL
          : regularURL // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailURL: thumbnailURL == freezed
          ? _value.thumbnailURL
          : thumbnailURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $FirebasePhotoBlurDataCopyWith<$Res>? get blur {
    if (_value.blur == null) {
      return null;
    }

    return $FirebasePhotoBlurDataCopyWith<$Res>(_value.blur!, (value) {
      return _then(_value.copyWith(blur: value));
    });
  }

  @override
  $FirebasePhotoPaletteCopyWith<$Res>? get palette {
    if (_value.palette == null) {
      return null;
    }

    return $FirebasePhotoPaletteCopyWith<$Res>(_value.palette!, (value) {
      return _then(_value.copyWith(palette: value));
    });
  }

  @override
  $FirebasePhotoFaceDataCopyWith<$Res>? get face {
    if (_value.face == null) {
      return null;
    }

    return $FirebasePhotoFaceDataCopyWith<$Res>(_value.face!, (value) {
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
      @JsonKey() FirebasePhotoBlurData? blur,
      @JsonKey() FirebasePhotoPalette? palette,
      @JsonKey() @HexStringColorConverter() Color? color,
      @JsonKey() FirebasePhotoFaceData? face,
      @JsonKey() num width,
      @JsonKey() num height,
      @JsonKey() bool hasLarge,
      @JsonKey() String regularURL,
      @JsonKey() String? thumbnailURL});

  @override
  $FirebasePhotoBlurDataCopyWith<$Res>? get blur;
  @override
  $FirebasePhotoPaletteCopyWith<$Res>? get palette;
  @override
  $FirebasePhotoFaceDataCopyWith<$Res>? get face;
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
    Object? type = freezed,
    Object? id = freezed,
    Object? hash = freezed,
    Object? blur = freezed,
    Object? palette = freezed,
    Object? color = freezed,
    Object? face = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? hasLarge = freezed,
    Object? regularURL = freezed,
    Object? thumbnailURL = freezed,
  }) {
    return _then(_FirebasePhoto(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoType,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      blur: blur == freezed
          ? _value.blur
          : blur // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoBlurData?,
      palette: palette == freezed
          ? _value.palette
          : palette // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoPalette?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      face: face == freezed
          ? _value.face
          : face // ignore: cast_nullable_to_non_nullable
              as FirebasePhotoFaceData?,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as num,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as num,
      hasLarge: hasLarge == freezed
          ? _value.hasLarge
          : hasLarge // ignore: cast_nullable_to_non_nullable
              as bool,
      regularURL: regularURL == freezed
          ? _value.regularURL
          : regularURL // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailURL: thumbnailURL == freezed
          ? _value.thumbnailURL
          : thumbnailURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirebasePhoto extends _FirebasePhoto with DiagnosticableTreeMixin {
  _$_FirebasePhoto(
      {@JsonKey() required this.type,
      @JsonKey() required this.id,
      @JsonKey() required this.hash,
      @JsonKey() this.blur,
      @JsonKey() this.palette,
      @JsonKey() @HexStringColorConverter() this.color,
      @JsonKey() this.face,
      @JsonKey() required this.width,
      @JsonKey() required this.height,
      @JsonKey() this.hasLarge = false,
      @JsonKey() required this.regularURL,
      @JsonKey() required this.thumbnailURL})
      : super._();

  factory _$_FirebasePhoto.fromJson(Map<String, dynamic> json) =>
      _$$_FirebasePhotoFromJson(json);

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
  final FirebasePhotoBlurData? blur;
  @override

  /// Color palette of the photo.
  @JsonKey()
  final FirebasePhotoPalette? palette;
  @override

  /// Most used color in the photo.
  @JsonKey()
  @HexStringColorConverter()
  final Color? color;
  @override

  /// Face rect inside the photo.
  @JsonKey()
  final FirebasePhotoFaceData? face;
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
  @JsonKey()
  final bool hasLarge;
  @override

  /// Public URL of the regular photo.
  @JsonKey()
  final String regularURL;
  @override

  /// Public URL of the regular photo.
  @JsonKey()
  final String? thumbnailURL;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebasePhoto(type: $type, id: $id, hash: $hash, blur: $blur, palette: $palette, color: $color, face: $face, width: $width, height: $height, hasLarge: $hasLarge, regularURL: $regularURL, thumbnailURL: $thumbnailURL)';
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
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('face', face))
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height))
      ..add(DiagnosticsProperty('hasLarge', hasLarge))
      ..add(DiagnosticsProperty('regularURL', regularURL))
      ..add(DiagnosticsProperty('thumbnailURL', thumbnailURL));
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
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.face, face) ||
                const DeepCollectionEquality().equals(other.face, face)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.hasLarge, hasLarge) ||
                const DeepCollectionEquality()
                    .equals(other.hasLarge, hasLarge)) &&
            (identical(other.regularURL, regularURL) ||
                const DeepCollectionEquality()
                    .equals(other.regularURL, regularURL)) &&
            (identical(other.thumbnailURL, thumbnailURL) ||
                const DeepCollectionEquality()
                    .equals(other.thumbnailURL, thumbnailURL)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(hash) ^
      const DeepCollectionEquality().hash(blur) ^
      const DeepCollectionEquality().hash(palette) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(face) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(hasLarge) ^
      const DeepCollectionEquality().hash(regularURL) ^
      const DeepCollectionEquality().hash(thumbnailURL);

  @JsonKey(ignore: true)
  @override
  _$FirebasePhotoCopyWith<_FirebasePhoto> get copyWith =>
      __$FirebasePhotoCopyWithImpl<_FirebasePhoto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirebasePhotoToJson(this);
  }
}

abstract class _FirebasePhoto extends FirebasePhoto {
  factory _FirebasePhoto(
      {@JsonKey() required FirebasePhotoType type,
      @JsonKey() required String id,
      @JsonKey() required String hash,
      @JsonKey() FirebasePhotoBlurData? blur,
      @JsonKey() FirebasePhotoPalette? palette,
      @JsonKey() @HexStringColorConverter() Color? color,
      @JsonKey() FirebasePhotoFaceData? face,
      @JsonKey() required num width,
      @JsonKey() required num height,
      @JsonKey() bool hasLarge,
      @JsonKey() required String regularURL,
      @JsonKey() required String? thumbnailURL}) = _$_FirebasePhoto;
  _FirebasePhoto._() : super._();

  factory _FirebasePhoto.fromJson(Map<String, dynamic> json) =
      _$_FirebasePhoto.fromJson;

  @override

  /// Type of this [FirebasePhoto].
  @JsonKey()
  FirebasePhotoType get type => throw _privateConstructorUsedError;
  @override

  /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
  @JsonKey()
  String get id => throw _privateConstructorUsedError;
  @override

  /// Hash that serves as the filename of this photo.
  @JsonKey()
  String get hash => throw _privateConstructorUsedError;
  @override

  /// Blurhash of the photo.
  @JsonKey()
  FirebasePhotoBlurData? get blur => throw _privateConstructorUsedError;
  @override

  /// Color palette of the photo.
  @JsonKey()
  FirebasePhotoPalette? get palette => throw _privateConstructorUsedError;
  @override

  /// Most used color in the photo.
  @JsonKey()
  @HexStringColorConverter()
  Color? get color => throw _privateConstructorUsedError;
  @override

  /// Face rect inside the photo.
  @JsonKey()
  FirebasePhotoFaceData? get face => throw _privateConstructorUsedError;
  @override

  /// Width of the photo.
  @JsonKey()
  num get width => throw _privateConstructorUsedError;
  @override

  /// Height of the photo.
  @JsonKey()
  num get height => throw _privateConstructorUsedError;
  @override

  /// Wether the photo also has a large version.
  @JsonKey()
  bool get hasLarge => throw _privateConstructorUsedError;
  @override

  /// Public URL of the regular photo.
  @JsonKey()
  String get regularURL => throw _privateConstructorUsedError;
  @override

  /// Public URL of the regular photo.
  @JsonKey()
  String? get thumbnailURL => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirebasePhotoCopyWith<_FirebasePhoto> get copyWith =>
      throw _privateConstructorUsedError;
}
