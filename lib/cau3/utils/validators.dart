class Validators {
  static String? selectedInterests(Set<String>? values) {
    if (values == null || values.isEmpty) {
      return 'Ban phai chon it nhat 1 so thich';
    }
    return null;
  }
}
