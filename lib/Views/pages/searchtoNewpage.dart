import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchToNewPage extends StatefulWidget {
  SearchToNewPage({super.key});

  @override
  State<SearchToNewPage> createState() => _SearchToNewPageState();
}

class _SearchToNewPageState extends State<SearchToNewPage> {
  List<PhotoModel> currentSearchItems = [];
  TextEditingController textEditingController = TextEditingController();
  bool didShowList = false;
  @override
  void dispose() {
    currentSearchItems.clear();
    textEditingController.dispose();
    didShowList = false;
    GenericVars.currentSearchString = "";
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);

    return Scaffold(
        appBar: AppBar(
          title: Container(
              height: GenericVars.scSize.height * 0.1,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.3, color: Colors.grey))),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: textEditingController,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 105, 102, 102)),
                    /*   onChanged: (value) {
                      textEditingController.clear();
                      textEditingController.text = value;
                    }, */
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Search...",
                        prefixIcon: IconButton(
                            onPressed: () {
                              didShowList = true;
                              // Navigator.of(context).pop();
                              // Focus.of(context).unfocus();
                              textEditingController.text =
                                  textEditingController.text.trim();
                              GenericVars.currentSearchString =
                                  textEditingController.text;
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              setState(() {});
                              /* Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => SearchToNewPage(
                                      textEditingController.text))); */
                            },
                            icon: Icon(Icons.search)),
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ))),
          /*   Text(
            widget.searchString.toLowerCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ), */
        ),
        body: (didShowList)
            ? FutureBuilder(
                future: photoController.loadSearchAllItems(
                    GenericVars.currentSearchString.toLowerCase()),
                builder: (ctx, photosnapShot) =>
                    (photosnapShot.connectionState == ConnectionState.waiting)
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: CategoryWidget(
                                                photoModels:
                                                    photoController.SearchItems,
                                                postModels:
                                                    postController.Items,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        )));
                            }))
            : Container());
  }
}
