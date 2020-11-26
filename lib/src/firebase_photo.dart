import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_image/src/impl.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' show join;

part 'firebase_photo.freezed.dart';
part 'firebase_photo.g.dart';

/// [FirebasePhoto] types refer to images, gifs and video objects
/// within Firebase storage.
enum FirebasePhotoType {
  /// Image type, usually mime types of `image/*`.
  @JsonValue(0)
  image,

  /// Image type, usually mime types of `image/gif`.
  @JsonValue(1)
  animation,

  /// Image type, usually mime type of 'video/mp4'.
  @JsonValue(2)
  video,
}

/// Document photos map entry value that describes photo type, id, hash, size
/// and its public download URLs.
@freezed
abstract class FirebasePhoto implements _$FirebasePhoto {
  /// Creates [FirebasePhoto].
  factory FirebasePhoto({
    /// Type of this [FirebasePhoto].
    @required @JsonKey() FirebasePhotoType type,

    /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
    @required @JsonKey() String id,

    /// Hash that serves as the filename of this photo.
    @required @JsonKey() String hash,

    /// Blurhash of the photo.
    @JsonKey() FirebasePhotoBlurData blur,

    /// Width of the photo.
    @required @JsonKey() num width,

    /// Height of the photo.
    @required @JsonKey() num height,
  }) = _FirebasePhoto;

  FirebasePhoto._();

  /// Deserialize [FirebasePhoto] from json.
  factory FirebasePhoto.fromJson(Map<String, dynamic> json) => _$FirebasePhotoFromJson(json);

  /// Dimensions of this [FirebasePhoto].
  @late
  Size get size => Size(width.toDouble(), height.toDouble());

  /// Get the full Firebase storage path of this photo, relative to its
  /// [FirebaseModel] parent.
  ///
  /// Function assumes the model is a top level document in Firestore / Realtime database
  /// and that photos, used in these documents, share the same collection
  /// names.
  String getStoragePath(covariant FirebaseModel parent) => join(parent.path, FirebaseImage.names.photoFolder, id, hash);
}

/// Firebase photo reference that points to the photo file in Firebase storage.
///
/// Simplifies building [FirebaseImage] providers.
class FirebasePhotoReference {
  /// Creates [FirebasePhotoReference].
  const FirebasePhotoReference(this.path, this.type, this.size, [this.blur]);

  /// Creates a [FirebasePhotoReference] with a custom path and [FirebasePhoto].
  static FirebasePhotoReference from(String path, FirebasePhoto photo) =>
      FirebasePhotoReference(path, photo.type, photo.size, photo.blur);

  /// Creates a [FirebasePhotoReference] from a [FirebasePhoto], relative to
  /// a [FirestoreModel].
  static FirebasePhotoReference fromModel(FirebaseModel model, FirebasePhoto photo) =>
      FirebasePhotoReference(photo.getStoragePath(model), photo.type, photo.size, photo.blur);

  /// Path to the photo file in Firebase storage.
  final String path;

  /// Type of the photo pointed by the [path] in Firebase storage.
  final FirebasePhotoType type;

  /// Size of the referenced photo.
  final Size size;

  /// Blurhash of the photo.
  final FirebasePhotoBlurData blur;

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
