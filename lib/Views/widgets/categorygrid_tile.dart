import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CategoryGridTile extends StatelessWidget {
  final String imagePath, newsTitle, newsDate, newsDescription, categoryName;
  final double cellHeight;
  final bool didDescriptionShow;
  final double elevation;
  const CategoryGridTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDescription,
      required this.newsDate,
      required this.categoryName,
      required this.cellHeight,
      required this.didDescriptionShow,
      required this.elevation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailedPostView(
                  categoryName: categoryName,
                  url: imagePath,
                  title: newsTitle,
                  description: newsDescription,
                )));
      },
      child: Card(
        elevation: elevation,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: GenericVars.scSize.height * cellHeight,
          width: double.infinity,

          //Category News Row Started
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Category News Image
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.low,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Image.asset(
                                      "assets/images/dhakaprokash_logo.png",
                                    ),
                                  ),
                      ),
                    )),
              ),
              //Category News Description s+ Date
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      Text(
                        "${StringLimiter().limitString(newsTitle, 25)}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      //description
                      if (didDescriptionShow)
                        Text(StringLimiter().limitString(newsTitle, 80)),
                      Text(
                        DateFormat.yMEd().format(DateTime.now()),
                        style: Theme.of(context).textTheme.labelSmall,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
