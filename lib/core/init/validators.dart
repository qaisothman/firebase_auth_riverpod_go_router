class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@\$!%*#?&.~\[\]])[A-Za-z\d@\$!%*#?&.~\[\]]{8,}$',
  );
  static final RegExp _phoneRegExp = RegExp(r'^\+\d{10,}$');

  static bool isValidEmail(String? email) {
    if (email == null) return false;
    return _emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String? password) {
    if (password == null) return false;
    return _passwordRegExp.hasMatch(password);
  }

  static bool isValidPhone(String? phone) {
    if (phone == null) return false;
    return _phoneRegExp.hasMatch(phone);
  }
}
