import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';

import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class CategoryGridTile extends StatefulWidget {
  final int id;
  final String imagePath, newsTitle, newsDescription;

  final DateTime dateTime;
  final double cellHeight;
  final bool didDescriptionShow;
  final double elevation;

  final bool isScroll;
  final bool? isReplace;
  final int? maxLine;

  const CategoryGridTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDescription,
      required this.dateTime,
      required this.cellHeight,
      required this.didDescriptionShow,
      required this.elevation,
      required this.id,
      this.isReplace,
      required this.isScroll,
      this.maxLine});

  @override
  State<CategoryGridTile> createState() => _CategoryGridTileState();
}

class _CategoryGridTileState extends State<CategoryGridTile> {
  @override
  Widget build(BuildContext context) {
    String removeHtmlContent(String htmlContent, String targetContent) {
      return htmlContent.replaceAllMapped(RegExp(targetContent), (match) => '');
    }

    return GestureDetector(
      onTap: () {
        Provider.of<VideoProvider>(context, listen: false).pauseVideoState();
        (widget.isReplace == null || widget.isReplace == false)
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => DetailedPostView(
                      id: widget.id,
                    )))
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => DetailedPostView(
                      id: widget.id,
                    )));
      },
      child: Card(
        elevation: widget.elevation,
        shadowColor: Colors.black45,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: GenericVars.scSize.height * widget.cellHeight,
          width: double.infinity,

          //Category News Row Started
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Category News Image
              Container(
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                      loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Image.asset(
                                    ApiConstant
                                        .imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                  ),
                                ),
                      errorBuilder: (context, error, stackTrace) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircularProgressIndicator(),
                        // Image.asset(
                        //   ApiConstant.imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                        // ),
                      ),
                    ),
                  )),
              Expanded(
                child: Text(
                  widget.newsTitle,
                  maxLines: widget.maxLine ?? 2,
                  overflow: TextOverflow.ellipsis,
                  // "${StringLimiter().limitString(widget.newsTitle, 30)}",
                  style: (widget.isScroll)
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.titleSmall,
                ),
              ),
              /*  Expanded(
                flex: 1,
                //  margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  widget.newsTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  // "${StringLimiter().limitString(widget.newsTitle, 30)}",
                  style: (widget.isScroll)
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.titleSmall,
                ),
              ), */
              //Category News Description s+ Date
              /*  Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title

                      Text(
                        widget.newsTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        // "${StringLimiter().limitString(widget.newsTitle, 30)}",
                        style: (widget.isScroll)
                            ? Theme.of(context).textTheme.titleMedium
                            : Theme.of(context).textTheme.titleSmall,
                      ),
                      //description
                      if (widget.didDescriptionShow)
                        Text(
                          Bidi.stripHtmlIfNeeded(widget.newsDescription).trim(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
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
                            "প্রকাশঃ ${DateFormatter().defaultFormat(widget.dateTime)}",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
