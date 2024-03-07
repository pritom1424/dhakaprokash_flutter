import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentCategoryHomeListTile extends StatelessWidget {
  final String imagePath, newsTitle, newsDate, newsCategory;
  const RecentCategoryHomeListTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDate,
      required this.newsCategory});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomePage())),
      child: Container(
        decoration: BoxDecoration(
          border:
              const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: scSize.height * 0.2,
        width: double.infinity,
//Recent Category News Row Started
        child: Row(
          children: [
//Recent Category News Row Started
            Expanded(
//Recent Category News Image
              child: Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              )),
            ),
//Category News Descriptions+ Date+ category type
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${StringLimiter().limitString(newsTitle, 50)}..."),
                    Row(children: [
                      Text(
                        newsDate,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Spacer(),
                      Text(newsCategory)
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
