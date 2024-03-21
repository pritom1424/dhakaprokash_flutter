import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/dummy_tags.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget%20copy.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/main_article_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/mainposthead_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/posttag_tile.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedPostView extends StatelessWidget {
  final String url, title, description, categoryName, date;
  const DetailedPostView(
      {super.key,
      required this.url,
      required this.title,
      required this.description,
      required this.categoryName,
      required this.date});

  @override
  Widget build(BuildContext context) {
    //for test only
    List<String> tags = DummyTags().categoryTags[categoryName] ?? [];
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    HomepageController homepageController =
        Provider.of<HomepageController>(context);
    return Scaffold(
      appBar: AppbarDefault(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//main post head tile
              Container(
                //   height: GenericVars.scSize.height * 0.6,

                child: MainHeadPostTile(
                  date: date,
                  url: url,
                  title: title,
                  categoryname: categoryName,
                  isBookmark: false,
                  description: description,
                ),
              ),
//main post decription
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: MainArticleTile(
                    articleItems: [
                      HtmlWidget(description),
                    ],
                  )),
//post tag tile
              Container(
                padding: const EdgeInsets.only(
                    top: 10), //symmetric(horizontal: 10, vertical: 5),
                //  height: (tags.isEmpty) ? 0 : GenericVars.scSize.height * 0.2,

                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.4, color: Colors.grey))),
                child: PostTagTile(
                  tagList: tags,
                  crossAxisCount: 2,
                ),
              ),
//comment button
              Container(
                height: GenericVars.scSize.height * 0.07,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SizedBox.expand(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Comment",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                  ),
                ),
              ),
// news grid
              /* FutureBuilder(
                  future: postController.loadAllItems(),
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CategoryGridWidget(
                            photoModels: photoController.Items,
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
                  }) ,*/

              FutureBuilder(
                  future: homepageController.loadAllItems(),
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CategoryGridWidgetCopy(
                            dhakaprokashModels: homepageController.Items,
                            categoryName: categoryName,
                            itemCount: 4,
                            didAxisHorizontal: false,
                            crossAxisCount: 2,
                            didDescriptionShow: false,
                            isScroll: false,
                            elevation: 0);
                  }),
              HomePageFooter()
            ],
          ),
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
