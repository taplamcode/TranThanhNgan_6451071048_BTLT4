class UploadProfileModel {
  final String fullName;
  final String email;
  final String fileName;
  final bool confirmed;

  const UploadProfileModel({
    required this.fullName,
    required this.email,
    required this.fileName,
    required this.confirmed,
  });
}
