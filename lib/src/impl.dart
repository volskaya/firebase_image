import 'package:firebase_image/firebase_image.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'impl.g.dart';

/// Mixin for a [FirestoreModel].
///
/// Decorate fields manually to make them observable or json serializable.
mixin FirestorePhotoImpl<T> on FirestoreModel<T> {
  /// Document map of [FirebasePhoto]s, where the key refers to their "ID".
  Map<String, FirebasePhoto> get photos;

  /// Computed getter of [FirebasePhotoReferences] derived from the [photos] map.
  Map<String, FirebasePhotoReference> get media =>
      photos?.map((id, photo) => MapEntry(id, FirebasePhotoReference.fromFirestore(this, photo)));

  /// Computed [FirebasePhotoReference] of the first [FirebasePhoto] in [Photos].
  FirebasePhotoReference get photo => media?.isNotEmpty == true ? media.values.first : null;
}

/// Abstract class that extends [FirestoreModel] and decorates the photo fields
/// as observable and json serializable.
abstract class FirestorePhotoModel<T> = _FirestorePhotoModel<T> with _$FirestorePhotoModel<T>;

abstract class _FirestorePhotoModel<T> extends FirestoreModel<T> with Store {
  /// Document map of [FirebasePhoto]s, where the key refers to their "ID".
  @observable
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  Map<String, FirebasePhoto> photos = const <String, FirebasePhoto>{};

  /// Computed getter of [FirebasePhotoReferences] derived from the [photos] map.
  @computed
  Map<String, FirebasePhotoReference> get media =>
      photos?.map((id, photo) => MapEntry(id, FirebasePhotoReference.fromFirestore(this, photo)));

  /// Computed [FirebasePhotoReference] of the first [FirebasePhoto] in [Photos].
  @computed
  FirebasePhotoReference get photo => media?.isNotEmpty == true ? media.values.first : null;

  @action
  @override
  @mustCallSuper
  void onSnapshot(T x) {
    final firestorePhotoModel = x as FirestorePhotoModel<T>;
    photos = firestorePhotoModel.photos;
  }
}
