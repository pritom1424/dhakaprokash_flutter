import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesNewsView extends StatelessWidget {
  final PhotoController phController;

  const FavoritesNewsView({
    super.key,
    required this.phController,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
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
