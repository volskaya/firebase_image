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

_$_FirebasePhotoFaceData _$_$_FirebasePhotoFaceDataFromJson(
    Map<String, dynamic> json) {
  return _$_FirebasePhotoFaceData(
    x: json['x'] as num,
    y: json['y'] as num,
    width: json['width'] as num,
    height: json['height'] as num,
    size: const SizeConverter().fromJson(json['size'] as Map?),
  );
}

Map<String, dynamic> _$_$_FirebasePhotoFaceDataToJson(
        _$_FirebasePhotoFaceData instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'size': const SizeConverter().toJson(instance.size),
    };

_$_FirebasePhotoPalette _$_$_FirebasePhotoPaletteFromJson(
    Map<String, dynamic> json) {
  return _$_FirebasePhotoPalette(
    vibrant:
        const HexStringColorConverter().fromJson(json['vibrant'] as String?),
    muted: const HexStringColorConverter().fromJson(json['muted'] as String?),
    lightMuted:
        const HexStringColorConverter().fromJson(json['lightMuted'] as String?),
    darkMuted:
        const HexStringColorConverter().fromJson(json['darkMuted'] as String?),
    lightVibrant: const HexStringColorConverter()
        .fromJson(json['lightVibrant'] as String?),
    darkVibrant: const HexStringColorConverter()
        .fromJson(json['darkVibrant'] as String?),
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
    type: _$enumDecode(_$FirebasePhotoTypeEnumMap, json['type']),
    id: json['id'] as String,
    hash: json['hash'] as String,
    blur: json['blur'] == null
        ? null
        : FirebasePhotoBlurData.fromJson(json['blur'] as Map<String, dynamic>),
    palette: json['palette'] == null
        ? null
        : FirebasePhotoPalette.fromJson(
            json['palette'] as Map<String, dynamic>),
    face: json['face'] == null
        ? null
        : FirebasePhotoFaceData.fromJson(json['face'] as Map<String, dynamic>),
    width: json['width'] as num,
    height: json['height'] as num,
    hasLarge: json['hasLarge'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_FirebasePhotoToJson(_$_FirebasePhoto instance) =>
    <String, dynamic>{
      'type': _$FirebasePhotoTypeEnumMap[instance.type],
      'id': instance.id,
      'hash': instance.hash,
      'blur': instance.blur,
      'palette': instance.palette,
      'face': instance.face,
      'width': instance.width,
      'height': instance.height,
      'hasLarge': instance.hasLarge,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$FirebasePhotoTypeEnumMap = {
  FirebasePhotoType.image: 0,
  FirebasePhotoType.animation: 1,
  FirebasePhotoType.video: 2,
};
