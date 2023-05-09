class AppValidation {
  static String? validatePassword(value) {
    RegExp upperCase =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (!upperCase.hasMatch(value ?? '')) {
      return 'Password must contain atleast\n 1 Uppercase,\n 1 Lowercase,\n 1 Number,\n 1 Special Charecter';
    } else {
      return null;
    }
  }

  static String? validateEmailAddress(value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Invalid Email Address';
    } else {
      return null;
    }
  }
}
