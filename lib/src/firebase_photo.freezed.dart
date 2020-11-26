// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'firebase_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
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
      @required @JsonKey() num width,
      @required @JsonKey() num height}) {
    return _FirebasePhoto(
      type: type,
      id: id,
      hash: hash,
      blur: blur,
      width: width,
      height: height,
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

  /// Width of the photo.
  @JsonKey()
  num get width;

  /// Height of the photo.
  @JsonKey()
  num get height;

  Map<String, dynamic> toJson();
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
      @JsonKey() num width,
      @JsonKey() num height});

  $FirebasePhotoBlurDataCopyWith<$Res> get blur;
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
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as FirebasePhotoType,
      id: id == freezed ? _value.id : id as String,
      hash: hash == freezed ? _value.hash : hash as String,
      blur: blur == freezed ? _value.blur : blur as FirebasePhotoBlurData,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
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
      @JsonKey() num width,
      @JsonKey() num height});

  @override
  $FirebasePhotoBlurDataCopyWith<$Res> get blur;
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
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_FirebasePhoto(
      type: type == freezed ? _value.type : type as FirebasePhotoType,
      id: id == freezed ? _value.id : id as String,
      hash: hash == freezed ? _value.hash : hash as String,
      blur: blur == freezed ? _value.blur : blur as FirebasePhotoBlurData,
      width: width == freezed ? _value.width : width as num,
      height: height == freezed ? _value.height : height as num,
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
      @required @JsonKey() this.width,
      @required @JsonKey() this.height})
      : assert(type != null),
        assert(id != null),
        assert(hash != null),
        assert(width != null),
        assert(height != null),
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

  /// Width of the photo.
  @JsonKey()
  final num width;
  @override

  /// Height of the photo.
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
    return 'FirebasePhoto(type: $type, id: $id, hash: $hash, blur: $blur, width: $width, height: $height, size: $size)';
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
      ..add(DiagnosticsProperty('width', width))
      ..add(DiagnosticsProperty('height', height))
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
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(hash) ^
      const DeepCollectionEquality().hash(blur) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height);

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
      @required @JsonKey() num width,
      @required @JsonKey() num height}) = _$_FirebasePhoto;

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

  /// Width of the photo.
  @JsonKey()
  num get width;
  @override

  /// Height of the photo.
  @JsonKey()
  num get height;
  @override
  _$FirebasePhotoCopyWith<_FirebasePhoto> get copyWith;
}
