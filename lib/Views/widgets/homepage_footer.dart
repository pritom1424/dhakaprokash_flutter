import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return Container(
      height: scSize.height * 0.5,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/dhakaprokash_logo.png",
                  width: scSize.width * 0.5,
                  height: scSize.height * 0.1,
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
