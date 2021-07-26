// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'firebase_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FirebaseImageNamesTearOff {
  const _$FirebaseImageNamesTearOff();

  _FirebaseImageNames call(
      {String thumbnail = 'thumbnail',
      String regular = 'reg',
      String large = 'lg',
      String photoFolder = 'photo'}) {
    return _FirebaseImageNames(
      thumbnail: thumbnail,
      regular: regular,
      large: large,
      photoFolder: photoFolder,
    );
  }
}

/// @nodoc
const $FirebaseImageNames = _$FirebaseImageNamesTearOff();

/// @nodoc
mixin _$FirebaseImageNames {
  /// Filename of the thumbnail image.
  String get thumbnail => throw _privateConstructorUsedError;

  /// Filename of the regular image.
  String get regular => throw _privateConstructorUsedError;

  /// Filename of the large image.
  String get large => throw _privateConstructorUsedError;

  /// Filename of the photo folder, where the images are placed.
  String get photoFolder => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FirebaseImageNamesCopyWith<FirebaseImageNames> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseImageNamesCopyWith<$Res> {
  factory $FirebaseImageNamesCopyWith(
          FirebaseImageNames value, $Res Function(FirebaseImageNames) then) =
      _$FirebaseImageNamesCopyWithImpl<$Res>;
  $Res call(
      {String thumbnail, String regular, String large, String photoFolder});
}

/// @nodoc
class _$FirebaseImageNamesCopyWithImpl<$Res>
    implements $FirebaseImageNamesCopyWith<$Res> {
  _$FirebaseImageNamesCopyWithImpl(this._value, this._then);

  final FirebaseImageNames _value;
  // ignore: unused_field
  final $Res Function(FirebaseImageNames) _then;

  @override
  $Res call({
    Object? thumbnail = freezed,
    Object? regular = freezed,
    Object? large = freezed,
    Object? photoFolder = freezed,
  }) {
    return _then(_value.copyWith(
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      regular: regular == freezed
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as String,
      large: large == freezed
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as String,
      photoFolder: photoFolder == freezed
          ? _value.photoFolder
          : photoFolder // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$FirebaseImageNamesCopyWith<$Res>
    implements $FirebaseImageNamesCopyWith<$Res> {
  factory _$FirebaseImageNamesCopyWith(
          _FirebaseImageNames value, $Res Function(_FirebaseImageNames) then) =
      __$FirebaseImageNamesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String thumbnail, String regular, String large, String photoFolder});
}

/// @nodoc
class __$FirebaseImageNamesCopyWithImpl<$Res>
    extends _$FirebaseImageNamesCopyWithImpl<$Res>
    implements _$FirebaseImageNamesCopyWith<$Res> {
  __$FirebaseImageNamesCopyWithImpl(
      _FirebaseImageNames _value, $Res Function(_FirebaseImageNames) _then)
      : super(_value, (v) => _then(v as _FirebaseImageNames));

  @override
  _FirebaseImageNames get _value => super._value as _FirebaseImageNames;

  @override
  $Res call({
    Object? thumbnail = freezed,
    Object? regular = freezed,
    Object? large = freezed,
    Object? photoFolder = freezed,
  }) {
    return _then(_FirebaseImageNames(
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      regular: regular == freezed
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as String,
      large: large == freezed
          ? _value.large
          : large // ignore: cast_nullable_to_non_nullable
              as String,
      photoFolder: photoFolder == freezed
          ? _value.photoFolder
          : photoFolder // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FirebaseImageNames
    with DiagnosticableTreeMixin
    implements _FirebaseImageNames {
  const _$_FirebaseImageNames(
      {this.thumbnail = 'thumbnail',
      this.regular = 'reg',
      this.large = 'lg',
      this.photoFolder = 'photo'});

  @JsonKey(defaultValue: 'thumbnail')
  @override

  /// Filename of the thumbnail image.
  final String thumbnail;
  @JsonKey(defaultValue: 'reg')
  @override

  /// Filename of the regular image.
  final String regular;
  @JsonKey(defaultValue: 'lg')
  @override

  /// Filename of the large image.
  final String large;
  @JsonKey(defaultValue: 'photo')
  @override

  /// Filename of the photo folder, where the images are placed.
  final String photoFolder;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FirebaseImageNames(thumbnail: $thumbnail, regular: $regular, large: $large, photoFolder: $photoFolder)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FirebaseImageNames'))
      ..add(DiagnosticsProperty('thumbnail', thumbnail))
      ..add(DiagnosticsProperty('regular', regular))
      ..add(DiagnosticsProperty('large', large))
      ..add(DiagnosticsProperty('photoFolder', photoFolder));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FirebaseImageNames &&
            (identical(other.thumbnail, thumbnail) ||
                const DeepCollectionEquality()
                    .equals(other.thumbnail, thumbnail)) &&
            (identical(other.regular, regular) ||
                const DeepCollectionEquality()
                    .equals(other.regular, regular)) &&
            (identical(other.large, large) ||
                const DeepCollectionEquality().equals(other.large, large)) &&
            (identical(other.photoFolder, photoFolder) ||
                const DeepCollectionEquality()
                    .equals(other.photoFolder, photoFolder)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(thumbnail) ^
      const DeepCollectionEquality().hash(regular) ^
      const DeepCollectionEquality().hash(large) ^
      const DeepCollectionEquality().hash(photoFolder);

  @JsonKey(ignore: true)
  @override
  _$FirebaseImageNamesCopyWith<_FirebaseImageNames> get copyWith =>
      __$FirebaseImageNamesCopyWithImpl<_FirebaseImageNames>(this, _$identity);
}

abstract class _FirebaseImageNames implements FirebaseImageNames {
  const factory _FirebaseImageNames(
      {String thumbnail,
      String regular,
      String large,
      String photoFolder}) = _$_FirebaseImageNames;

  @override

  /// Filename of the thumbnail image.
  String get thumbnail => throw _privateConstructorUsedError;
  @override

  /// Filename of the regular image.
  String get regular => throw _privateConstructorUsedError;
  @override

  /// Filename of the large image.
  String get large => throw _privateConstructorUsedError;
  @override

  /// Filename of the photo folder, where the images are placed.
  String get photoFolder => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FirebaseImageNamesCopyWith<_FirebaseImageNames> get copyWith =>
      throw _privateConstructorUsedError;
}
