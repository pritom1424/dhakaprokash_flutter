import 'package:dummy_app/Models/dhaka_prokash_sp_model.dart';
import 'package:dummy_app/Utils/Controllers/all_controllers.dart';

import 'package:dummy_app/Utils/app_colors.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryGridWidgetSpecial extends StatefulWidget {
  final String categoryName;
  final List<DhakaProkashSpecialModel> dhakaprokashModels;
  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final bool? didHeadSectionShow;

  const CategoryGridWidgetSpecial({
    super.key,
    required this.dhakaprokashModels,
    required this.categoryName,
    required this.itemCount,
    required this.didAxisHorizontal,
    required this.crossAxisCount,
    required this.didDescriptionShow,
    required this.isScroll,
    required this.elevation,
    this.didHeadSectionShow,
  });

  @override
  State<CategoryGridWidgetSpecial> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidgetSpecial> {
  late ScrollController scController;
  double cellHeight = 0.23;
  double mainAxisSpacing = 2;
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
                id: widget.dhakaprokashModels[index].contentId ?? -1,
                isScroll: widget.isScroll,
                imagePath:
                    "https://admin.dhakaprokash24.com/media/content/images/${widget.dhakaprokashModels[index].imgBgPath.toString()}",
                newsTitle: widget.dhakaprokashModels[index].contentHeading!,
                newsDescription:
                    widget.dhakaprokashModels[index].contentDetails!,
                cellHeight: cellHeight,
                didDescriptionShow: widget.didDescriptionShow,
                elevation: widget.elevation,
                /*postModels[index].title, */
                dateTime: widget.dhakaprokashModels[index].createdAt ??
                    DateTime.now(),
              ));
    }

    return Consumer(builder: (ctx, ref, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //part 1//categoryname + More Button section

          if (widget.didHeadSectionShow == null ||
              widget.didHeadSectionShow == true)
            GestureDetector(
              onTap: () {
                ref.watch(videoController).pauseVideoState();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => CategoryView(
                          categoryName: widget.categoryName,
                          catSlug:
                              widget.dhakaprokashModels[0].category?.catSlug ??
                                  "",
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.square,
                      color: AppColors.categoryNameColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.categoryName,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                            color: AppColors.categoryNameColor,
                            fontWeight: FontWeight.bold)),
                    const Icon(
                      Icons.arrow_right,
                      color: AppColors.categoryNameColor,
                    )
                  ],
                ),
              ),
            ),

          //part 3//Category News Lists
          SizedBox(
            height: (widget.didAxisHorizontal)
                ? GenericVars.scSize.height * cellHeight
                : GenericVars.scSize.height *
                    cellHeight *
                    (widget.itemCount / widget.crossAxisCount).ceil(),
            child: widget.isScroll
                ? RawScrollbar(
                    thickness: 5,
                    thumbColor: Colors.blueAccent,
                    controller: scController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: gridWidget())
                : gridWidget(),
          )
        ],
      );
    });
  }
}
