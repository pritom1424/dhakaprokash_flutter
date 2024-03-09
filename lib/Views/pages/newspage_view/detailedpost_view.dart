import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/dummy_tags.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/mainpost_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/posttag_tile.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailedPostView extends StatelessWidget {
  final String url, title, description, categoryName;
  const DetailedPostView(
      {super.key,
      required this.url,
      required this.title,
      required this.description,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    //for test only

    List<String> tags = DummyTags().categoryTags[categoryName] ?? [];
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 30),
          child: Image.asset(
            "assets/images/dhakaprokash_logo.png",
            width: GenericVars.scSize.width * 0.5,
            height: GenericVars.scSize.height * 0.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//main Post  (headline + image + article)
              Container(
                height: GenericVars.scSize.height * 0.8,
                padding: EdgeInsets.only(bottom: 10),
                child: MainPostTile(
                  url: url,
                  title: title,
                  description: description,
                  boldDescription: description,
                  categoryname: categoryName,
                ),
              ),
//news tags bar
              Container(
                padding: const EdgeInsets.only(
                    top: 10), //symmetric(horizontal: 10, vertical: 5),
                height: GenericVars.scSize.height * 0.2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 0.4, color: Colors.grey))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$categoryName",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    PostTagTile(
                      tagList: tags,
                    ),
                  ],
                ),
              ),
//second part after main post included all lists
              FutureBuilder(
                  future: postController.loadAllItems(),
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
//same category more articles
                              CategoryWidget(
                                  photoModels: photoController.Items,
                                  postModels: postController.Items,
                                  categoryName: "More Articles"),
//recent category second articles grid list
                              CategoryGridWidget(
                                photoModels: photoController.Items,
                                postModels: postController.Items,
                                itemCount: 4,
                                categoryName: "Recent",
                                gridHeight: 0.3,
                              ),
//recent category articles
//main tile of recent
                              Container(
                                height: GenericVars.scSize.height * 0.8,
                                padding: EdgeInsets.only(bottom: 10, top: 20),
                                child: MainPostTile(
                                  url: url,
                                  title: title,
                                  description: description,
                                  boldDescription: description,
                                  categoryname:
                                      "Entertainment", // for test only
                                ),
                              ),
//tag tile of recent
                              Container(
                                padding: const EdgeInsets.only(
                                    top:
                                        10), //symmetric(horizontal: 10, vertical: 5),
                                height: GenericVars.scSize.height * 0.2,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 0.4, color: Colors.grey))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Entertainment", //for test
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    PostTagTile(
                                      tagList: tags,
                                    ),
                                  ],
                                ),
                              ),
                              // more list of recent categories. here for demo took entertainment as recent category
                              CategoryWidget(
                                  photoModels: photoController.Items,
                                  postModels: postController.Items,
                                  categoryName: "entertainment"),
// recent news in grid with much items
                              CategoryGridWidget(
                                photoModels: photoController.Items,
                                postModels: postController.Items,
                                categoryName: "Recent",
                                itemCount: 10,
                                gridHeight: 0.8,
                              ),
                            ],
                          );
                  }),
              HomePageFooter()
            ],
          ),
        ),
      ),
    );
  }
}
