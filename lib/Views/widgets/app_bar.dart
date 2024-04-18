import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppbarDefault extends StatelessWidget implements PreferredSize {
  final double widthSize;
  const AppbarDefault([this.widthSize = 0.45]);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Scaffold.of(context).openDrawer();
        //     // scaffoldKey.currentState!.openDrawer();
        //   },
        //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //   icon: Icon(
        //     Icons.menu,
        //     size: 25,
        //     color: Colors.red,
        //   )),

      title: Container(
        width: GenericVars.scSize.width * widthSize,
        /*  decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.075),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
              blurStyle: BlurStyle.normal // changes position of shadow
              ),
        ]), */
        child: Image.asset(
          "assets/images/dhakaprokash_logo.png",
          fit: BoxFit.fill,
        ),
      ),
      /* bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.1),
          child: DigitalClockWidget()), */
      actions: [
        // Notification Icon
        Badge(
          largeSize: 13,
          label: Text(
            "0",
            style: TextStyle(fontSize: 10),
          ),
          offset: Offset(-12, 6),
          child: IconButton(
            icon: const Icon(
              size: 23,
              CupertinoIcons.bell,
              // Icons.notifications_none_outlined,
              color: AppColors.logoColorDeep,
            ),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
