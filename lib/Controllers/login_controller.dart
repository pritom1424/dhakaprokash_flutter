import 'package:dummy_app/Utils/app_validators.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  // final LoginRepository _loginRepository = LoginRepository();

  // LoginResponse? _login;
  // LoginResponse? get login => _login;

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

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

  bool isValidEmail() {
    return AppValidator.emailValidator(_email) &&
        AppValidator.passwordValidator(_password);
  }

  bool isValidPass() {
    return AppValidator.emailValidator(_email) &&
        AppValidator.passwordValidator(_password);
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
