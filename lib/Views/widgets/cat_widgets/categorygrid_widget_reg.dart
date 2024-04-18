import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';

import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/dummy_tags.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_tile.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryGridWidgetRegular extends StatefulWidget {
  final String categoryName;
  final List<DhakaProkashRegularModel> dhakaprokashModels;
  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  final bool? isReplace;
  final Color? barIconColor, barTextColor;
  final double? ratio;
  final int? maxLine;

  const CategoryGridWidgetRegular(
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
      this.barTextColor,
      this.maxLine,
      this.ratio});

  @override
  State<CategoryGridWidgetRegular> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidgetRegular> {
  late ScrollController scController;
  double cellHeight = 0.15;
  double mainAxisSpacing = 5;
  @override
  void initState() {
    scController = ScrollController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    scController.dispose();
    // TODO: implement dispose
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
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: widget.ratio ?? 1),
          scrollDirection:
              (widget.didAxisHorizontal) ? Axis.horizontal : Axis.vertical,
          itemBuilder: (ctx, index) => CategoryGridTile(
                maxLine: widget.maxLine,
                isReplace: widget.isReplace,
                id: widget.dhakaprokashModels[index].contentId ?? -1,
                isScroll: widget.isScroll,
                imagePath:
                    "https://admin.dhakaprokash24.com/media/content/images/${widget.dhakaprokashModels[index].imgBgPath.toString()}",
                newsTitle: widget.dhakaprokashModels[index].contentHeading!,
                newsDescription: Bidi.stripHtmlIfNeeded(
                    widget.dhakaprokashModels[index].contentDetails!),
                cellHeight: widget.itemHeight ?? cellHeight,
                didDescriptionShow: widget.didDescriptionShow,
                elevation: widget.elevation,
                /*postModels[index].title, */
                dateTime: widget.dhakaprokashModels[index].createdAt ??
                    DateTime.now(),
              ));
    }

    return Container(
      //category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //part 1//categoryname + More Button section

          GestureDetector(
            onTap: () {
              Provider.of<VideoProvider>(context, listen: false)
                  .pauseVideoState();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CategoryView(
                        categoryName: widget.categoryName,
                        catSlug: widget.dhakaprokashModels[0].catSlug,
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
                  SizedBox(
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
          Container(
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
                    //  radius: Radius.circular(10),
                    controller: scController,
                    thumbVisibility: true,
                    child: gridWidget())
                : gridWidget(),
          )
        ],
      ),
    );
  }
}
