class Validators {
  static String? requiredDate(DateTime? value) {
    if (value == null) {
      return 'Vui long chon ngay';
    }
    return null;
  }

  static String? requiredTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui long chon gio';
    }
    return null;
  }

  static String? dateNotInPast(DateTime? value) {
    final requiredError = requiredDate(value);
    if (requiredError != null) {
      return requiredError;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(value!.year, value.month, value.day);

    if (selected.isBefore(today)) {
      return 'Ngay khong hop le (trong qua khu)';
    }

    return null;
  }
}
