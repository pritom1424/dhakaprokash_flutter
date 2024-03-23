import 'package:dummy_app/Utils/dummy_tags.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/deskview_bar.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/followpost_bar.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/posttag_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MainHeadPostTile extends StatefulWidget {
  final String url, title, categoryname, description, date;
  final bool isBookmark;
  const MainHeadPostTile({
    super.key,
    required this.url,
    required this.title,
    required this.categoryname,
    required this.isBookmark,
    required this.description,
    required this.date,
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
    currentBookmark = widget.isBookmark;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tags = DummyTags().categoryTags[widget.categoryname] ?? [];
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          CategoryView(categoryName: widget.categoryname)));
                },
                child: Text(
                  widget.categoryname,
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
              widget.title,
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
              padding: EdgeInsets.symmetric(vertical: 10),
              child: DeskViewBar(
                date: widget.date,
              )),
//follow bar
          Container(
              height: GenericVars.scSize.height * 0.05,
              child: Row(children: [
                const FollowPostBar(iconRadius: 12),
                Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        currentBookmark = !currentBookmark;
                        (currentBookmark)
                            ? GenericVars.favoritesList.add(CategoryListTile(
                                imagePath: widget.url,
                                newsTitle: widget.title,
                                newsDescription: widget.description,
                                newsDate: widget.date,
                                categoryName: widget.categoryname,
                                itemHeight: 0.17))
                            : GenericVars.favoritesList.removeWhere(
                                (element) => element.imagePath == widget.url);
                      });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text((currentBookmark)
                              ? "News added to the favorites"
                              : "News removed from the favorites")));
                    },
                    icon: (currentBookmark)
                        ? Icon(Icons.bookmark_add)
                        : Icon(Icons.bookmark_add_outlined))
              ])),
//News Post Image
          Container(
            // height: GenericVars.scSize.height * 0.3,
            padding: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.low,
                  ),
                ),
                Text(
                  "subtitle| pic: collected",
                  style: TextStyle(
                      color: Color.fromARGB(255, 128, 125, 125), fontSize: 15),
                ),
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
