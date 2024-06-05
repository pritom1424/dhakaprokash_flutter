import 'package:dummy_app/Utils/Controllers/all_controllers.dart';

import 'package:dummy_app/Utils/components/round_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegButtonWidget extends StatelessWidget {
  RegButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      return RoundButton(
        title: 'Register',
        loading:
            provider.watch(registrationController).loginLoading ? true : false,
        onPress: () {
          /* Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => LoginForm())); */
          Navigator.pop(context);
          // if (provider.email.isEmpty) {
          //   // Utils.flushBarErrorMessage('Please enter email', context);
          // } else if (AppValidator.emailValidator(provider.email.toString())) {
          //   // Utils.flushBarErrorMessage('Please enter valid email', context);
          // } else if (provider.password.isEmpty) {
          //   // Utils.flushBarErrorMessage('Please enter password', context);
          // } else if (provider.password.length < 6) {
          //   // Utils.flushBarErrorMessage(
          //   //     'Please enter 6 digit password', context);
          // } else {
          //   Map data = {
          //     'email': provider.email.toString(),
          //     'password': provider.password.toString(),
          //   };

          //   // Map data = {
          //   //   'email' : 'eve.holt@reqres.in',
          //   //   'password' : 'cityslicka',
          //   // };

          //   provider.loginApi(data).then((value) {
          //     if (value!['code'] == 200) {
          //       FocusNode().unfocus();
          //     } else {
          //       //Utils.flushBarErrorMessage("Try Again", context);
          //     }
          //   }).onError((error, stackTrace) {
          //     // Utils.flushBarErrorMessage(error.toString(), context);
          //   });
          // }
        },
      );
    });
  }
}
