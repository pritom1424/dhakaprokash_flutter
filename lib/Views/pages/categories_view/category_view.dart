import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/category_widget_reg.dart';

import 'package:dummy_app/Views/widgets/category_widget_sp.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;
  final String? categoryLink;
  const CategoryView({
    super.key,
    required this.categoryName,
    required this.categoryLink,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    HomepageController homepageController = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppbarDefault(),
      body: (categoryLink != null)
          ? FutureBuilder(
              future: homepageController.loadAllRegItems(categoryLink!),
              builder: (ctx, snapShot) =>
                  (snapShot.connectionState == ConnectionState.waiting)
                      ? LoaderWidget()
                      : Scrollbar(
                          thumbVisibility: true,
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                pinned: true,
                                title: Text(
                                  categoryName,
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
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(children: [
                                    //Category News List

                                    CategoryWidgetRegular(
                                      dhakaprokashModels: snapShot.data!,
                                      categoryName: categoryName,
                                      didMoreButtonShow: false,
                                      didHeadSectionShow: false,
                                      listItemLength: snapShot.data!.length,
                                      didFloat: false,
                                    ),
                                    HomePageFooter()
                                  ]),
                                )
                              ])),
                            ],
                          )))
          : Center(
              child: Text("No Link Found"),
            ),
    );
  }
}
