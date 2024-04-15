import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_video_all_list_widget.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CategoryVideoView extends StatelessWidget {
  /*  final String categoryName;
  final String? categoryLink; */
  final bool? isEnableAppbar;
  const CategoryVideoView({
    this.isEnableAppbar,
    super.key,
    /*  required this.categoryName,
    required this.categoryLink, */
  });

  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Provider.of(context, listen: false);
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: false);
    return Scaffold(
        appBar: (isEnableAppbar != null && isEnableAppbar == true)
            ? AppbarDefault()
            : null,
        body: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: videoProvider.getAllVideos(),
                builder: (ctx, snap) => (snap.hasData)
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CategoryVideoAllListWidget(
                                isHeadSectionShow: true,
                                didDescriptionShow: false,
                                isScroll: false,
                                elevation: 0,
                                dhakaprokashVidModel: snap.data!),
                            /* CategoryVideoListWidget(
                                                  isHeadSectionShow: false,
                                                  itemCount: GenericVars.getVideoData.length,
                                                  didDescriptionShow: false,
                                                  isScroll: false,
                                                  itemHeight: 0.35,
                                                  elevation: 0), */
                            HomePageFooter()
                          ],
                        ),
                      )
                    : Container(
                        height: GenericVars.scSize.height * 0.7,
                        child: Center(
                          child: LoaderWidget(),
                        ),
                      ),
              ),
            )));
  }
}
