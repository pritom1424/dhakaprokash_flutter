import 'package:dummy_app/Controllers/registration_controller.dart';
import 'package:dummy_app/Utils/app_validators.dart';
import 'package:dummy_app/Utils/components/round_button.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/utils.dart';
import 'package:dummy_app/Views/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailFocusNode = FocusNode();

  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final phoneFocusNose = FocusNode();
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
              children: [
                Image.asset(
                  'assets/images/dhakaprokash_logo.png',
                  width: GenericVars.scSize.width * 0.6, // Adjust as needed
                  height: GenericVars.scSize.height * 0.06,
                ),
                SizedBox(
                  height: 20,
                ),
                EmailRegField(
                    focusNode: emailFocusNode,
                    passwordFocusNode: nameFocusNode),
                SizedBox(height: 20),
                NameRegField(
                    focusNode: nameFocusNode,
                    passwordFocusNode: phoneFocusNose),
                SizedBox(height: 20),
                PhoneRegField(
                    focusNode: phoneFocusNose,
                    passwordFocusNode: passwordFocusNode),
                SizedBox(
                  height: 20,
                ),
                PasswordRegField(focusNode: passwordFocusNode),
                SizedBox(
                  height: 30,
                ),
                RegButtonWidget(),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: GenericVars.scSize.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: Color.fromARGB(255, 218, 236, 252),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 218, 236, 252),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage("assets/images/google_icon.png"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Continue With Google",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: GenericVars.scSize.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: Color.fromARGB(255, 218, 236, 252),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 218, 236, 252),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage("assets/images/facebook-icon.png"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Continue With Facebook",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class EmailRegField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const EmailRegField(
      {Key? key, required this.focusNode, required this.passwordFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.07,
        child: TextFormField(
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          focusNode: focusNode,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 16),
              prefixIcon: Icon(Icons.alternate_email)),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            print(value);
            provider.setEmail(value);
          },
        ),
      );
    });
  }
}

class PasswordRegField extends StatelessWidget {
  PasswordRegField({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;
  final ValueNotifier<bool> _obSecurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return ValueListenableBuilder(
          valueListenable: _obSecurePassword,
          builder: (context, value, child) {
            return SizedBox(
              height: GenericVars.scSize.height * 0.07,
              child: TextFormField(
                autofocus: false,
                obscureText: _obSecurePassword.value,
                focusNode: focusNode,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 16),
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
              ),
            );
          });
    });
  }
}

class NameRegField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const NameRegField(
      {Key? key, required this.focusNode, required this.passwordFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.07,
        child: TextFormField(
          autofocus: false,
          keyboardType: TextInputType.name,
          focusNode: focusNode,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: 16),
              prefixIcon: Icon(Icons.face)),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            print(value);
            provider.setName(value);
          },
        ),
      );
    });
  }
}

class PhoneRegField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const PhoneRegField(
      {Key? key, required this.focusNode, required this.passwordFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.07,
        child: TextFormField(
          autofocus: false,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Phone',
              labelText: 'Phone',
              labelStyle: TextStyle(fontSize: 16),
              prefixIcon: Icon(Icons.phone)),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            print(value);
            provider.setPhone(value);
          },
        ),
      );
    });
  }
}

class RegButtonWidget extends StatelessWidget {
  RegButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(builder: (context, provider, child) {
      return RoundButton(
        title: 'Register',
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
