import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListTile extends StatelessWidget {
  final int id;
  final String imagePath, newsTitle, newsDescription, categoryName;

  final String? imageCaption;
  final DateTime dateTime;
  final double itemHeight;
  final List<String> tags;
  const CategoryListTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDescription,
      required this.categoryName,
      required this.itemHeight,
      required this.dateTime,
      required this.imageCaption,
      required this.tags,
      required this.id});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Provider.of<VideoProvider>(context, listen: false).pauseVideoState();
        print(
            "Video Pause: ${Provider.of<VideoProvider>(context, listen: false).IsVideoPause}");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailedPostView(
                  id: id,
                  tags: tags,
                  imageCaption: imageCaption,
                  dateTime: dateTime,
                  categoryName: categoryName,
                  url: imagePath,
                  title: newsTitle,
                  description: newsDescription,
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
        child: Row(
          children: [
//Category News Descriptions + Date
            Expanded(
              //flex: 5,
              child: Container(
                padding: EdgeInsets.only(right: 5, top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //newsTitle,
                      newsTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      // StringLimiter().limitString(newsTitle, 50),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.left,
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
                  ],
                ),
              ),
            ),
//Category News Image
            Expanded(
              //  flex: 4,
              child:
                  // padding: EdgeInsets.all(0),
                  ClipRRect(
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  loadingBuilder: (context, child, loadingProgress) =>
                      (loadingProgress == null)
                          ? child
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.asset(
                                "assets/images/dhakaprokash_logo.png",
                              ),
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
