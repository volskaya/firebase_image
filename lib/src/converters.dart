import 'package:firebase_image/src/firebase_photo.dart';
import 'package:json_annotation/json_annotation.dart';

/// Json converter for [FirebasePhoto] maps inside Firestore documents.
class FirebasePhotoMapConverter implements JsonConverter<Map<String, FirebasePhoto>, dynamic> {
  /// Creates [FirebasePhotoMapConverter].
  const FirebasePhotoMapConverter();

  @override
  Map<String, FirebasePhoto> fromJson(dynamic json) =>
      // HACK: Realtime DB internally deserializes maps, that have number keys, as lists
      (json is List
              ? Map<dynamic, dynamic>.fromIterables(List<String>.generate(json.length, (i) => i.toString()), json)
              : json as Map)
          ?.map(
        (dynamic key, dynamic value) {
          final id = key as String;
          final info = value as Map<dynamic, dynamic>;

          assert(info.containsKey('type'));
          assert(info.containsKey('hash'));
          assert(info.containsKey('width'));
          assert(info.containsKey('height'));
          return MapEntry<String, FirebasePhoto>(
            id,
            FirebasePhoto(
              id: id,
              type: FirebasePhotoType.values[info['type'] as int],
              hash: info['hash'] as String,
              width: info['width'] as num,
              height: info['height'] as num,
            ),
          );
        },
      );

  @override
  Map<String, Map<String, dynamic>> toJson(Map<String, FirebasePhoto> object) => object?.map(
        (id, photo) => MapEntry<String, Map<String, dynamic>>(id, <String, dynamic>{
          'type': photo.type.index,
          'hash': photo.hash,
          'width': photo.size.width,
          'height': photo.size.height,
        }),
      );
}
