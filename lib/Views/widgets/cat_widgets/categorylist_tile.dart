import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';

import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryListTile extends StatelessWidget {
  final int id;
  final String imagePath, newsTitle;

  final DateTime dateTime;
  final double itemHeight;
  final DateTime? updateDateTime;

  const CategoryListTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.itemHeight,
      required this.dateTime,
      required this.id,
      this.updateDateTime});

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Provider.of<VideoProvider>(context, listen: false).pauseVideoState();

        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailedPostView(
                  id: id,
                )));
      },
      child: Container(
        height: scSize.height * itemHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
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
                padding: const EdgeInsets.only(right: 5, top: 2),
                child: Text(
                  //newsTitle,
                  newsTitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  // StringLimiter().limitString(newsTitle, 50),
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),

                /*  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //newsTitle,
                      newsTitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      // StringLimiter().limitString(newsTitle, 50),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.left,
                    ),
                     Row(
                      children: [
                        const Icon(
                          Icons.alarm,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "প্রকাশঃ ${DateFormatter().defaultFormat(dateTime)}",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    if (updateDateTime != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.alarm,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "আপডেটঃ ${DateFormatter().defaultFormat(updateDateTime!)}",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      )
                  ],
                ), */
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
                                ApiConstant
                                    .imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                              ),
                            ),
                  errorBuilder: (context, error, stackTrace) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(child: CircularProgressIndicator()),
                    // Image.asset(
                    //   ApiConstant.imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                    // ),
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
