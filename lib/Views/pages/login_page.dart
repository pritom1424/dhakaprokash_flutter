// loginForm widget
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/register_page.dart';
import 'package:dummy_app/Views/widgets/login_registration/login_page/emailfield_widget.dart';
import 'package:dummy_app/Views/widgets/login_registration/login_page/loginbutton_widget.dart';
import 'package:dummy_app/Views/widgets/login_registration/login_page/passwordfiled_widget.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

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
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              height: GenericVars.scSize.height * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/dhakaprokash_logo.png',
                    width: GenericVars.scSize.width * 0.6, // Adjust as needed
                    height: GenericVars.scSize.height * 0.06,
                  ),
                  const SizedBox(height: 50),
                  EmailField(
                    focusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(height: 50),
                  LoginButtonWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text("Forgotten Password?")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const RegisterPage()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        fixedSize: Size(GenericVars.scSize.width * 0.9,
                            GenericVars.scSize.height * 0.065)),
                    child: const Text(
                      "Create New Account",
                      style: TextStyle(fontSize: 18),
                    ),
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



// provider

/* class PasswordValidator {
  static bool validate(String value) {
    return value.length >= 6;
  }
} */
