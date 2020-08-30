## [0.0.3] - Update

- Allow overriding file names with FirebaseImage.names

## [0.0.1] - Init

- FirebasePhoto - Document field value of a photo
- FirebasePhotoReference - Reference that links FirebasePhoto to its file in Firebase storage
- FirebaseImage - Image provider that decoded Firebase storage images
- SwitchingFirebaseImage - Wrapper around SwitchingImage to dynamically choose between thumbnails or regular images
- FirebasePhotoMapConverter - Converter for the document model
- FirestorePhotoImpl - Base implementation of a Firestore model fields
- FirestorePhotoModel - Extended FirestoreModel that handles the fields automatically
