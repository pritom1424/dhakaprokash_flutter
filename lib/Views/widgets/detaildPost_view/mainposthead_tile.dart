import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/favlist_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/deskview_bar.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/followpost_bar.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class MainHeadPostTile extends StatefulWidget {
  final String? url, title, categoryname, description, imageCaption;
  final DateTime dateTime;
  final String authorSlug;
  final String authorName;
  final List<String>? tags;
  final int id;
  final String postLink;
  const MainHeadPostTile({
    super.key,
    required this.url,
    required this.title,
    required this.categoryname,
    required this.description,
    required this.imageCaption,
    required this.tags,
    required this.dateTime,
    required this.id,
    required this.authorSlug,
    required this.authorName,
    required this.postLink,
  });

  @override
  State<MainHeadPostTile> createState() => _MainHeadPostTileState();
}

class _MainHeadPostTileState extends State<MainHeadPostTile> {
  late bool currentBookmark;
  String mailSchema = "mailto";
  String websiteSchema = "https";

  Future<void> launchLink(String schema, String link) async {
    final Uri launchUri = Uri(scheme: schema, path: link);
    //final Uri launchWebUri = Uri.parse(link);
    // final Uri currentURi = launchUri;
    if (schema.contains(websiteSchema)) {
      if (!await launchUrl(Uri.parse(link))) throw 'Could not launch $link';
    } else {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $launchUri';
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

/*   void refreshPosts() async {
    GenericVars.favoritesList = await DatabaseHelper().getPosts();
    setState(() {});
  } */

  @override
  Widget build(BuildContext context) {
    var bookmarkController =
        Provider.of<BookmarkController>(context, listen: false);
    currentBookmark =
        bookmarkController.FavList.any((element) => element.id == widget.id);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        /* physics: NeverScrollableScrollPhysics(),  */ children: [
          //category name

          Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              alignment: Alignment.centerLeft,
              //Tag Button
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => CategoryView(
                            categoryName: widget.categoryname ?? "category",
                            catSlug: GenericVars
                                .newspaperCategoriesLink[widget.categoryname],
                          )));
                },
                child: Text(
                  widget.categoryname ?? "category",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 24, 112, 184),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )),
//title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              widget.title ?? "title",
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.start,
            ),
          ),
          /*  Container(
        height: GenericVars.scSize.height * 0.12,
        padding: EdgeInsets.only(top: 2, bottom: 5),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.start,
        ),
      ), */
//desk view

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DeskViewBar(
              title: widget.authorName,
              slug: widget.authorSlug,
              dateTime: widget.dateTime,
            ),
          ),
//follow bar
          Container(
              height: GenericVars.scSize.height * 0.05,
              child: Row(children: [
                FollowPostBar(
                  iconRadius: 12,
                  link: widget.postLink,
                ),
                const Spacer(),
                Consumer<BookmarkController>(
                    builder: (context, bController, _) {
                  return IconButton(
                    onPressed: () async {
                      // setState(() {
                      currentBookmark = !currentBookmark;
                      if (currentBookmark) {
                        await bookmarkController.addToList(FavListTile(
                            id: widget.id,
                            tags: widget.tags ?? [],
                            imageCaption: widget.imageCaption ?? "",
                            imagePath: widget.url ?? "",
                            newsTitle: widget.title ?? "title",
                            newsDescription:
                                widget.description ?? "description",
                            dateTime: widget.dateTime,
                            categoryName: widget.categoryname ?? "category",
                            itemHeight: 0.17));
                      } else {
                        bookmarkController.removeFromList(widget.id);
                      }

                      /*     GenericVars.favoritesList.removeWhere(
                                (element) => element.imagePath == widget.url); */
                      // });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 500),
                          backgroundColor:
                              currentBookmark ? Colors.blue : Colors.red,
                          content: Text(
                            (currentBookmark)
                                ? "বার্তাটি বুকমার্ক করা হয়েছে!"
                                : "বার্তাটি বুকমার্ক থেকে মুছে দেয়া হয়েছে!",
                            textAlign: TextAlign.center,
                          )));
                    },
                    icon: (currentBookmark)
                        ? Icon(Icons.bookmark_add)
                        : Icon(Icons.bookmark_add_outlined),
                  );
                })
              ])),
//News Post Image
          Container(
            // height: GenericVars.scSize.height * 0.3,
            padding: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.url ?? "",
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.low,
                    loadingBuilder: (context, child, loadingProgress) =>
                        (loadingProgress == null)
                            ? child
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset(
                                  ApiConstant
                                      .imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                ),
                              ),
                  ),

                  /*    Image.network(
                    widget.url ?? "",
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.low,
                  ), */
                ),
                if (widget.imageCaption != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      widget.imageCaption!,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                Divider()
              ],
            ),
          ),
          //Main News Post

          /*  RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "$boldDescription\n\n",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        TextSpan(
            text: description,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black))
      ])) */
        ]);
  }
}
