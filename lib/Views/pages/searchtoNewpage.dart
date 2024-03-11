import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchToNewPage extends StatefulWidget {
  final String searchString;
  SearchToNewPage(this.searchString, {super.key});

  @override
  State<SearchToNewPage> createState() => _SearchToNewPageState();
}

class _SearchToNewPageState extends State<SearchToNewPage> {
  List<PhotoModel> currentSearchItems = [];
  @override
  void dispose() {
    currentSearchItems.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.searchString.toLowerCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: FutureBuilder(
            future: photoController
                .loadSearchAllItems(widget.searchString.toLowerCase()),
            builder: (ctx, photosnapShot) => (photosnapShot.connectionState ==
                    ConnectionState.waiting)
                ? const LoaderWidget()
                : FutureBuilder(
                    future: postController.loadAllItems(),
                    builder: (ctx, postSnapShot) {
                      currentSearchItems = photoController.SearchItems;
                      return (postSnapShot.connectionState ==
                              ConnectionState.waiting)
                          ? const LoaderWidget()
                          : (currentSearchItems.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: CategoryWidget(
                                        photoModels:
                                            photoController.SearchItems,
                                        postModels: postController.Items,
                                        categoryName: "Search",
                                        didMoreButtonShow: false,
                                        didHeadSectionShow: false,
                                        listItemLength: 8,
                                        didFloat: false),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  "Not Found",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )));
                    })));
  }
}
