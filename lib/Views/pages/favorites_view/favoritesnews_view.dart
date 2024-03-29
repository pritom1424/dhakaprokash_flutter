import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:flutter/material.dart';

class FavoritesNewsView extends StatelessWidget {
  const FavoritesNewsView({
    super.key,
  });

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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: (GenericVars.favoritesList.isNotEmpty)
                    ? Column(
                        children: List.generate(
                            GenericVars.favoritesList.length,
                            (index) => GenericVars.favoritesList[index]))
                    : Center(
                        child: Text(
                          "no favorites",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
              )
            ]))
          ],
        ));
  }
}
/* */
