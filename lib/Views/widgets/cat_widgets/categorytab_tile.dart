import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTabTile extends StatelessWidget {
  final int id;
  final String? imageCaption;
  final DateTime? dateTime;
  final String rankString;
  final String categoryName;
  final String imagePath;
  final String newsDescription;
  final String title;
  final List<String>? tags;
  const CategoryTabTile(
      {super.key,
      required this.rankString,
      required this.title,
      required this.id,
      this.imageCaption,
      this.dateTime,
      required this.categoryName,
      required this.imagePath,
      required this.newsDescription,
      this.tags});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GenericVars.scSize.height * 0.09,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.black26))),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => DetailedPostView(
                    id: id,
                    tags: tags ?? [],
                    imageCaption: imageCaption,
                    dateTime: dateTime ?? DateTime.now(),
                    categoryName: categoryName,
                    url: imagePath,
                    title: title,
                    description: newsDescription,
                  )));
        },
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black12,
          child: Text(
            rankString,
            style: GoogleFonts.tiroBangla(
              fontWeight: FontWeight.normal,
              // fontFamily: GenericVars.currenFontFamily,
              color: Colors.black38,
              fontSize: 25,
            ),
          ),
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.tiroBangla(
            fontWeight: FontWeight.bold,
            // fontFamily: GenericVars.currenFontFamily,
            // color: kColorScheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
