// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FirestorePhotoModel<T> on _FirestorePhotoModel<T>, Store {
  Computed<Map<String, FirebasePhotoReference>> _$mediaComputed;

  @override
  Map<String, FirebasePhotoReference> get media => (_$mediaComputed ??=
          Computed<Map<String, FirebasePhotoReference>>(() => super.media, name: '_FirestorePhotoModel.media'))
      .value;
  Computed<FirebasePhotoReference> _$photoComputed;

  @override
  FirebasePhotoReference get photo =>
      (_$photoComputed ??= Computed<FirebasePhotoReference>(() => super.photo, name: '_FirestorePhotoModel.photo'))
          .value;

  final _$photosAtom = Atom(name: '_FirestorePhotoModel.photos');

  @override
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  Map<String, FirebasePhoto> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  set photos(Map<String, FirebasePhoto> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  final _$_FirestorePhotoModelActionController = ActionController(name: '_FirestorePhotoModel');

  @override
  void onSnapshot(T x) {
    final _$actionInfo = _$_FirestorePhotoModelActionController.startAction(name: '_FirestorePhotoModel.onSnapshot');
    try {
      return super.onSnapshot(x);
    } finally {
      _$_FirestorePhotoModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
photos: ${photos},
media: ${media},
photo: ${photo}
    ''';
  }
}

mixin _$RealtimePhotoModel<T> on _RealtimePhotoModel<T>, Store {
  Computed<Map<String, FirebasePhotoReference>> _$mediaComputed;

  @override
  Map<String, FirebasePhotoReference> get media => (_$mediaComputed ??=
          Computed<Map<String, FirebasePhotoReference>>(() => super.media, name: '_RealtimePhotoModel.media'))
      .value;
  Computed<FirebasePhotoReference> _$photoComputed;

  @override
  FirebasePhotoReference get photo =>
      (_$photoComputed ??= Computed<FirebasePhotoReference>(() => super.photo, name: '_RealtimePhotoModel.photo'))
          .value;

  final _$photosAtom = Atom(name: '_RealtimePhotoModel.photos');

  @override
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  Map<String, FirebasePhoto> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  @JsonKey(defaultValue: <String, FirebasePhoto>{})
  @FirebasePhotoMapConverter()
  set photos(Map<String, FirebasePhoto> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  final _$_RealtimePhotoModelActionController = ActionController(name: '_RealtimePhotoModel');

  @override
  void onSnapshot(T x) {
    final _$actionInfo = _$_RealtimePhotoModelActionController.startAction(name: '_RealtimePhotoModel.onSnapshot');
    try {
      return super.onSnapshot(x);
    } finally {
      _$_RealtimePhotoModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
photos: ${photos},
media: ${media},
photo: ${photo}
    ''';
  }
}
