import 'dart:ui';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';
import 'package:dummy_app/Views/widgets/app_drawer/category_buttonList.dart';
import 'package:dummy_app/Views/widgets/app_drawer/category_buttons.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //List<String> _foundCategories = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    //_foundCategories = GenericVars.newspaperCategories.keys.toList();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

/*   void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      _foundCategories = GenericVars.newspaperCategories.keys.toList();
    } else {
      _foundCategories = GenericVars.newspaperCategories.keys
          .toList()
          .where((user) =>
              user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
  } */

  @override
  Widget build(BuildContext context) {
    String iconPath = "assets/images/dhakaprokash_icon.png";
    return Drawer(
        width: 250,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  height: GenericVars.scSize.height * 0.03,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Image.asset(
                    iconPath,
                    filterQuality: FilterQuality.low,
                  ),
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight
                          .normal), //Theme.of(context).textTheme.headlineLarge
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//search section
                  Container(
                      height: GenericVars.scSize.height * 0.1,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.3, color: Colors.grey))),
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: TextField(
                            controller: textEditingController,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 105, 102, 102)),
                            /*    onChanged: (value) {
                                  setState(() {
                                    // textEditingController.text = value;
                                  });
                                  return _runFilter(value);
                                }, */
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                hintText: "Search...",
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => SearchToNewPage(
                                                  textEditingController.text)));
                                    },
                                    icon: Icon(Icons.search)),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey))),
                          ))),
                  /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SearchToNewPage(
                                        textEditingController.text))); */
//category buttons grid
                  CategoryButtonList(
                      foundCategories:
                          GenericVars.newspaperCategories.keys.toList()),
                  /*   CategoryButton(
                      foundCategories: GenericVars.newspaperCategories.keys
                          .toList() //_foundCategories,
                      ), */
//footer follow section
                  Container(
                      height: GenericVars.scSize.height * 0.1,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: FollowSocialWidget(fontSize: 18, iconRadius: 14))
                  //footer
                ],
              ),
            ),
          ),
        ));
  }
}
