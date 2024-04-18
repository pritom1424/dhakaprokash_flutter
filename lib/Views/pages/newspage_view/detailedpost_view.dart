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
import 'package:intl/intl.dart';

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

  // String originalString = '<p style=\"text-align: justify;\">&nbsp;</p>\r\n';
  // String filteredString = originalString.replaceAll('<p style=\"text-align: justify;\">&nbsp;</p>\r\n', '');

// Now you can use filteredString in your Flutter code

  String removeUnnecessaryHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<p style=\"text-align: justify;\">&nbsp;</p>'), '');
  }

  @override
  Widget build(BuildContext context) {
    //List<Content> currentContainer = [];

    int gridItemCount = 4;

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
                                postLink:
                                    "/${snap.data!.detailsContent.category.catSlug}/${snap.data!.detailsContent.subcategory.subcatSlug ?? (snap.data!.detailsContent.contentType == 1 ? 'news' : 'article')}/${snap.data!.detailsContent.contentId}",
                                authorName: snap.data!.detailsContent.author
                                        .authorNameBn ??
                                    "ঢাকাপ্রকাশ ডেস্ক",
                                authorSlug: snap.data!.detailsContent.author
                                        .authorSlug ??
                                    "dhaka-prokash-desk",
                                id: id,
                                tags: (snap.data!.detailsContent.tags != null)
                                    ? snap.data!.detailsContent.tags!.split(",")
                                    : [],
                                imageCaption:
                                    snap.data!.detailsContent.imgBgCaption,
                                dateTime: snap.data!.detailsContent.createdAt ??
                                    DateTime.now(),
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
                            HtmlWidget(
                                removeUnnecessaryHtmlTags(snap.data!.detailsContent.contentDetails.toString()),
                                // snap.data!.detailsContent.contentDetails ?? "",
                                customWidgetBuilder: (element) {
                                  if (!element.classes.contains("image")) {
                                    /*  print(
                                    "element attr: ${element.children.toString() + "name"}");
                                if (element.children
                                    .toString()
                                    .contains('img')) {
                                  print(
                                      "elem :${element.children[0].attributes['src']}");
                                  return Image.network(
                                      element.children[0].attributes['src']!);
                                }
                                print("only text ${element.text}");
                                return Text(
                                  Bidi.stripHtmlIfNeeded(element.text),
                                  textAlign: TextAlign.justify,
                                ); */
                                    return null;
                                  }

                                  return Column(
                                    children: [
                                      Image.network(
                                        element.children[0].attributes['src']!,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(snap.data!.detailsContent.imgBgCaption ??
                                          ""),
                                      Divider()
                                    ],
                                  );
                                }
                            ),

                            /* Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              child: HtmlWidget(
                                snap.data!.detailsContent.contentDetails ?? "",
                              ), /*  MainArticleTile(
                                  articleItems: [
                                    /* Text(Bidi.stripHtmlIfNeeded(snap.data!
                                            .detailsContent.contentDetails ??
                                        "")) */
                                    HtmlWidget(
                                      snap.data!.detailsContent
                                              .contentDetails ??
                                          "",
                                    ),
                                  ],
                                ) */
                            ), */
                            //Line divider
                            Divider(),

                            //post tag tile
                            PostTagTile(
                              tagList: (snap.data!.detailsContent.tags != null)
                                  ? snap.data!.detailsContent.tags!.split(",")
                                  : [],
                              crossAxisCount: 3,
                            ),
                            //comment button

                            FutureBuilder(
                                future: detailPageController.loadMoreCatPost(
                                    snap.data!.detailsContent.catId ?? -1,
                                    snap.data!.detailsContent.contentId ?? -1),
                                builder: (ctx, snapMore) => (snapMore.hasData)
                                    ? CategoryGridWidgetMore(
                                        dhakaprokashModels: snapMore.data!,
                                        categoryName: snap.data!.detailsContent
                                                .category.catNameBn ??
                                            "",
                                        itemCount:
                                            snapMore.data!.contents.length,
                                        didAxisHorizontal: false,
                                        crossAxisCount: 2,
                                        didDescriptionShow: false,
                                        isScroll: false,
                                        elevation: 0)
                                    : SizedBox.shrink()),

                            HomePageFooter()
                          ],
                        ),
                      )
                    : Center(
                        child: Text("কোনো তথ্য পাওয়া যায় নি!"),
                      )
        ),
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
