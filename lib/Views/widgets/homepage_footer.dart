import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GenericVars.scSize.height * 0.5,
      color: Color.fromARGB(255, 235, 233, 227),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/dhakaprokash_logo.png",
                  width: GenericVars.scSize.width * 0.5,
                  height: GenericVars.scSize.height * 0.1,
                ),
                Text("93,Kazi Nazrul Islam Avenue")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text(
                  "Newsroom",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text("+8801224323232"),
                Text("test@test.com"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text("Marketing", style: Theme.of(context).textTheme.bodyLarge),
                Text("+8801224323232"),
                Text("test@test.com"),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FollowSocialWidget(fontSize: 25, iconRadius: 20)),
        ],
      ),
    );
  }
}
