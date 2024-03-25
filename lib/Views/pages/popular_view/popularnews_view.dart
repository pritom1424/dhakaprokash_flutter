import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';

import 'package:dummy_app/Views/widgets/category_widget_sp.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularNewsView extends StatelessWidget {
  final PhotoController phController;

  const PopularNewsView({
    super.key,
    required this.phController,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    HomepageController homepageController = Provider.of(context, listen: false);

    return FutureBuilder(
        future: homepageController.loadAllSpItems(),
        builder: (ctx, postSnapShot) {
          return (postSnapShot.connectionState == ConnectionState.waiting)
              ? LoaderWidget()
              : Scrollbar(
                  thumbVisibility: true,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        title: Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize,
                              color: Colors.blue),
                        ),
                        automaticallyImplyLeading: false,
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(children: [
                            //Category News List

                            CategoryWidgetSpecial(
                              dhakaprokashModels: homepageController.Items,
                              categoryName: "Popular",
                              didMoreButtonShow: false,
                              didHeadSectionShow: false,
                              listItemLength: 8,
                              didFloat: false,
                            ),
                            HomePageFooter()
                          ]),
                        )
                      ]))
                    ],
                  ));
        });
  }
}
/* */
