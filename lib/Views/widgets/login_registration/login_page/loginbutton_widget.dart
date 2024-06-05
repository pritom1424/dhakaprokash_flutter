// loginButton

import 'package:dummy_app/Controllers/login_controller.dart';
import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/app_validators.dart';
import 'package:dummy_app/Utils/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButtonWidget extends StatelessWidget {
  LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, _) {
      return RoundButton(
        title: 'Login',
        loading: provider.watch(loginController).loginLoading ? true : false,
        onPress: () {
          if (provider.watch(loginController).email.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter email', context);
          } else if (AppValidator.emailValidator(
              provider.watch(loginController).email.toString())) {
            // Utils.flushBarErrorMessage('Please enter valid email', context);
          } else if (provider.watch(loginController).password.isEmpty) {
            // Utils.flushBarErrorMessage('Please enter password', context);
          } else if (provider.watch(loginController).password.length < 6) {
            // Utils.flushBarErrorMessage(
            //     'Please enter 6 digit password', context);
          } else {
            Map data = {
              'email': provider.watch(loginController).email.toString(),
              'password': provider.watch(loginController).password.toString(),
            };

            // Map data = {
            //   'email' : 'eve.holt@reqres.in',
            //   'password' : 'cityslicka',
            // };

            provider.watch(loginController).loginApi(data).then((value) {
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
