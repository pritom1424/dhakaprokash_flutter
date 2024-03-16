class AppValidator {
  static bool emailValidator(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    return emailValid;
  }

  static bool passwordValidator(String value) {
    return value.length >= 6;
  }

  static bool phoneValidator(String value) {
    return value.length >= 11;
  }
}
