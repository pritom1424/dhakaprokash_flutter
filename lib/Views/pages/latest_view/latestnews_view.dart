import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/recent_page_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_recent.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_sp.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LatestNewsView extends StatefulWidget {
  const LatestNewsView({
    super.key,
  });

  @override
  State<LatestNewsView> createState() => _LatestNewsViewState();
}

class _LatestNewsViewState extends State<LatestNewsView> {
  int itm = 10;
  int addMore = 10;
  void AddMore(int totalItem) {
    setState(() {
      if (totalItem == itm + addMore) {
        itm = totalItem;
      } else if (totalItem < itm + addMore && totalItem > itm) {
        itm = totalItem;
      } else if (totalItem > itm) {
        itm += addMore;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RecentPageController recentPageController =
        Provider.of<RecentPageController>(context, listen: false);
    return Scrollbar(
        thumbVisibility: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(
                "সর্বশেষ",
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium!.fontSize,
                    color: AppColors.logoColorDeep),
              ),
              automaticallyImplyLeading: false,
            ),
            FutureBuilder(
                future: recentPageController.loadRecentPosts(itm),
                builder: (ctx, snapRecent) => SliverList(
                        delegate: SliverChildListDelegate([
                      (snapRecent.hasData)
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(children: [
                                //Category News List

                                CategoryWidgetRecent(
                                    dhakaprokashModels: snapRecent.data!,
                                    categoryName: snapRecent.data![0].bnCatName,
                                    didMoreButtonShow: false,
                                    didHeadSectionShow: false,
                                    listItemLength: snapRecent.data!.length,
                                    didFloat: false),
                                GestureDetector(
                                  onTap: () {
                                    AddMore(100);
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

                                HomePageFooter()
                              ]),
                            )
                          : Container(
                              height: GenericVars.scSize.height * 0.6,
                              child: LoaderWidget()),
                    ])))
          ],
        ));
  }
}
/* */
