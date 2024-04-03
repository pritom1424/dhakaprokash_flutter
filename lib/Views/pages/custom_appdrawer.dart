import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_drawer/category_buttonList.dart';

import 'package:flutter/material.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String iconPath = "assets/images/dhakaprokash_icon.png";
    return Drawer(
        backgroundColor: AppColors.logoColorDeep,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Header of the Drawer
            Container(
              // borderOnForeground: false,
              //color: AppColors.logoColorDeep,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top, bottom: 5),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //  Image.asset("assets/images/dhakaprokash_logo.png"),
                      CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.orange,
                          backgroundImage: AssetImage(
                              "assets/images/character_placeholder.png")),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'User',
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      Text(
                        '@user.com',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            CategoryButtonList(
                foundCategories: GenericVars.newspaperCategories.keys.toList()),
          ],
        ));
  }
}
