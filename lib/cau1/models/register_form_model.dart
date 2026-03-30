class RegisterFormModel {
  final String fullName;
  final String email;
  final String password;
  final bool agreedToTerms;

  const RegisterFormModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.agreedToTerms,
  });
}
