import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:dummy_app/database/database_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FavoritesNewsView extends StatefulWidget {
  const FavoritesNewsView({
    super.key,
  });

  @override
  State<FavoritesNewsView> createState() => _FavoritesNewsViewState();
}

class _FavoritesNewsViewState extends State<FavoritesNewsView> {
  /* void refreshPosts() async {
    GenericVars.favoritesList = await DatabaseHelper().getPosts();
    setState(() {});
  } */

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(
                "ফেভারিট",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium!.fontSize,
                    color: AppColors.logoColorDeep),
              ),
              automaticallyImplyLeading: false,
            ),
            Consumer<BookmarkController>(
                child: SliverToBoxAdapter(
                  child: Container(
                    height: GenericVars.scSize.height * 0.6,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "কোনো বুকমার্ক পাওয়া যায় নি",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                builder: (context, snap, ch) {
                  return (snap.FavList.isEmpty)
                      ? ch!
                      : SliverList(
                          delegate: SliverChildListDelegate([
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                  children: List.generate(snap.FavList.length,
                                      (index) => snap.FavList[index])))
                        ]));
                })
          ],
        ));
  }
}
/* */
