import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/widgets/categorygrid_tile.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CategoryGridWidget extends StatefulWidget {
  final String categoryName;
  final List<PhotoModel> photoModels;

  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double cellHeight;
  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  const CategoryGridWidget(
      {super.key,
      required this.photoModels,
      required this.categoryName,
      required this.itemCount,
      required this.didAxisHorizontal,
      required this.crossAxisCount,
      required this.mainAxisSpacing,
      required this.cellHeight,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation});

  @override
  State<CategoryGridWidget> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidget> {
  late ScrollController scController;
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
            mainAxisSpacing: widget.mainAxisSpacing,
          ),
          scrollDirection:
              (widget.didAxisHorizontal) ? Axis.horizontal : Axis.vertical,
          itemBuilder: (ctx, index) => CategoryGridTile(
              categoryName: widget.categoryName,
              imagePath: widget.photoModels[index].url,
              newsTitle: widget.photoModels[index].title,
              newsDescription: widget.photoModels[index].description,
              cellHeight: widget.cellHeight,
              didDescriptionShow: widget.didDescriptionShow,
              elevation: widget.elevation,
              /*postModels[index].title, */
              newsDate: DateFormat.yMEd().format(DateTime.now())));
    }

    return Container(
      //category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //part 1//categoryname + More Button section

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      CategoryView(categoryName: widget.categoryName)));
            },
            child: Container(
              height: GenericVars.scSize.height * 0.07,
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
                ? GenericVars.scSize.height * widget.cellHeight
                : GenericVars.scSize.height *
                    widget.cellHeight *
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
