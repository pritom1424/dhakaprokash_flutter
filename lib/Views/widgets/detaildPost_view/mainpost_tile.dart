import 'package:dummy_app/Utils/dummy_tags.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/deskview_bar.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/followpost_bar.dart';
import 'package:dummy_app/Views/widgets/detaildPost_view/posttag_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPostTile extends StatelessWidget {
  final String url, title, boldDescription, description, categoryname;
  const MainPostTile({
    super.key,
    required this.url,
    required this.title,
    required this.boldDescription,
    required this.description,
    required this.categoryname,
  });

  @override
  Widget build(BuildContext context) {
    List<String> tags = DummyTags().categoryTags[categoryname] ?? [];
    return ListView(physics: NeverScrollableScrollPhysics(), children: [
      //category name

      Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.centerLeft,
          //Tag Button
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CategoryView(categoryName: categoryname)));
            },
            child: Text(
              categoryname,
              style: const TextStyle(
                  color: Color.fromARGB(255, 24, 112, 184),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          )),
//title
      Container(
        height: GenericVars.scSize.height * 0.12,
        padding: EdgeInsets.only(top: 2, bottom: 5),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.start,
        ),
      ),
//desk view
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 10), child: DeskViewBar()),
//follow bar
      Container(
          height: GenericVars.scSize.height * 0.05,
          child: const FollowPostBar(iconRadius: 12)),
//News Post Image
      Container(
        height: GenericVars.scSize.height * 0.4,
        padding: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.low,
                )),
            Text(
              "subtitle| pic: collected",
              style: TextStyle(
                  color: Color.fromARGB(255, 128, 125, 125), fontSize: 15),
            ),
          ],
        ),
      ),
      //Main News Post
      Text(description + description + description),
      Container(
        padding: const EdgeInsets.only(
            top: 10), //symmetric(horizontal: 10, vertical: 5),
        height: (tags.isEmpty) ? 0 : GenericVars.scSize.height * 0.2,
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 0.4, color: Colors.grey))),
        child: PostTagTile(
          tagList: tags,
        ),
      ),
      SizedBox(
        height: GenericVars.scSize.height * 0.05,
        child: SizedBox.expand(
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Comment"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
          ),
        ),
      ),
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
