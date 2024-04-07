import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';

import 'package:flutter/material.dart';

class CategoryAvatarListTile extends StatelessWidget {
  final String imagePath, newsTitle, newsDescription, categoryName, name;
  final double itemHeight;
  final DateTime dateTime;
  final int id;

  const CategoryAvatarListTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDescription,
      required this.dateTime,
      required this.categoryName,
      required this.itemHeight,
      required this.name,
      required this.id});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailedPostView(
                  id: id,
                )));
      },
      child: Container(
        height: scSize.height * itemHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          border: const Border(
              bottom: BorderSide(
                  width: 0.3, color: Color.fromARGB(255, 136, 135, 135))),
          /* boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ], */
        ),
//Category News Row Started
        child: Padding(
          padding: EdgeInsets.only(
            top: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Category News Image
              Expanded(
                flex: 3,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(imagePath),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              //Category News Descriptions + Date
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringLimiter().limitString(newsTitle, 50),
                        style: Theme.of(context).textTheme.headlineMedium,
                        //  textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Text(
                          '$name| ',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateFormatter().defaultFormat(dateTime),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        )
                      ])
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
