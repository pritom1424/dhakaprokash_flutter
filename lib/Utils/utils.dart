import 'package:flutter/material.dart';

class Utils {
  // we will use this function to shift focus from one text field to another text field
  // we are using to avoid duplications of code
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  // generic toast message imported from toast package
  // we will utilise this for showing errors or success messages
  /*  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
    backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  } */
}

// we will utilise this for showing errors or success messages
snackBar(String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(message)));
}
