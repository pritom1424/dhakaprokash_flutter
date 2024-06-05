import 'package:dummy_app/Utils/Controllers/all_controllers.dart';

import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_recent.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestNewsView extends StatefulWidget {
  final bool? isEnableAppbar;
  const LatestNewsView({
    super.key,
    this.isEnableAppbar,
  });

  @override
  State<LatestNewsView> createState() => _LatestNewsViewState();
}

class _LatestNewsViewState extends State<LatestNewsView> {
  int itm = 10;
  int addMore = 10;
  void _addMore(int totalItem) {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, ref, _) => Scaffold(
        appBar: (widget.isEnableAppbar != null && widget.isEnableAppbar == true)
            ? const AppbarDefault()
            : null,
        body: Scrollbar(
            thumbVisibility: true,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text(
                    "সর্বশেষ",
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .fontSize,
                        color: AppColors.logoColorDeep),
                  ),
                  automaticallyImplyLeading: false,
                ),
                FutureBuilder(
                    future:
                        ref.watch(recentPageController).loadRecentPosts(itm),
                    builder: (ctx, snapRecent) => SliverList(
                            delegate: SliverChildListDelegate([
                          (snapRecent.hasData)
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(children: [
                                    //Category News List

                                    CategoryWidgetRecent(
                                        dhakaprokashModels: snapRecent.data!,
                                        categoryName:
                                            snapRecent.data![0].bnCatName ?? "",
                                        didMoreButtonShow: false,
                                        didHeadSectionShow: false,
                                        listItemLength: snapRecent.data!.length,
                                        didFloat: false),
                                    GestureDetector(
                                      onTap: () {
                                        _addMore(2000);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 0.5,
                                                color:
                                                    AppColors.logoColorDeep)),
                                        child: const Text(
                                          "আরও",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.logoColorDeep),
                                        ),
                                      ),
                                    ),

                                    const HomePageFooter()
                                  ]),
                                )
                              : SizedBox(
                                  height: GenericVars.scSize.height * 0.6,
                                  child: const LoaderWidget()),
                        ])))
              ],
            )),
      ),
    );
  }
}
/* */
