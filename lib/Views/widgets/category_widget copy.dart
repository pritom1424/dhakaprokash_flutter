import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_data.dart';
import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/generic_methods/StringLimiter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryWidgetCopy extends StatelessWidget {
  final String categoryName;
  /*  final List<PhotoModel> photoModels;
  final List<PostModel> postModels; */
  final List<DhakaProkash> dhakaprokashModels;

  final bool didMoreButtonShow;
  final bool didHeadSectionShow;
  final int listItemLength;
  final bool didFloat;

  const CategoryWidgetCopy({
    super.key,
    required this.dhakaprokashModels,
    required this.categoryName,
    required this.didMoreButtonShow,
    required this.didHeadSectionShow,
    required this.listItemLength,
    required this.didFloat,
  });

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 0.17;

    return Container(
      //category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//part 1//categoryname + More Button section

          if (didMoreButtonShow)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) =>
                        CategoryView(categoryName: categoryName)));
              },
              child: Container(
                  height: GenericVars.scSize.height * 0.07,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  /*  decoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              width: 0.3,
                              color: Color.fromARGB(255, 151, 144, 144)))), */
                  child: Row(
                    children: [
                      Text(
                        categoryName,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.red,
                      ),
                    ],
                  )),
            ),

//part 2//HeadImagePreview + title+description
          if (didHeadSectionShow)
            GestureDetector(
              onTap: () {
                Provider.of<VideoProvider>(context, listen: false)
                    .pauseVideoState();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => DetailedPostView(
                          date: DateFormat.yMEd()
                              .format(dhakaprokashModels[0].createdAt!),
                          categoryName: categoryName,
                          url:
                              "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[0].imgBgPath.toString()}",
                          title: dhakaprokashModels[0].contentHeading!,
                          description: dhakaprokashModels[0].contentDetails!,
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: (!didFloat)
                        ? Border(
                            bottom: BorderSide(
                                width: 0.3,
                                color: Color.fromARGB(255, 136, 135, 135)))
                        : Border(
                            bottom: BorderSide(
                                width: 0, color: Colors.transparent))),
                width: double.infinity,
                height: (didFloat)
                    ? GenericVars.scSize.height * 0.45
                    : GenericVars.scSize.height * 0.50,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: (didFloat)
                    ? Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[0].imgBgPath.toString()}",
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.low,
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
                                      (loadingProgress == null)
                                          ? child
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: Image.asset(
                                                "assets/images/dhakaprokash_logo.png",
                                              ),
                                            ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: GenericVars.scSize.height * 0.15,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 129, 127, 127),
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(categoryName),
                                    Text(
                                      dhakaprokashModels[0].contentHeading!,
                                      // "${StringLimiter().limitString(dhakaprokashModels[0].contentHeading!, 25)} . . .",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      DateFormat.yMEd().format(DateTime.now()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[0].imgBgPath.toString()}",
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.low,
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
                                      (loadingProgress == null)
                                          ? child
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: Image.asset(
                                                "assets/images/dhakaprokash_logo.png",
                                              ),
                                            ),
                                )),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    dhakaprokashModels[0].contentHeading!,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  HtmlWidget(
                                    StringLimiter().limitString(
                                        dhakaprokashModels[0].contentDetails!,
                                        120),
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMEd().format(
                                        dhakaprokashModels[0].createdAt!),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),

//part 3//Category News Lists
          Container(
            height:
                GenericVars.scSize.height * itemHeight * (listItemLength - 1),
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: listItemLength - 1,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return CategoryListTile(
                      categoryName: categoryName,
                      imagePath:
                          "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[index + 1].imgBgPath.toString()}",
                      newsTitle: dhakaprokashModels[index + 1].contentHeading!,
                      newsDescription:
                          dhakaprokashModels[index + 1].contentDetails!,
                      itemHeight: itemHeight,
                      /*postModels[index].title, */
                      newsDate: DateFormat.yMEd()
                          .format(dhakaprokashModels[index + 1].createdAt!));
                }),
          )
        ],
      ),
    );
  }
}
