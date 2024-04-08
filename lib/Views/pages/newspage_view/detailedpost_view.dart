import 'dart:convert';

import 'package:dummy_app/Controllers/detailpage_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_cat_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_details_more.dart';
import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_more.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_reg.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_reg_total.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_sp.dart';

import 'package:dummy_app/Views/widgets/detaildPost_view/comment_section.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/main_article_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/mainposthead_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/posttag_tile.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:provider/provider.dart';

class DetailedPostView extends StatelessWidget {
  /* final String url, title, description, categoryName;
  final String? imageCaption;
  final DateTime dateTime; */
  final int id;
  // final List<String> tags;

  const DetailedPostView({
    super.key,
    /*   required this.url,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.dateTime,
    required this.imageCaption,
    required this.tags, */
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    //List<Content> currentContainer = [];

    int gridItemCount = 4;
    List<Content> currentElementList(
        List<Content> allList, int id, int itemNumber) {
      List<Content> currentContainer = [];
      int first =
          (allList.indexWhere((element) => element.contentId == id) + 1) <
                  allList.length
              ? allList.indexWhere((element) => element.contentId == id) + 1
              : 0;

      currentContainer.clear();

      currentContainer = List.from(allList.sublist(first))
        ..addAll(allList.sublist(0, first));

      currentContainer = currentContainer.sublist(0, itemNumber);
      print("Current Container $currentContainer");
      return currentContainer;
    }

    //for test only
    if (Provider.of<DetailPageController>(context, listen: false)
        .IsCommentClick) {
      Provider.of<DetailPageController>(context, listen: false)
          .notCommentClick();
    }

    HomepageController homepageController =
        Provider.of<HomepageController>(context, listen: false);

    DetailPageController detailPageController =
        Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppbarDefault(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
            future: detailPageController.loadDeatilPost(id),
            builder: (context, snap) => (snap.connectionState ==
                    ConnectionState.waiting)
                ? LoaderWidget()
                : (snap.hasData)
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //main post head tile
                            Container(
                              //   height: GenericVars.scSize.height * 0.6,

                              child: MainHeadPostTile(
                                id: id,
                                tags: snap.data!.detailsContent.tags.split(","),
                                imageCaption:
                                    snap.data!.detailsContent.imgBgCaption,
                                dateTime: snap.data!.detailsContent.createdAt,
                                url:
                                    "https://admin.dhakaprokash24.com/media/content/images/${snap.data!.detailsContent.imgBgPath}",
                                title: snap.data!.detailsContent.contentHeading,
                                categoryname: snap
                                    .data!.detailsContent.category.catNameBn,
                                description:
                                    snap.data!.detailsContent.contentDetails,
                              ),
                            ),
                            //main post decription
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: MainArticleTile(
                                  articleItems: [
                                    HtmlWidget(
                                      snap.data!.detailsContent.contentDetails,
                                    ),
                                  ],
                                )),
                            //Line divider
                            Divider(),

                            //post tag tile
                            PostTagTile(
                              tagList:
                                  snap.data!.detailsContent.tags.split(","),
                              crossAxisCount: 3,
                            ),
                            //comment button

                            /*  Consumer<DetailPageController>(
                              builder: (ctx, snap, _) => (snap.IsCommentClick)
                                  ? const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: CommentSectionWidget(),
                                    )
                                  : Container(
                                      height: GenericVars.scSize.height * 0.07,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: SizedBox.expand(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Provider.of<DetailPageController>(
                                                    context,
                                                    listen: false)
                                                .commentClick();
                                          },
                                          child: Text("Comment",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              foregroundColor: Colors.white),
                                        ),
                                      ),
                                    ),
                            ), */

                            /* CategoryGridWidgetMore(
                              dhakaprokashModels: List.generate(
                                  snap
                                      .data!
                                      .moreDetailContent[snap
                                          .data!.moreDetailContent
                                          .indexWhere((element) =>
                                              element.contentId == id)]
                                      .morecatwisePost
                                      .length,
                                  (index) => snap
                                      .data!
                                      .moreDetailContent[snap
                                          .data!.moreDetailContent
                                          .indexWhere((element) =>
                                              element.contentId == id)]
                                      .morecatwisePost[index]),
                              categoryName:
                                  snap.data!.detailsContent.category.catNameBn,
                              itemCount: snap
                                  .data!
                                  .moreDetailContent[
                                      snap.data!.moreDetailContent.indexWhere(
                                          (element) => element.contentId == id)]
                                  .morecatwisePost
                                  .length,
                              didAxisHorizontal: false,
                              crossAxisCount: 2,
                              didDescriptionShow: false,
                              isScroll: false,
                              elevation: 0,
                              itemHeight: 0.23,
                            ), */

                            HomePageFooter()
                          ],
                        ),
                      )
                    : Center(
                        child: Text("কোনো তথ্য পাওয়া যায় নি!"),
                      )),
      ),
    );
  }
}

/*  Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
          //main Post  (headline + image + article)
                  
          //news tags bar
          
          //second part after main post included all lists
                  FutureBuilder(
                      future: postController.loadAllItems(),
                      builder: (ctx, postSnapShot) {
                        return (postSnapShot.connectionState ==
                                ConnectionState.waiting)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CategoryGridWidget(
                                photoModels: photoController.Items,
                                postModels: postController.Items,
                                categoryName: categoryName,
                                itemCount: 4,
                                cellHeight: 0.23,
                                didDescriptionShow: false,
                                didAxisHorizontal: false,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                isScroll: false,
                                elevation: 0,
                              );
                      }),
                  HomePageFooter()
                ],
              ),
            ), */
