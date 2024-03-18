import 'package:dummy_app/Controllers/registration_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          autofocus: false,
          keyboardType: TextInputType.name,
          focusNode: focusNode,
          decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.3)),
              hintText: 'Name',
              labelText: 'Name',
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              prefixIcon: Icon(
                Icons.face,
                color: Colors.grey,
              )),
          onFieldSubmitted: (value) {
            Utils.fieldFocusChange(context, focusNode, passwordFocusNode);
          },
          onChanged: (value) {
            provider.setName(value);
          },
        ),
      );
    });
  }
}
