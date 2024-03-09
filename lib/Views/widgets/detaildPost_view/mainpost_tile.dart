import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
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
    return ListView(children: [
      //category name
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
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
      Padding(
        padding: EdgeInsets.only(top: 2, bottom: 5),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.start,
        ),
      ),
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 10), child: DeskViewBar()),
      const FollowPostBar(iconRadius: 15),
      //News Post Image
      Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: GenericVars.scSize.height * 0.3,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              url,
              fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.low,
            )),
      ),
      //Main News Post
      RichText(
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
      ]))
    ]);
  }
}
