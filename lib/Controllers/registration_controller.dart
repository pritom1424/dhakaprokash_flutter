import 'package:dummy_app/Utils/app_validators.dart';
import 'package:dummy_app/Views/pages/login_page.dart';
import 'package:flutter/cupertino.dart';

class RegistrationProvider with ChangeNotifier {
  // final LoginRepository _loginRepository = LoginRepository();

  // LoginResponse? _login;
  // LoginResponse? get login => _login;

  String _email = '';
  String _password = '';
  String _name = '';
  String _phone = '';

  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get phone => _phone;

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setName(String name) {
    name = name;
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  bool isValidEmail() {
    return AppValidator.emailValidator(_email) &&
        AppValidator.passwordValidator(_password) &&
        AppValidator.phoneValidator(_phone);
  }

  bool isValidPass() {
    return AppValidator.emailValidator(_email) &&
        AppValidator.passwordValidator(_password) &&
        AppValidator.phoneValidator(_phone);
  }

  bool isValidPhone() {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");

    return AppValidator.emailValidator(_email) &&
        AppValidator.passwordValidator(_password) &&
        phoneRegExp.hasMatch(_phone);
  }

  bool isValidName() {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(_name);
  }

  Future<Map<String, dynamic>?> loginApi(data) async {
    // try {
    //  // final loginResponse = await _loginRepository.loginApi(data);
    //   return loginResponse;
    // } catch (error) {
    //   print('Error fetching login data: $error');
    //   throw Exception('Failed to fetch login data');
    // }
  }
}

// class PasswordValidator {
//   static bool validate(String value) {
//     return value.length >= 6;
//   }
// }
