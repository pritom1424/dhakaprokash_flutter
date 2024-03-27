import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_sp_model.dart';
import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/widgets/categorygrid_tile.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryGridWidgetSpecial extends StatefulWidget {
  final String categoryName;
  final List<DhakaProkashSpecialModel> dhakaprokashModels;
  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;

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
  });

  @override
  State<CategoryGridWidgetSpecial> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidgetSpecial> {
  late ScrollController scController;
  double cellHeight = 0.23;
  double mainAxisSpacing = 10;
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
          ),
          scrollDirection:
              (widget.didAxisHorizontal) ? Axis.horizontal : Axis.vertical,
          itemBuilder: (ctx, index) => CategoryGridTile(
                tags: widget.dhakaprokashModels[index].tags ?? [],
                imageCaption:
                    widget.dhakaprokashModels[index].imgbgCaption ?? "",
                categoryName: widget.categoryName,
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
                        categoryLink: GenericVars
                            .newspaperCategoriesLink[widget.categoryName],
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
                  Text(
                    widget.categoryName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),

          //part 3//Category News Lists
          Container(
            height: (widget.didAxisHorizontal)
                ? GenericVars.scSize.height * cellHeight
                : GenericVars.scSize.height *
                    cellHeight *
                    (widget.itemCount / widget.crossAxisCount).ceil(),
            child: widget.isScroll
                ? Scrollbar(
                    thickness: 5,
                    radius: Radius.circular(10),
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
