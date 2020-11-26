// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'impl.dart';

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
  _$FirebasePhotoBlurDataCopyWith<_FirebasePhotoBlurData> get copyWith;
}
