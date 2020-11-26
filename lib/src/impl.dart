import 'package:firebase_image/firebase_image.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'impl.freezed.dart';
part 'impl.g.dart';

/// Mixin for a [FirebaseModel].
///
/// Decorate fields manually to make them observable or json serializable.
mixin FirebasePhotoImpl<T> on FirebaseModel<T> {
  /// Document map of [FirebasePhoto]s, where the key refers to their "ID".
  Map<String, FirebasePhoto> get photos;

  /// Computed getter of [FirebasePhotoReferences] derived from the [photos] map.
  Map<String, FirebasePhotoReference> get media =>
      photos?.map((id, photo) => MapEntry(id, FirebasePhotoReference.fromModel(this, photo)));

  /// Computed [FirebasePhotoReference] of the first [FirebasePhoto] in [Photos].
  FirebasePhotoReference get photo => media?.isNotEmpty == true ? media.values.first : null;
}

/// Abstract class that extends [FirestoreModel] and decorates the photo fields
/// as observable and json serializable.
abstract class FirestorePhotoModel<T> = _FirestorePhotoModel<T> with _$FirestorePhotoModel<T>;

abstract class _FirestorePhotoModel<T> extends FirestoreModel<T> with FirebasePhotoImpl<T>, Store {
  /// Document map of [FirebasePhoto]s, where the key refers to their "ID".
  @observable
  @override
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  Map<String, FirebasePhoto> photos = const <String, FirebasePhoto>{};

  /// Computed getter of [FirebasePhotoReferences] derived from the [photos] map.
  @override
  @computed
  Map<String, FirebasePhotoReference> get media => super.media;

  /// Computed [FirebasePhotoReference] of the first [FirebasePhoto] in [Photos].
  @override
  @computed
  FirebasePhotoReference get photo => super.photo;

  @action
  @override
  @mustCallSuper
  void onSnapshot(T x) {
    photos = (x as FirestorePhotoModel<T>).photos;
  }
}

/// Abstract class that extends [FirestoreModel] and decorates the photo fields
/// as observable and json serializable.
abstract class RealtimePhotoModel<T> = _RealtimePhotoModel<T> with _$RealtimePhotoModel<T>;

abstract class _RealtimePhotoModel<T> extends RealtimeModel<T> with FirebasePhotoImpl<T>, Store {
  /// Document map of [FirebasePhoto]s, where the key refers to their "ID".
  @observable
  @override
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  Map<String, FirebasePhoto> photos = const <String, FirebasePhoto>{};

  /// Computed getter of [FirebasePhotoReferences] derived from the [photos] map.
  @override
  @computed
  Map<String, FirebasePhotoReference> get media => super.media;

  /// Computed [FirebasePhotoReference] of the first [FirebasePhoto] in [Photos].
  @override
  @computed
  FirebasePhotoReference get photo => super.photo;

  @action
  @override
  @mustCallSuper
  void onSnapshot(T x) {
    photos = (x as RealtimePhotoModel<T>).photos;
  }
}

/// Blurhash data of [FirebasePhoto].
@freezed
abstract class FirebasePhotoBlurData with _$FirebasePhotoBlurData {
  /// Construct [FirebasePhotoBlurData].
  factory FirebasePhotoBlurData({
    /// Blurhash.
    @required @JsonKey() String hash,

    /// Width of the blurhash.
    @required @JsonKey() num width,

    /// Height of the blurhash.
    @required @JsonKey() num height,
  }) = _FirebasePhotoBlurData;

  /// Deserialie [FirebasePhotoBlurData] from json.
  factory FirebasePhotoBlurData.fromJson(Map<String, dynamic> json) => _$FirebasePhotoBlurDataFromJson(json);

  /// Get the [Size] of this blur hash.
  @late
  Size get size => Size(width.toDouble(), height.toDouble());
}
