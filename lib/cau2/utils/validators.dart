class Validators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui long nhap $fieldName';
    }
    return null;
  }

  static String? age(String? value) {
    final requiredError = requiredField(value, 'tuoi');
    if (requiredError != null) {
      return requiredError;
    }

    final ageValue = int.tryParse(value!.trim());
    if (ageValue == null) {
      return 'Tuoi phai la so nguyen';
    }

    if (ageValue <= 0) {
      return 'Tuoi phai > 0';
    }

    return null;
  }
}
