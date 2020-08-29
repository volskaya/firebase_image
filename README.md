###### WIP - Needs a Flutter patch to link decoded RawImage with its image provider.

# Firebase Image

Handling of images stored in Firebase storage. Bundled with an extension of [Firestore Model](https://github.com/volskaya/firestore_model) to also handle `photo` fields.

The `FirebasePhoto` references both a thumbnail and a regular image. When a regular image decodes, the image provider
first attempts to decode the large version on devices with high dpi.

## Assumed storage paths

Firebase Image references assume the image is stored in your default Firebase storage bucket, in path equal to the `FirestoreModel` reference path.

For example a document of the user model below would be referenced in Firestore at **users/dbf523y8**, so the photo in Storage would be at **users/dbf523y8/photo/0/198673a755/reg**.

**photo/0** points to photo of key 0. Photos have string keys to allow for multiple photos while still easily preserving their positions.

## Switching Firebase Image

`SwitchingFirebaseImage` extends `SwitchingImage` to first load a thumbnail, if it's already cached and not the regular photo, then load the regular photo. This allows seamless transitions from list tiles to full pages.

## Extending FirestorePhotoModel

Check models in the [Flutter Firestore](https://github.com/volskaya/flutter_firestore) example app.

```dart
@JsonSerializable()
class User extends _User with _$User {
  static final collection = FirebaseFirestore.instance.collection('users');

  /// Create [User] from json
  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Convert [User] to json
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// [FirestorePhotoModel] observes the fields of [FirestorePhotoImpl], see next example.
abstract class _User extends FirestorePhotoModel<User> with Store {
  @observable
  @JsonKey()
  String name;
  @observable
  @JsonKey()
  @StringWithLineBreaksConverter()
  String description;
  @observable
  @JsonKey(defaultValue: 0)
  int views = 0;
  @observable
  @JsonKey(defaultValue: 0)
  int followers = 0;

  @override
  void onSnapshot(User x) {
    super.onSnapshot(x);
    name = x.name;
    description = x.description;
    views = x.views;
    followers = x.followers;
  }
}
```

## Implementing Mixin - FirestorePhotoImpl

If you don't intend to decorate the fields as observable or json serializable,
just adding **FirestorePhotoImpl** as a mixin is enough.

Else extend **Mixin** fields and decorate them like so:

```dart
@override
@observable
@JsonKey(defaultValue: <String, FirebasePhoto>{})
@FirebasePhotoMapConverter()
Map<String, FirebasePhoto> photos = const <String, FirebasePhoto>{};
@override
@computed
Map<String, FirebasePhotoReference> get media => super.media;
@override
@computed
FirebasePhotoReference get photo => super.photo;

@override
void onSnapshot(x) {
  photos = x.photos;
}

```
