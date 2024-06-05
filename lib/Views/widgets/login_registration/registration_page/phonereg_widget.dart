import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneRegField extends StatelessWidget {
  final FocusNode focusNode, passwordFocusNode;
  const PhoneRegField(
      {super.key, required this.focusNode, required this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      return SizedBox(
        height: GenericVars.scSize.height * 0.07,
        child: TextFormField(
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          autofocus: false,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              hintText: 'Phone',
              labelText: 'Phone',
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              )),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            print(value);
            provider.watch(registrationController).setPhone(value);
          },
        ),
      );
    });
  }
}
