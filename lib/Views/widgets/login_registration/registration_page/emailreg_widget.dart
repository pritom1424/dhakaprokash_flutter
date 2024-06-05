import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailRegField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const EmailRegField(
      {super.key, required this.focusNode, required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.07,
        child: TextFormField(
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          focusNode: focusNode,
          decoration: const InputDecoration(
              /* border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)), */
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              hintText: 'Email',
              labelText: 'Email',
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.alternate_email,
                color: Colors.grey,
              )),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            provider.watch(registrationController).setEmail(value);
          },
        ),
      );
    });
  }
}
