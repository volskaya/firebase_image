import 'package:firebase_image/firebase_image.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:quiver/collection.dart';

part 'impl.g.dart';

/// Mixin for a [FirebaseModel].
///
/// Decorate fields manually to make them observable or json serializable.
mixin FirebasePhotoImpl<T> on FirebaseModel<T> {
  /// Document map of [FirebasePhoto]s, where the key refers to their "ID".
  Map<String, FirebasePhoto> get photos;

  /// Computed getter of [FirebasePhotoReferences] derived from the [photos] map.
  Map<String, FirebasePhotoReference> get media =>
      {for (final entry in photos.entries) entry.key: FirebasePhotoReference.fromModel(this, entry.value)};

  /// Computed [FirebasePhotoReference] of the first [FirebasePhoto] in [Photos].
  FirebasePhotoReference? get photo => media.isNotEmpty ? media.values.first : null;
}

/// Abstract class that extends [FirestoreModel] and decorates the photo fields
/// as observable and json serializable.
abstract class FirestorePhotoModel<T> = _FirestorePhotoModel<T> with _$FirestorePhotoModel<T>;

abstract class _FirestorePhotoModel<T> extends FirestoreModel<T> with FirebasePhotoImpl<T>, Store {
  @override @o @JsonKey(defaultValue: <String, FirebasePhoto>{}) @PhotoMapC() Map<String, FirebasePhoto> photos =
      const <String, FirebasePhoto>{};

  @override @c
  Map<String, FirebasePhotoReference> get media => super.media;

  @override @c
  FirebasePhotoReference? get photo => super.photo;

  @override @a @mustCallSuper
  void onSnapshot(T x) {
    final _x = x as FirestorePhotoModel;
    if (!mapsEqual(photos, _x.photos)) photos = _x.photos;
  }
}

/// Abstract class that extends [FirestoreModel] and decorates the photo fields
/// as observable and json serializable.
abstract class RealtimePhotoModel<T> = _RealtimePhotoModel<T> with _$RealtimePhotoModel<T>;

abstract class _RealtimePhotoModel<T> extends RealtimeModel<T> with FirebasePhotoImpl<T>, Store {
  @override @o @JsonKey(defaultValue: <String, FirebasePhoto>{}) @PhotoMapC() Map<String, FirebasePhoto> photos =
      const <String, FirebasePhoto>{};

  @override @c
  Map<String, FirebasePhotoReference> get media => super.media;

  @override @c
  FirebasePhotoReference? get photo => super.photo;

  @override @a @mustCallSuper
  void onSnapshot(T x) {
    final newPhotos = (x as RealtimePhotoModel).photos;
    // if (!mapsEqual(photos, newPhotos)) photos = newPhotos;
    photos = newPhotos;
  }
}
