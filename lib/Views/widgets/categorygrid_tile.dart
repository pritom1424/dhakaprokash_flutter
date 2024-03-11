import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CategoryGridTile extends StatelessWidget {
  final String imagePath, newsTitle, newsDate, newsDescription, categoryName;
  const CategoryGridTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDescription,
      required this.newsDate,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
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
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Container(
          height: scSize.height * 0.5,
          width: double.infinity,

          //Category News Row Started
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Category News Image
              Expanded(
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
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
                    )),
              ),
              //Category News Description s+ Date
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringLimiter().limitString(newsTitle, 50),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
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
