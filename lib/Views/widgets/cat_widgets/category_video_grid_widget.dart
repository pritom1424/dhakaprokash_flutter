import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/pages/newspage_view/detailedvideopost_view.dart';

import 'package:flutter/material.dart';
import 'package:dummy_app/Utils/api_constants.dart';

import 'package:dummy_app/Views/pages/categories_view/categorywise_video_view.dart';

class CategoryVideoGridWidget extends StatefulWidget {
  //final List<DhakaProkashPhotoModel> dhakaprokashModels;
  final int itemCount;

  final bool didAxisHorizontal;
  final int crossAxisCount;

  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  final Color? barIconColor, barTextColor;
  final List<int> ids;
  final double? ratio;
  const CategoryVideoGridWidget(
      {super.key,
      required this.itemCount,
      // required this.dhakaprokashModels,
      required this.didAxisHorizontal,
      required this.crossAxisCount,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.itemHeight,
      this.barIconColor,
      this.barTextColor,
      required this.ids,
      this.ratio});

  @override
  State<CategoryVideoGridWidget> createState() =>
      _CategoryPhotoGridWidgetState();
}

class _CategoryPhotoGridWidgetState extends State<CategoryVideoGridWidget> {
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
    double cellHeight = 0.35;
    double mainAxisSpacing = 10;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => CategryWiseVideo(
                      isEnableAppbar: true,
                    )));
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
                  "ভিডিও গ্যালারি",
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                      color: widget.barTextColor ?? AppColors.categoryNameColor,
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
        Container(
          height: GenericVars.scSize.height * (widget.itemHeight ?? cellHeight),
          child: RawScrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            thumbColor: Colors.blueAccent,
            controller: scController,
            thickness: 5,
            child: GridView.builder(
                controller: scController,
                itemCount: widget.itemCount,
                physics: (widget.isScroll)
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: (widget.ratio != null) ? widget.ratio! : 1,
                ),
                scrollDirection: (widget.didAxisHorizontal)
                    ? Axis.horizontal
                    : Axis.vertical,
                itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => DetailedVideoPostView(
                                id: widget.ids[index],
                              ),
                            ));
                      },
                      child: Card(
                        elevation: widget.elevation,
                        child: Container(
                          color: Colors.white,
                          height: GenericVars.scSize.height *
                              (widget.itemHeight ?? cellHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            alignment: Alignment.center,
                                            "https://admin.dhakaprokash24.com/media/videoImages/${GenericVars.getVideoData[index]['img_bg_path']}",
                                            //"https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(GenericVars.getVideoData[index]['url']!)}/0.jpg",
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.low,
                                            loadingBuilder: (context, child,
                                                    loadingProgress) =>
                                                (loadingProgress == null)
                                                    ? child
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 0,
                                                                vertical: 8),
                                                        child: Image.asset(
                                                          alignment:
                                                              Alignment.center,
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
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              // Image.asset(
                                              //   ApiConstant.imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                              // ),
                                            ),
                                          )),
                                    ),
                                    const Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              child: Icon(
                                                Icons.play_arrow,
                                                size: 35,
                                              ))),
                                    )
                                  ],
                                ),
                              ),

                              ///here
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                child: Text(
                                  GenericVars.getVideoData[index]['title']!,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GenericVars.currenFontFamily),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}
