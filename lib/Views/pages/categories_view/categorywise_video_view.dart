import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Models/dhaka_prokash_vid_total.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/CategoryWiseVideoListWidget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategryWiseVideo extends StatefulWidget {
  //final CategoryVideo categoryVideo;
  //final int itemCount;

  final bool? isEnableAppbar;
  const CategryWiseVideo(
      {super.key,
      /*  required this.categoryVideo,
      required this.itemCount,
      required this.isHeadSectionShow,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.itemHeight, */
      this.isEnableAppbar});

  @override
  State<CategryWiseVideo> createState() => _CategryWiseVideoState();
}

class _CategryWiseVideoState extends State<CategryWiseVideo> {
  int itm = 20;
  int addMore = 10;
  bool isVisible = true;
  final bool isHeadSectionShow = false;
  final bool didDescriptionShow = false;
  final bool isScroll = false;
  final double elevation = 0;
  final double? itemHeight = null;

  void AddMore(int totalItem) {
    setState(() {
      if (totalItem == itm + addMore) {
        itm = totalItem;
      } else if (totalItem < itm + addMore && totalItem > itm) {
        isVisible = true;
      } else if (totalItem > itm) {
        itm += addMore;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    VideoProvider videoController =
        Provider.of<VideoProvider>(context, listen: false);
    return Scaffold(
      appBar: (widget.isEnableAppbar != null && widget.isEnableAppbar == true)
          ? AppbarDefault()
          : null,
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: videoController.getLatestAllVideos(itm),
              builder: (ctx, snapShot) => (snapShot.hasData)
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CategoryWiseVideoListWidget(
                              itemCount: snapShot.data!.videos.length,
                              dhakaProkashAllVideo: snapShot.data!,
                              isHeadSectionShow: isHeadSectionShow,
                              didDescriptionShow: didDescriptionShow,
                              isScroll: isScroll,
                              elevation: elevation),
                          Visibility(
                            visible: (snapShot.data!.videos.length >= itm &&
                                    itm < snapShot.data!.totalVideos)
                                ? true
                                : false,
                            child: GestureDetector(
                              onTap: () {
                                AddMore(snapShot.data!.totalVideos);
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.5,
                                        color: AppColors.logoColorDeep)),
                                child: const Text(
                                  "আরও",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.logoColorDeep),
                                ),
                              ),
                            ),
                          ),
                          HomePageFooter()
                        ],
                      ),
                    )
                  : Container(
                      height: GenericVars.scSize.height * 0.6,
                      child: LoaderWidget()))),
    );
  }
}
