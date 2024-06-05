import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavListTile extends ConsumerWidget {
  final int id;
  final String imagePath, newsTitle, newsDescription, categoryName;

  final DateTime dateTime;
  final double itemHeight;
  final List<String> tags;
  final String? imageCaption;
  const FavListTile(
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
  Widget build(BuildContext context, WidgetRef ref) {
    Size scSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        ref.watch(videoController).pauseVideoState();

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
        ),
//Category News Row Started
        child: Row(
          children: [
//Category News Descriptions + Date
            Expanded(
              //flex: 5,
              child: Container(
                padding: const EdgeInsets.only(right: 5, top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //newsTitle,
                      StringLimiter().limitString(newsTitle, 50),
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      DateFormatter().defaultFormat(dateTime),
                      style: Theme.of(context).textTheme.labelSmall,
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
                  fit: BoxFit.fitHeight,
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
                    child: const Center(child: CircularProgressIndicator()),
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
