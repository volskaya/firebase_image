import 'package:firebase_image/src/converters.dart';
import 'package:firebase_image/src/firebase_image.dart';
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

/// Blurhash data of [FirebasePhoto].
@freezed
abstract class FirebasePhotoBlurData with _$FirebasePhotoBlurData {
  /// Creates [FirebasePhotoBlurData].
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

/// Palette colors of [FirebasePhoto].
@freezed
abstract class FirebasePhotoPalette with _$FirebasePhotoPalette {
  /// Creates [FirebasePhotoPalette].
  factory FirebasePhotoPalette({
    @JsonKey() @HexStringColorConverter() Color vibrant,
    @JsonKey() @HexStringColorConverter() Color muted,
    @JsonKey() @HexStringColorConverter() Color lightMuted,
    @JsonKey() @HexStringColorConverter() Color darkMuted,
    @JsonKey() @HexStringColorConverter() Color lightVibrant,
    @JsonKey() @HexStringColorConverter() Color darkVibrant,
  }) = _FirebasePhotoPalette;

  /// Deserialize [FirebasePhotoPalette] from json.
  factory FirebasePhotoPalette.fromJson(Map<String, dynamic> json) => _$FirebasePhotoPaletteFromJson(json);

  /// Get the first available color prioritizing vibrant.
  @late
  Color get dominant => vibrant ?? muted ?? lightVibrant ?? lightMuted ?? darkVibrant ?? darkMuted;

  /// Get the first available vibrant color prioritizing light.
  @late
  Color get firstVibrant => vibrant ?? lightVibrant ?? darkVibrant;

  /// Get the first available muted color prioritizing light.
  @late
  Color get firstMuted => muted ?? lightMuted ?? darkMuted;
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

    /// Color palette of the photo.
    @JsonKey() FirebasePhotoPalette palette,

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
  const FirebasePhotoReference(this.path, this.type, this.size, [this.blur, this.palette]);

  /// Creates a [FirebasePhotoReference] with a custom path and [FirebasePhoto].
  static FirebasePhotoReference from(String path, FirebasePhoto photo) =>
      FirebasePhotoReference(path, photo.type, photo.size, photo.blur);

  /// Creates a [FirebasePhotoReference] from a [FirebasePhoto], relative to
  /// a [FirestoreModel].
  static FirebasePhotoReference fromModel(FirebaseModel model, FirebasePhoto photo) =>
      FirebasePhotoReference(photo.getStoragePath(model), photo.type, photo.size, photo.blur, photo.palette);

  /// Path to the photo file in Firebase storage.
  final String path;

  /// Type of the photo pointed by the [path] in Firebase storage.
  final FirebasePhotoType type;

  /// Size of the referenced photo.
  final Size size;

  /// Blurhash of the photo.
  final FirebasePhotoBlurData blur;

  /// Color palette of the photo.
  final FirebasePhotoPalette palette;

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
