import 'package:dummy_app/Models/dhaka_prokash_cat_model.dart';
import 'package:dummy_app/Utils/Controllers/all_controllers.dart';

import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/dummy_tags.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

class CategoryGridWidgetTotal extends StatefulWidget {
  final String categoryName;
  final DhakaprokashCatModel dhakaprokashModels;
  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  final bool? isReplace;
  final Color? barIconColor, barTextColor;

  const CategoryGridWidgetTotal(
      {super.key,
      required this.dhakaprokashModels,
      required this.categoryName,
      required this.itemCount,
      required this.didAxisHorizontal,
      required this.crossAxisCount,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.isReplace,
      this.itemHeight,
      this.barIconColor,
      this.barTextColor});

  @override
  State<CategoryGridWidgetTotal> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidgetTotal> {
  late ScrollController scController;
  double cellHeight = 0.15;
  double mainAxisSpacing = 5;
  @override
  void initState() {
    scController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    scController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tags = DummyTags().categoryTags[widget.categoryName];
    GridView gridWidget() {
      return GridView.builder(
          controller: scController,
          itemCount: widget.itemCount,
          physics: (widget.isScroll)
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
          ),
          scrollDirection:
              (widget.didAxisHorizontal) ? Axis.horizontal : Axis.vertical,
          itemBuilder: (ctx, index) => CategoryGridTile(
                isReplace: widget.isReplace,
                id: widget.dhakaprokashModels.contents[index].contentId ?? -1,

                isScroll: widget.isScroll,
                // widget.dhakaprokashModels[index].imgbgCaption ?? "",

                imagePath:
                    "https://admin.dhakaprokash24.com/media/content/images/${widget.dhakaprokashModels.contents[index].imgBgPath.toString()}",
                newsTitle:
                    widget.dhakaprokashModels.contents[index].contentHeading!,
                newsDescription: Bidi.stripHtmlIfNeeded(
                    widget.dhakaprokashModels.contents[index].contentDetails!),
                cellHeight: widget.itemHeight ?? cellHeight,
                didDescriptionShow: widget.didDescriptionShow,
                elevation: widget.elevation,
                /*postModels[index].title, */
                dateTime: widget.dhakaprokashModels.contents[index].createdAt ??
                    DateTime.now(),
              ));
    }

    return Consumer(builder: (ctx, ref, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //part 1//categoryname + More Button section

          GestureDetector(
            onTap: () {
              ref.watch(videoController).pauseVideoState();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CategoryView(
                        categoryName: widget.categoryName,
                        catSlug: widget.dhakaprokashModels.contents[0].catSlug,
                      )));
            },
            child: Container(
              height: GenericVars.scSize.height * 0.06,
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          width: 0.3,
                          color: Color.fromARGB(255, 151, 144, 144)))),
              child: Row(
                children: [
                  Icon(
                    Icons.square,
                    color: widget.barIconColor ??
                        AppColors.defaultCategoryBarIconColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        color:
                            widget.barIconColor ?? AppColors.categoryNameColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: widget.barIconColor ??
                        AppColors.defaultCategoryBarIconColor,
                  )
                ],
              ),
            ),
          ),

          //part 3//Category News Lists
          SizedBox(
            height: (widget.didAxisHorizontal)
                ? GenericVars.scSize.height * (widget.itemHeight ?? cellHeight)
                : GenericVars.scSize.height *
                    (widget.itemHeight ?? cellHeight) *
                    (widget.itemCount / widget.crossAxisCount).ceil(),
            child: widget.isScroll
                ? RawScrollbar(
                    thumbColor: Colors.blueAccent,
                    thickness: 5,
                    trackVisibility: true,
                    // radius: Radius.circular(10),
                    controller: scController,
                    thumbVisibility: true,
                    child: gridWidget())
                : gridWidget(),
          )
        ],
      );
    });
  }
}
