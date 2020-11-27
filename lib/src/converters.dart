import 'package:firebase_image/src/firebase_photo.dart';
import 'package:json_annotation/json_annotation.dart';

/// Json converter for [FirebasePhoto] maps inside Firestore documents.
class FirebasePhotoMapConverter implements JsonConverter<Map<String, FirebasePhoto>, dynamic> {
  /// Creates [FirebasePhotoMapConverter].
  const FirebasePhotoMapConverter();

  @override
  Map<String, FirebasePhoto> fromJson(dynamic json) => json != null
      ? {
          for (final entry in (json is List) ? json.asMap().entries : (json as Map).entries)
            entry.key.toString(): FirebasePhoto.fromJson(<String, dynamic>{
              ...Map<String, dynamic>.from(entry.value as Map),
              'id': entry.key.toString(),
            })
        }
      : null;

  @override
  Map<String, Map<String, dynamic>> toJson(Map<String, FirebasePhoto> object) =>
      {for (final entry in object.entries) entry.key: entry.value.toJson()};
}
