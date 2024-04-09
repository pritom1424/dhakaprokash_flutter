import 'package:dummy_app/Models/dhaka_prokash_vid_total.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/CategoryWiseVideoListWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategryWiseVideo extends StatelessWidget {
  final CategoryVideo categoryVideo;
  final int itemCount;
  final bool isHeadSectionShow;
  final bool didDescriptionShow;
  final bool isScroll;
  final double elevation;
  final double? itemHeight;
  const CategryWiseVideo(
      {super.key,
      required this.categoryVideo,
      required this.itemCount,
      required this.isHeadSectionShow,
      required this.didDescriptionShow,
      required this.isScroll,
      required this.elevation,
      this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarDefault(),
      body: SingleChildScrollView(
        child: CategoryWiseVideoListWidget(
            itemCount: itemCount,
            categoryVideo: categoryVideo,
            isHeadSectionShow: isHeadSectionShow,
            didDescriptionShow: didDescriptionShow,
            isScroll: isScroll,
            elevation: elevation),
      ),
    );
  }
}
