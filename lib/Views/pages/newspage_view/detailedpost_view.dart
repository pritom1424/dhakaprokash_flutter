import 'package:dummy_app/Controllers/detailpage_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/dummy_tags.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget_sp.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/comment_section.dart';
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
  final String url, title, description, categoryName, date, imageCaption;
  final List<String> tags;

  const DetailedPostView({
    super.key,
    required this.url,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.date,
    required this.imageCaption,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    //for test only
    if (Provider.of<DetailPageController>(context, listen: false)
        .IsCommentClick) {
      Provider.of<DetailPageController>(context, listen: false)
          .notCommentClick();
    }
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
                  tags: tags,
                  imageCaption: imageCaption,
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
                      HtmlWidget(
                        description,
                      ),
                    ],
                  )),
//Line divider
              Divider(),

//post tag tile
              PostTagTile(
                tagList: tags,
                crossAxisCount: 3,
              ),
//comment button

              Consumer<DetailPageController>(
                builder: (ctx, snap, _) => (snap.IsCommentClick)
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: CommentSectionWidget(),
                      )
                    : Container(
                        height: GenericVars.scSize.height * 0.07,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox.expand(
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<DetailPageController>(context,
                                      listen: false)
                                  .commentClick();
                            },
                            child: Text("Comment",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white),
                          ),
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
                  future: homepageController.loadAllSpItems(),
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CategoryGridWidgetSpecial(
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
