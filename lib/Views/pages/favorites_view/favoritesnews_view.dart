import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:dummy_app/database/database_helper.dart';

import 'package:flutter/material.dart';

class FavoritesNewsView extends StatefulWidget {
  const FavoritesNewsView({
    super.key,
  });

  @override
  State<FavoritesNewsView> createState() => _FavoritesNewsViewState();
}

class _FavoritesNewsViewState extends State<FavoritesNewsView> {
  void refreshPosts() async {
    GenericVars.favoritesList = await DatabaseHelper().getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(
                "Favorites",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium!.fontSize,
                    color: Colors.blue),
              ),
              automaticallyImplyLeading: false,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              FutureBuilder(
                  future: DatabaseHelper().getPosts(),
                  builder: (context, snap) {
                    return (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: (GenericVars.favoritesList!.isNotEmpty)
                                ? Column(
                                    children: List.generate(
                                        GenericVars.favoritesList!.length,
                                        (index) =>
                                            GenericVars.favoritesList![index]))
                                : Center(
                                    child: Text(
                                      "no favorites",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                          );
                  })
            ]))
          ],
        ));
  }
}
/* */
