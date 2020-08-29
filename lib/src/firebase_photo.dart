import 'package:firebase_image/src/firebase_image.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' show join;

/// [FirebasePhoto] types refer to images, gifs and video objects
/// within Firebase storage.
enum FirebasePhotoType {
  /// Image type, usually mime types of `image/*`.
  image,

  /// Image type, usually mime types of `image/gif`.
  animation,

  /// Image type, usually mime type of 'video/mp4'.
  video,
}

/// Document photos map entry value that describes photo type, id, hash, size
/// and its public download URLs.
class FirebasePhoto {
  /// Creates [FirebasePhoto].
  FirebasePhoto({
    @required this.id,
    @required this.type,
    @required this.hash,
    @required num width,
    @required num height,
  }) : size = Size(width.toDouble(), height.toDouble());

  /// Type of this [FirebasePhoto].
  final FirebasePhotoType type;

  /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
  final String id;

  /// Hash that serves as the filename of this photo.
  final String hash;

  /// Size of this photo.
  final Size size;

  /// Get the full Firebase storage path of this photo, relative to its
  /// [FirestoreModel parent].
  ///
  /// Function assumes the model is a top level document in Firestore
  /// and that photos, used in these documents, share the same collection
  /// names.
  String getFirestorePath(covariant FirestoreModel parent) => join(parent.reference.path, 'photo', id, hash);
}

/// Firebase photo reference that points to the photo file in Firebase storage.
///
/// Simplifies building [FirebaseImage] providers.
class FirebasePhotoReference {
  /// Creates [FirebasePhotoReference].
  const FirebasePhotoReference(this.path, this.type, this.size);

  /// Creates a [FirebasePhotoReference] with a custom path and [FirebasePhoto].
  static FirebasePhotoReference from(String path, FirebasePhoto photo) =>
      FirebasePhotoReference(path, photo.type, photo.size);

  /// Creates a [FirebasePhotoReference] from a [FirebasePhoto], relative to
  /// a [FirestoreModel].
  static FirebasePhotoReference fromFirestore(
    FirestoreModel model,
    FirebasePhoto photo,
  ) =>
      FirebasePhotoReference(photo.getFirestorePath(model), photo.type, photo.size);

  /// Path to the photo file in Firebase storage.
  final String path;

  /// Type of the photo pointed by the [path] in Firebase storage.
  final FirebasePhotoType type;

  /// Size of the referenced photo.
  final Size size;

  /// Thumbnail [FirebaseImage] provider of this [FirebasePhotoReference].
  FirebaseImage get thumbnail => FirebaseImage.thumbnailFrom(this);

  /// Regular [FirebaseImage] provider of this [FirebasePhotoReference].
  FirebaseImage get image => FirebaseImage.from(this);

  /// Scroll aware thumbnail [FirebaseImage] provider of this [FirebasePhotoReference].
  AwareFirebaseImage awareThumbnail(State state) => AwareFirebaseImage.thumbnailFrom(state, this);

  /// Scroll aware regular [FirebaseImage] provider of this [FirebasePhotoReference].
  AwareFirebaseImage awareImage(State state) => AwareFirebaseImage.from(state, this);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FirebasePhotoReference && other.path == path && other.type == type && other.size == size;
  }

  @override
  int get hashCode => hashValues(path, type, size);
}
