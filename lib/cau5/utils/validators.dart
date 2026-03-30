class Validators {
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static String? requiredField(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui long nhap $field';
    }
    return null;
  }

  static String? email(String? value) {
    final req = requiredField(value, 'email');
    if (req != null) {
      return req;
    }

    if (!_emailRegex.hasMatch(value!.trim())) {
      return 'Email khong hop le';
    }

    return null;
  }
}
