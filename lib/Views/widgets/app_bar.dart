import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class AppbarDefault extends StatelessWidget implements PreferredSize {
  final double widthSize;
  const AppbarDefault([this.widthSize = 0.35]);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Container(
        width: GenericVars.scSize.width * widthSize,
        child: Image.asset(
          "assets/images/dhakaprokash_logo.png",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
