import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_drawer/category_buttonList.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/material.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String iconPath = "assets/images/dhakaprokash_icon.png";
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Header of the Drawer
          Material(
            color: Colors.blueAccent,
            child: InkWell(
              onTap: () {
                /// Close Navigation drawer before
                // Navigator.pop(context);
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()),);
              },
              child: Container(
                /*   decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/dhakaprokash_logo.png"))), */
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 5),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //  Image.asset("assets/images/dhakaprokash_logo.png"),
                    CircleAvatar(
                        radius: 52,
                        backgroundImage: AssetImage(
                            "assets/images/character_placeholder.png")

                        /*  NetworkImage(
                          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
                          // 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbHklMjBmYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
                          ), */
                        ),
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
          /* //footer follow section
          Container(
              height: GenericVars.scSize.height * 0.1,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: FollowSocialWidget(fontSize: 18, iconRadius: 14)) */
        ],
      ),
    )

        /*  ListView(
        // Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ), */
        );
  }
}
