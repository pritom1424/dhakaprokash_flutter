import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/login_registration/registration_page/emailreg_widget.dart';
import 'package:dummy_app/Views/widgets/login_registration/registration_page/namereg_widget.dart';
import 'package:dummy_app/Views/widgets/login_registration/registration_page/passreg_widget.dart';
import 'package:dummy_app/Views/widgets/login_registration/registration_page/phonereg_widget.dart';
import 'package:dummy_app/Views/widgets/login_registration/registration_page/registerbutton_widget.dart';
import 'package:flutter/material.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
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
