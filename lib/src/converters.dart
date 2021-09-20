import 'package:firebase_image/src/firebase_photo.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Json converter for [FirebasePhoto] maps inside Firestore documents.
class PhotoMapC implements JsonConverter<Map<String, FirebasePhoto>, dynamic> {
  /// Creates [PhotoMapC].
  const PhotoMapC();

  @override
  Map<String, FirebasePhoto> fromJson(dynamic json) {
    if (json == null) {
      return const <String, FirebasePhoto>{};
    } else if (json is List) {
      return {
        for (final entry in json.asMap().entries)
          entry.key.toString(): FirebasePhoto.fromJson(<String, dynamic>{
            ...Map<String, dynamic>.from(entry.value as Map),
            'id': entry.key.toString(),
          })
      };
    } else {
      // Assume the json is a map.
      return {
        for (final entry in Map<String, dynamic>.from(json as Map).entries)
          entry.key.toString(): FirebasePhoto.fromJson(<String, dynamic>{
            ...Map<String, dynamic>.from(entry.value as Map),
            'id': entry.key.toString(),
          })
      };
    }
  }

  @override
  dynamic toJson(Map<String, FirebasePhoto> object) =>
      {for (final entry in object.entries) entry.key: entry.value.toJson()};
}

/// Converts color hex strings of `#aa4433` to `Color(0xffaa4433)`.
class HexStringColorConverter implements JsonConverter<Color?, String?> {
  /// Creates [HexStringColorConverter].
  const HexStringColorConverter();

  @override
  Color? fromJson(String? json) {
    if (json == null || json is! String) return null;

    final colorString = json.replaceFirst('#', 'ff'); // NOTE: Add alpha to the color.
    return json is String ? Color(int.parse(colorString, radix: 16)) : null;
  }

  @override
  String? toJson(Color? object) => object?.value.toRadixString(16).padLeft(8, '0').replaceFirst('ff', '#');
}

/// Converts flutter's [Size].
class SizeConverter implements JsonConverter<Size, Map?> {
  /// Creates [SizeConverter].
  const SizeConverter();

  @override
  Size fromJson(Map? json) {
    if (json == null) return const Size.square(0.0);

    final width = json['width'] as num?;
    final height = json['height'] as num?;

    return width != null && height != null ? Size(width.toDouble(), height.toDouble()) : const Size.square(0.0);
  }

  @override
  Map? toJson(Size? object) =>
      object != null ? <dynamic, dynamic>{'width': object.width, 'height': object.height} : null;
}
