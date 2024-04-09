import 'package:dummy_app/Models/dhaka_prokash_photo_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_vid_total.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/newspage_view/detailedvideopost_view.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CategoryWiseVideoListWidget extends StatefulWidget {
  //final List<DhakaProkashPhotoModel> dhakaprokashModels;
  final CategoryVideo categoryVideo;
  final int itemCount;
  final bool isHeadSectionShow;
  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  const CategoryWiseVideoListWidget(
      {super.key,
      required this.itemCount,
      required this.categoryVideo,
      // required this.dhakaprokashModels,
      required this.isHeadSectionShow,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.itemHeight});

  @override
  State<CategoryWiseVideoListWidget> createState() =>
      _CategoryPhotoGridWidgetState();
}

class _CategoryPhotoGridWidgetState extends State<CategoryWiseVideoListWidget> {
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
    double cellHeight = 0.25;
    double listPadding = 10;
    return Column(
      children: [
        if (widget.isHeadSectionShow)
          Container(
            height: GenericVars.scSize.height * 0.07,
            padding: EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.3,
                        color: Color.fromARGB(255, 151, 144, 144)))),
            child: Row(
              children: [
                const Icon(
                  Icons.square,
                  color: AppColors.categoryNameColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.categoryVideo.category.nameBn,
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                      color: AppColors.categoryNameColor,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_right,
                  color: AppColors.categoryNameColor,
                )
              ],
            ),
          ),
        Container(
          height: GenericVars.scSize.height *
                  (widget.itemHeight ?? cellHeight) *
                  widget.itemCount +
              (listPadding * widget.itemCount),
          child: Column(
              children: List.generate(
                  widget.itemCount,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => DetailedVideoPostView(
                                  id: widget.categoryVideo.videos[index].id,
                                ),
                              ));
                        },
                        child: Card(
                          elevation: widget.elevation,
                          margin: EdgeInsets.all(5),
                          child: Container(
                            //    margin: EdgeInsets.only(bottom: listPadding),
                            padding: EdgeInsets.only(bottom: listPadding),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 5, color: Colors.grey))),
                            // padding: EdgeInsets.only(bottom: listPadding),

                            height: GenericVars.scSize.height *
                                (widget.itemHeight ?? cellHeight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              "https://admin.dhakaprokash24.com/media/videoImages/${widget.categoryVideo.videos[index].imgBgPath}",
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
                                                                  horizontal:
                                                                      40,
                                                                  vertical: 40),
                                                          child: Image.asset(
                                                            alignment: Alignment
                                                                .center,
                                                            "assets/images/dhakaprokash_logo.png",
                                                          ),
                                                        ),
                                            )),
                                      ),
                                      const Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  size: 40,
                                                ))),
                                      )
                                    ],
                                  ),
                                ),

                                ///here
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    widget.categoryVideo.videos[index].title,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      // overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      // fontFamily: GenericVars.currenFontFamily,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))),
        ),
      ],
    );
  }
}

/**ListView.builder(
              controller: scController,
              itemCount: widget.itemCount,
              physics: (widget.isScroll)
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              /*   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                mainAxisSpacing: mainAxisSpacing,
              ),
              scrollDirection: (widget.didAxisHorizontal)
                  ? Axis.horizontal
                  : Axis.vertical, */
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => DetailedVideoPostView(
                                categoryName: "Video",
                                videoUrl: GenericVars.getVideoData[index]
                                    ['url']!,
                                videoTitle: GenericVars
                                    .getVideoData[index + 1]['title']!),
                          ));
                    },
                    child: Card(
                      elevation: widget.elevation,
                      child: Container(
                        color: Colors.black,
                        height: GenericVars.scSize.height *
                            (widget.itemHeight ?? cellHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        child: Image.network(
                                          alignment: Alignment.center,
                                          "https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(GenericVars.getVideoData[index]['url']!)}/0.jpg",
                                          fit: BoxFit.fitWidth,
                                          filterQuality: FilterQuality.low,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              (loadingProgress == null)
                                                  ? child
                                                  : Container(
                                                      padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 40,
                                                              vertical: 40),
                                                      child: Image.asset(
                                                        alignment:
                                                            Alignment.center,
                                                        "assets/images/dhakaprokash_logo.png",
                                                      ),
                                                    ),
                                        )),
                                  ),
                                  const Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            child: Icon(Icons.play_arrow))),
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
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: GenericVars.currenFontFamily),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )) */