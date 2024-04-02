import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/digital_clock.dart';
import 'package:flutter/material.dart';

class AppbarDefault extends StatelessWidget implements PreferredSize {
  final double widthSize;
  const AppbarDefault([this.widthSize = 0.45]);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Container(
        width: GenericVars.scSize.width * widthSize,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.075),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
              blurStyle: BlurStyle.normal // changes position of shadow
              ),
        ]),
        child: Image.asset(
          "assets/images/dhakaprokash_logo.png",
          fit: BoxFit.fill,
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 0.1),
          child: DigitalClockWidget()),
      actions: [
        // Notification Icon
        Badge(
          label: Text("0"),
          offset: Offset(-10, 6),
          child: IconButton(
            icon: Icon(
              size: 30,
              Icons.notifications_none_outlined,
              color: Colors.blueAccent,
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
