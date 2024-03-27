import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryGridTile extends StatefulWidget {
  final String imagePath,
      newsTitle,
      newsDescription,
      categoryName,
      imageCaption;
  final DateTime dateTime;
  final double cellHeight;
  final bool didDescriptionShow;
  final double elevation;
  final List<String> tags;

  const CategoryGridTile(
      {super.key,
      required this.imagePath,
      required this.newsTitle,
      required this.newsDescription,
      required this.dateTime,
      required this.categoryName,
      required this.cellHeight,
      required this.didDescriptionShow,
      required this.elevation,
      required this.imageCaption,
      required this.tags});

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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailedPostView(
                  tags: widget.tags,
                  imageCaption: widget.imageCaption,
                  date: DateFormatter().defaultFormatWithTime(widget.dateTime),
                  categoryName: widget.categoryName,
                  url: widget.imagePath,
                  title: widget.newsTitle,
                  description: widget.newsDescription,
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
                        widget.imagePath,
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
                        //newsTitle.substring(0, 30),
                        "${StringLimiter().limitString(widget.newsTitle, 30)}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      //description
                      if (widget.didDescriptionShow)
                        HtmlWidget(
                          removeHtmlContent(
                              widget.newsDescription.substring(0, 160),
                              "<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\">"),
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 16),
                        ),

                      Text(
                        DateFormatter().defaultFormat(widget.dateTime),
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
