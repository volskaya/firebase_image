// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirebasePhotoBlurData _$_$_FirebasePhotoBlurDataFromJson(
    Map<String, dynamic> json) {
  return _$_FirebasePhotoBlurData(
    hash: json['hash'] as String,
    width: json['width'] as num,
    height: json['height'] as num,
  );
}

Map<String, dynamic> _$_$_FirebasePhotoBlurDataToJson(
        _$_FirebasePhotoBlurData instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'width': instance.width,
      'height': instance.height,
    };

_$_FirebasePhotoPalette _$_$_FirebasePhotoPaletteFromJson(
    Map<String, dynamic> json) {
  return _$_FirebasePhotoPalette(
    vibrant:
        const HexStringColorConverter().fromJson(json['vibrant'] as String),
    muted: const HexStringColorConverter().fromJson(json['muted'] as String),
    lightMuted:
        const HexStringColorConverter().fromJson(json['lightMuted'] as String),
    darkMuted:
        const HexStringColorConverter().fromJson(json['darkMuted'] as String),
    lightVibrant: const HexStringColorConverter()
        .fromJson(json['lightVibrant'] as String),
    darkVibrant:
        const HexStringColorConverter().fromJson(json['darkVibrant'] as String),
  );
}

Map<String, dynamic> _$_$_FirebasePhotoPaletteToJson(
        _$_FirebasePhotoPalette instance) =>
    <String, dynamic>{
      'vibrant': const HexStringColorConverter().toJson(instance.vibrant),
      'muted': const HexStringColorConverter().toJson(instance.muted),
      'lightMuted': const HexStringColorConverter().toJson(instance.lightMuted),
      'darkMuted': const HexStringColorConverter().toJson(instance.darkMuted),
      'lightVibrant':
          const HexStringColorConverter().toJson(instance.lightVibrant),
      'darkVibrant':
          const HexStringColorConverter().toJson(instance.darkVibrant),
    };

_$_FirebasePhoto _$_$_FirebasePhotoFromJson(Map<String, dynamic> json) {
  return _$_FirebasePhoto(
    type: _$enumDecodeNullable(_$FirebasePhotoTypeEnumMap, json['type']),
    id: json['id'] as String,
    hash: json['hash'] as String,
    blur: json['blur'] == null
        ? null
        : FirebasePhotoBlurData.fromJson(json['blur'] as Map<String, dynamic>),
    palette: json['palette'] == null
        ? null
        : FirebasePhotoPalette.fromJson(
            json['palette'] as Map<String, dynamic>),
    width: json['width'] as num,
    height: json['height'] as num,
  );
}

Map<String, dynamic> _$_$_FirebasePhotoToJson(_$_FirebasePhoto instance) =>
    <String, dynamic>{
      'type': _$FirebasePhotoTypeEnumMap[instance.type],
      'id': instance.id,
      'hash': instance.hash,
      'blur': instance.blur,
      'palette': instance.palette,
      'width': instance.width,
      'height': instance.height,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$FirebasePhotoTypeEnumMap = {
  FirebasePhotoType.image: 0,
  FirebasePhotoType.animation: 1,
  FirebasePhotoType.video: 2,
};
