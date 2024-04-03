import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_video_list_widget.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryVideoView extends StatelessWidget {
  /*  final String categoryName;
  final String? categoryLink; */
  const CategoryVideoView({
    super.key,
    /*  required this.categoryName,
    required this.categoryLink, */
  });

  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Provider.of(context, listen: false);
    return Scaffold(
        //appBar: AppbarDefault(),
        body: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CategoryVideoListWidget(
                      isHeadSectionShow: false,
                      itemCount: GenericVars.getVideoData.length,
                      didDescriptionShow: false,
                      isScroll: false,
                      itemHeight: 0.35,
                      elevation: 0),
                  HomePageFooter()
                ],
              ),
            )

            /*  CustomScrollView(
              slivers: [
                /*     SliverAppBar(
                  pinned: true,
                  title: Text(
                    "Video",
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .fontSize,
                        color: Colors.blue),
                  ),
                  automaticallyImplyLeading: false,
                ), */
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(children: [
                      //Category News List
                      CategoryVideoListWidget(
                          isHeadSectionShow: false,
                          itemCount: 4,
                          didDescriptionShow: false,
                          isScroll: true,
                          itemHeight: 0.5,
                          elevation: 0),
               
                      HomePageFooter()
                    ]),
                  )
                ])),
              ],
            )) */

            /*  (categoryLink != null)
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
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(children: [
                                    //Category News List
                                    CategoryVideoListWidget(
                                        itemCount: 4,
                                        didDescriptionShow: false,
                                        isScroll: true,
                                        elevation: 0),
                                    /*  CategoryWidgetRegular(
                                      dhakaprokashModels: snapShot.data!,
                                      categoryName: categoryName,
                                      didMoreButtonShow: false,
                                      didHeadSectionShow: false,
                                      listItemLength: snapShot.data!.length,
                                      didFloat: false,
                                    ), */
                                    HomePageFooter()
                                  ]),
                                )
                              ])),
                            ],
                          )))
          : Center(
              child: Text("কোনো তথ্য পাওয়া যায় নি"),
            ), */
            ));
  }
}
