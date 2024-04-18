import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_photo_model.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_photo_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CategoryPhotoGridWidget extends StatefulWidget {
  final List<DhakaProkashPhotoModel> dhakaprokashModels;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  final Color? barIconColor, barTextColor;
  final int totalPhotoItems;
  final ScrollController? scrollController;
  const CategoryPhotoGridWidget(
      {super.key,
      required this.dhakaprokashModels,
      required this.didAxisHorizontal,
      required this.crossAxisCount,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.itemHeight,
      this.barIconColor,
      this.barTextColor,
      this.scrollController,
      required this.totalPhotoItems});

  @override
  State<CategoryPhotoGridWidget> createState() =>
      _CategoryPhotoGridWidgetState();
}

class _CategoryPhotoGridWidgetState extends State<CategoryPhotoGridWidget> {
  late ScrollController scController;
  int itemCount = 4;
  int addMore = 4;
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

  void addMorePhotos() {
    setState(() {
      if (widget.totalPhotoItems == itemCount + addMore)
        itemCount = widget.totalPhotoItems;
      else if (widget.totalPhotoItems < itemCount + addMore &&
          widget.totalPhotoItems > itemCount)
        itemCount = widget.totalPhotoItems;
      else if (widget.totalPhotoItems > itemCount) itemCount += addMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomepageController homecontroller =
        Provider.of<HomepageController>(context, listen: true);

    double cellHeight = 0.3;
    double mainAxisSpacing = 10;
    return Column(
      children: [
        Container(
          height: GenericVars.scSize.height * 0.07,
          width: double.infinity,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
                      width: 0.3, color: Color.fromARGB(255, 151, 144, 144)))),
          child: Row(
            children: [
              Icon(
                Icons.square,
                color: (widget.barIconColor) ?? AppColors.categoryNameColor,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ফটো গ্যালারি",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    color: (widget.barTextColor) ?? Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_right,
                color: (widget.barIconColor) ?? AppColors.categoryNameColor,
              )
            ],
          ),
        ),
        Container(
          height: (widget.didAxisHorizontal)
              ? GenericVars.scSize.height * (widget.itemHeight ?? cellHeight)
              : GenericVars.scSize.height *
                  (widget.itemHeight ?? cellHeight) *
                  (itemCount / widget.crossAxisCount).ceil(),
          child: Scrollbar(
            controller: scController,
            thickness: 5,
            child: GridView.builder(
                controller: scController,
                itemCount: itemCount,
                physics: (widget.isScroll)
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  mainAxisSpacing: mainAxisSpacing,
                ),
                scrollDirection: (widget.didAxisHorizontal)
                    ? Axis.horizontal
                    : Axis.vertical,
                itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => CategoryPhotoView(
                                    albumId: widget.dhakaprokashModels[index]
                                            .albumId ??
                                        -1)));
                      },
                      child: Card(
                        elevation: widget.elevation,
                        child: Container(
                          height: GenericVars.scSize.height * cellHeight,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            "https://admin.dhakaprokash24.com/media/photoAlbum/${widget.dhakaprokashModels[index].photo}",
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.low,
                                            loadingBuilder: (context, child,
                                                    loadingProgress) =>
                                                (loadingProgress == null)
                                                    ? child
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 40),
                                                        child: Image.asset(
                                                          ApiConstant
                                                              .imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                                        ),
                                                      ),
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child:
                                                  CircularProgressIndicator(),
                                              // Image.asset(
                                              //   ApiConstant.imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                              // ),
                                            ),
                                          )),
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          child: Text(
                                            widget.dhakaprokashModels[index]
                                                    .albumName ??
                                                "এলবাম",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white60,
                                      child: Icon(Icons.photo_rounded)))
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ),
        Visibility(
          visible: (itemCount < widget.totalPhotoItems) ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () {
                addMorePhotos();
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 0.5, color: AppColors.logoColorDeep)),
                child: Text(
                  "আরও",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: GenericVars.currenFontFamily,
                      fontWeight: FontWeight.bold,
                      color: AppColors.logoColorDeep),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
