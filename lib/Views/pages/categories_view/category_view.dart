import 'package:dummy_app/Controllers/homepage_controller.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;
  final String? categoryLink;
  final bool? isPost;
  const CategoryView({
    super.key,
    required this.categoryName,
    required this.categoryLink,
    this.isPost,
  });

  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppbarDefault(),
      body: (categoryLink != null)
          ? FutureBuilder(
              future: (isPost == null || isPost == false)
                  ? homepageController.loadAllRegItems(categoryLink!)
                  : homepageController.loadAllRegItemsPost(categoryLink!, 10),
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
                                  padding: EdgeInsets.symmetric(horizontal: 8),
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
              child: Text("কোনো তথ্য পাওয়া যায় নি"),
            ),
    );
  }
}
