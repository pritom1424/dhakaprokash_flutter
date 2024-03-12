import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';
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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Column(
              children: [
//search section
                Container(
                  height: GenericVars.scSize.height * 0.1,
                  child: Row(
                    children: [
                      Flexible(
                          flex: 4,
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
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey)),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    hintText: "typing...",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey))),
                              ))),
                      Container(
                        color: Colors.grey,
                        height: GenericVars.scSize.height * 0.05,
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => SearchToNewPage(
                                      textEditingController.text)));
                            },
                            icon: Icon(Icons.search)),
                      )
                    ],
                  ),
                ),
//category buttons grid
                Container(
                  height: GenericVars.scSize.height * 0.8,
                  width: double.infinity,
                  child: CategoryButton(
                      foundCategories: GenericVars.newspaperCategories.keys
                          .toList() //_foundCategories,
                      ),
                ),
//footer follow section
                Container(
                    height: GenericVars.scSize.height * 0.1,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: FollowSocialWidget(
                        fontSize: 18, iconRadius: 14)) //footer
              ],
            ),
          ),
        ),
      ),
    );
  }
}
