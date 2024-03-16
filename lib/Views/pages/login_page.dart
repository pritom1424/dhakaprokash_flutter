// loginForm widget

import 'package:dummy_app/Utils/app_validators.dart';
import 'package:dummy_app/Utils/components/round_button.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/utils.dart';
import 'package:dummy_app/Views/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailFocusNode = FocusNode();

  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              height: GenericVars.scSize.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/dhakaprokash_logo.png',
                    width: GenericVars.scSize.width * 0.6, // Adjust as needed
                    height: GenericVars.scSize.height * 0.06,
                  ),
                  SizedBox(height: 50),
                  EmailField(
                    focusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                  ),
                  SizedBox(height: 20),
                  PasswordField(
                    focusNode: passwordFocusNode,
                  ),
                  SizedBox(height: 50),
                  LoginButtonWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {}, child: Text("Forgotten Password?")),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => RegisterPage()));
                    },
                    child: Text(
                      "Create New Account",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        fixedSize: Size(GenericVars.scSize.width * 0.9,
                            GenericVars.scSize.height * 0.065)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Email

class EmailField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const EmailField(
      {Key? key, required this.focusNode, required this.passwordFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        focusNode: focusNode,
        decoration: const InputDecoration(
            hintText: 'Email',
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 20),
            prefixIcon: Icon(Icons.alternate_email)),
        onFieldSubmitted: (value) {
          Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
        },
        onChanged: (value) {
          print(value);
          provider.setEmail(value);
        },
      );
    });
  }
}

// loginButton

class LoginButtonWidget extends StatelessWidget {
  LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return RoundButton(
        title: 'Login',
        loading: provider.loginLoading ? true : false,
        onPress: () {
          if (provider.email.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter email', context);
          } else if (AppValidator.emailValidator(provider.email.toString())) {
            // Utils.flushBarErrorMessage('Please enter valid email', context);
          } else if (provider.password.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter password', context);
          } else if (provider.password.length < 6) {
            // Utils.flushBarErrorMessage(
            //     'Please enter 6 digit password', context);
          } else {
            Map data = {
              'email': provider.email.toString(),
              'password': provider.password.toString(),
            };

            // Map data = {
            //   'email' : 'eve.holt@reqres.in',
            //   'password' : 'cityslicka',
            // };

            provider.loginApi(data).then((value) {
              if (value!['code'] == 200) {
                FocusNode().unfocus();
              } else {
                //Utils.flushBarErrorMessage("Try Again", context);
              }
            }).onError((error, stackTrace) {
              // Utils.flushBarErrorMessage(error.toString(), context);
            });
          }
        },
      );
    });
  }
}

// pass

class PasswordField extends StatelessWidget {
  PasswordField({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;
  final ValueNotifier<bool> _obSecurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return ValueListenableBuilder(
          valueListenable: _obSecurePassword,
          builder: (context, value, child) {
            return TextFormField(
              autofocus: false,
              obscureText: _obSecurePassword.value,
              focusNode: focusNode,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 20),
                prefixIcon: const Icon(Icons.lock_open_rounded),
                suffixIcon: InkWell(
                    onTap: () {
                      _obSecurePassword.value = !_obSecurePassword.value;
                    },
                    child: Icon(_obSecurePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility)),
              ),
              onChanged: (value) {
                provider.setPassword(value);
              },
            );
          });
    });
  }
}

// provider

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
        PasswordValidator.validate(_password);
  }

  bool isValidPass() {
    return PasswordValidator.validate(_email) &&
        PasswordValidator.validate(_password);
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

class PasswordValidator {
  static bool validate(String value) {
    return value.length >= 6;
  }
}
