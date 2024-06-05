import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookmarkController = ChangeNotifierProvider<BookmarkController>((ref) {
  return BookmarkController();
});

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
            Consumer(
                child: SliverToBoxAdapter(
                  child: SizedBox(
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
                  return (snap.watch(bookmarkController).FavList.isEmpty)
                      ? ch!
                      : SliverList(
                          delegate: SliverChildListDelegate([
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                  children: List.generate(
                                      snap
                                          .watch(bookmarkController)
                                          .FavList
                                          .length,
                                      (index) => snap
                                          .watch(bookmarkController)
                                          .FavList[index])))
                        ]));
                })
          ],
        ));
  }
}
/* */
