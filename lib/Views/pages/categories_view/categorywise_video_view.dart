import 'package:dummy_app/Utils/Controllers/all_controllers.dart';

import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/CategoryWiseVideoListWidget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategryWiseVideo extends StatefulWidget {
  final bool? isEnableAppbar;
  const CategryWiseVideo({super.key, this.isEnableAppbar});

  @override
  State<CategryWiseVideo> createState() => _CategryWiseVideoState();
}

class _CategryWiseVideoState extends State<CategryWiseVideo> {
  int itm = 10;
  int addMore = 10;
  bool isVisible = true;
  final bool isHeadSectionShow = false;
  final bool didDescriptionShow = false;
  final bool isScroll = false;
  final double elevation = 0;
  final double? itemHeight = null;

  void _addMore(int totalItem) {
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
    return Consumer(
      builder: (ctx, ref, _) => Scaffold(
        appBar: (widget.isEnableAppbar != null && widget.isEnableAppbar == true)
            ? const AppbarDefault()
            : null,
        body: SingleChildScrollView(
            child: FutureBuilder(
                future: ref.watch(videoController).getLatestAllVideos(itm),
                builder: (ctx, snapShot) => (snapShot.hasData)
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CategoryWiseVideoListWidget(
                                itemCount: itm,
                                dhakaProkashAllVideo: snapShot.data!,
                                isHeadSectionShow: isHeadSectionShow,
                                didDescriptionShow: didDescriptionShow,
                                isScroll: isScroll,
                                elevation: elevation),
                            Visibility(
                              visible: (snapShot.data!.videos.length >= itm &&
                                      itm < snapShot.data!.total)
                                  ? true
                                  : false,
                              child: GestureDetector(
                                onTap: () {
                                  _addMore(snapShot.data!.total);
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: const EdgeInsets.all(8),
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
                            const HomePageFooter()
                          ],
                        ),
                      )
                    : SizedBox(
                        height: GenericVars.scSize.height * 0.6,
                        child: const LoaderWidget()))),
      ),
    );
  }
}
