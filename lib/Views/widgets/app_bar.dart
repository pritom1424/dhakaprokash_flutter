import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class AppbarDefault extends StatelessWidget {
  const AppbarDefault({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: EdgeInsets.only(left: 30),
        child: Image.asset(
          "assets/images/dhakaprokash_logo.png",
          width: GenericVars.scSize.width * 0.5,
          height: GenericVars.scSize.height * 0.2,
        ),
      ),
    );
  }
}
