import 'package:firebase_image/src/converters.dart';
import 'package:firebase_image/src/firebase_image.dart';
import 'package:firebase_image/src/utils/switching_firebase_image_state.dart';
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
class FirebasePhotoBlurData with _$FirebasePhotoBlurData {
  /// Creates [FirebasePhotoBlurData].
  factory FirebasePhotoBlurData({
    /// Blurhash.
    @JsonKey() required String hash,

    /// Width of the blurhash.
    @JsonKey() required num width,

    /// Height of the blurhash.
    @JsonKey() required num height,
  }) = _FirebasePhotoBlurData;

  FirebasePhotoBlurData._();

  /// Deserialie [FirebasePhotoBlurData] from json.
  factory FirebasePhotoBlurData.fromJson(Map<String, dynamic> json) => _$FirebasePhotoBlurDataFromJson(json);

  /// Get the [Size] of this blur hash.
  late final size = Size(width.toDouble(), height.toDouble());
}

/// Face data of [FirebasePhoto]
@freezed
class FirebasePhotoFaceData with _$FirebasePhotoFaceData {
  /// Creates [FirebasePhotoFaceData].
  factory FirebasePhotoFaceData({
    /// Left side of the face rect.
    @JsonKey() required num x,

    /// Top side of the face rect.
    @JsonKey() required num y,

    /// Width of the face rect.
    @JsonKey() required num width,

    /// Height of the face rect.
    @JsonKey() required num height,

    /// Size of the image that overlaps this face rect.
    @JsonKey() @SizeConverter() required Size size,
  }) = _FirebasePhotoFaceData;

  FirebasePhotoFaceData._();

  /// Deserialie [FirebasePhotoFaceData] from json.
  factory FirebasePhotoFaceData.fromJson(Map<String, dynamic> json) => _$FirebasePhotoFaceDataFromJson(json);

  /// Get the [Rect] of this face rect.
  late final rect = Rect.fromLTWH(x.toDouble(), y.toDouble(), width.toDouble(), height.toDouble());

  /// Get the image [Rect] that overlaps this face rect.
  late final imageRect = Offset.zero & size;
}

/// Palette colors of [FirebasePhoto].
@freezed
class FirebasePhotoPalette with _$FirebasePhotoPalette {
  /// Creates [FirebasePhotoPalette].
  factory FirebasePhotoPalette({
    @JsonKey() @HexStringColorConverter() Color? vibrant,
    @JsonKey() @HexStringColorConverter() Color? muted,
    @JsonKey() @HexStringColorConverter() Color? lightMuted,
    @JsonKey() @HexStringColorConverter() Color? darkMuted,
    @JsonKey() @HexStringColorConverter() Color? lightVibrant,
    @JsonKey() @HexStringColorConverter() Color? darkVibrant,
  }) = _FirebasePhotoPalette;

  FirebasePhotoPalette._();

  /// Deserialize [FirebasePhotoPalette] from json.
  factory FirebasePhotoPalette.fromJson(Map<String, dynamic> json) => _$FirebasePhotoPaletteFromJson(json);

  /// Get the first available color prioritizing vibrant.
  late final Color? dominant = vibrant ?? muted ?? lightVibrant ?? lightMuted ?? darkVibrant ?? darkMuted;

  /// Get the first available vibrant color prioritizing light.
  late final Color? firstVibrant = vibrant ?? lightVibrant ?? darkVibrant;

  /// Get the first available muted color prioritizing light.
  late final Color? firstMuted = muted ?? lightMuted ?? darkMuted;
}

/// Document photos map entry value that describes photo type, id, hash, size
/// and its public download URLs.
@freezed
class FirebasePhoto with _$FirebasePhoto {
  /// Creates [FirebasePhoto].
  factory FirebasePhoto({
    /// Type of this [FirebasePhoto].
    @JsonKey() required FirebasePhotoType type,

    /// Photo ID / index / slow, under which this photo is stored in Firebase storage.
    @JsonKey() required String id,

    /// Hash that serves as the filename of this photo.
    @JsonKey() required String hash,

    /// Blurhash of the photo.
    @JsonKey() FirebasePhotoBlurData? blur,

    /// Color palette of the photo.
    @JsonKey() FirebasePhotoPalette? palette,

    /// Face rect inside the photo.
    @JsonKey() FirebasePhotoFaceData? face,

    /// Width of the photo.
    @JsonKey() required num width,

    /// Height of the photo.
    @JsonKey() required num height,

    /// Wether the photo also has a large version.
    @JsonKey(defaultValue: false) @Default(false) bool hasLarge,
  }) = _FirebasePhoto;

  FirebasePhoto._();

  /// Deserialize [FirebasePhoto] from json.
  factory FirebasePhoto.fromJson(Map<String, dynamic> json) => _$FirebasePhotoFromJson(json);

  /// Dimensions of this [FirebasePhoto].
  late final size = Size(width.toDouble(), height.toDouble());

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
  const FirebasePhotoReference(this.path, this.type, this.size, [this.blur, this.palette, this.face]);

  /// Creates a [FirebasePhotoReference] with a custom path and [FirebasePhoto].
  static FirebasePhotoReference from(String path, FirebasePhoto photo) =>
      FirebasePhotoReference(path, photo.type, photo.size, photo.blur, photo.palette, photo.face);

  /// Creates a [FirebasePhotoReference] from a [FirebasePhoto], relative to
  /// a [FirestoreModel].
  static FirebasePhotoReference fromModel(FirebaseModel model, FirebasePhoto photo) => FirebasePhotoReference(
      photo.getStoragePath(model), photo.type, photo.size, photo.blur, photo.palette, photo.face);

  /// Path to the photo file in Firebase storage.
  final String path;

  /// Type of the photo pointed by the [path] in Firebase storage.
  final FirebasePhotoType type;

  /// Size of the referenced photo.
  final Size size;

  /// Blurhash of the photo.
  final FirebasePhotoBlurData? blur;

  /// Color palette of the photo.
  final FirebasePhotoPalette? palette;

  /// Face rect inside the photo.
  final FirebasePhotoFaceData? face;

  /// Thumbnail [FirebaseImage] provider of this [FirebasePhotoReference].
  FirebaseImage get thumbnail => FirebaseImage.thumbnailFrom(this);

  /// Regular [FirebaseImage] provider of this [FirebasePhotoReference].
  FirebaseImage get image => FirebaseImage.from(this);

  /// Scroll aware thumbnail [FirebaseImage] provider of this [FirebasePhotoReference].
  AwareFirebaseImage awareThumbnail<T extends StatefulWidget>(
    SwitchingFirebaseImageState<T> state, [
    Size? cacheSize,
  ]) =>
      AwareFirebaseImage.thumbnailFrom(state, this, cacheSize);

  /// Scroll aware regular [FirebaseImage] provider of this [FirebasePhotoReference].
  AwareFirebaseImage awareImage<T extends StatefulWidget>(
    SwitchingFirebaseImageState<T> state, [
    Size? cacheSize,
  ]) =>
      AwareFirebaseImage.from(state, this, cacheSize);

  /// Thumbnail [FirebaseImage] provider of this [FirebasePhotoReference].
  FirebaseImage getThumbnail([Size? cacheSize]) => FirebaseImage.thumbnailFrom(this, cacheSize);

  /// Regular [FirebaseImage] provider of this [FirebasePhotoReference].
  FirebaseImage getImage([Size? cacheSize]) => FirebaseImage.from(this, cacheSize);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FirebasePhotoReference && other.path == path && other.type == type && other.size == size;
  }

  @override
  int get hashCode => hashValues(path, type, size);
}
