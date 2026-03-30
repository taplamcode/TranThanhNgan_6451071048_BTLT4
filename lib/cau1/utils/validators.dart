class Validators {
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value, 'email');
    if (requiredError != null) {
      return requiredError;
    }

    if (!_emailRegex.hasMatch(value!.trim())) {
      return 'Email không hợp lệ';
    }

    return null;
  }

  static String? password(String? value) {
    return requiredField(value, 'mat khau');
  }
}
