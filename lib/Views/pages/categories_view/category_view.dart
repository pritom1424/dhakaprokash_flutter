import 'package:dummy_app/Controllers/category_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_total.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  final String categoryName;
  final String? catSlug;
  final bool? isPost;
  const CategoryView({
    super.key,
    required this.categoryName,
    required this.catSlug,
    this.isPost,
  });

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int itm = 10;
  int addMore = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    HomepageController homepageController = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppbarDefault(),
      body: (widget.catSlug != null)
          ? Scrollbar(
              thumbVisibility: true,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: Text(
                      widget.categoryName,
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontSize,
                          color: Colors.blue),
                    ),
                    automaticallyImplyLeading: false,
                  ),
                  FutureBuilder(
                    future: homepageController.loadAllRegCatItemsPost(
                        widget.catSlug!, itm),
                    builder: (ctx, snapShot) => SliverList(
                        delegate: SliverChildListDelegate([
                      if (snapShot.hasData)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(children: [
                            //Category News List

                            CategoryWidgetTotal(
                                dhakaprokashModel: snapShot.data!,
                                categoryName: widget.categoryName,
                                didMoreButtonShow: false,
                                didHeadSectionShow: false,
                                listItemLength: snapShot.data!.contents.length,
                                didFloat: false),

                            GestureDetector(
                              onTap: () {
                                AddMore(snapShot.data!.totalPost);
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
                      else
                        Container(
                            height: GenericVars.scSize.height * 0.6,
                            child: LoaderWidget())
                    ])),
                  ),
                ],
              ))
          : const Center(
              child: Text("কোনো তথ্য পাওয়া যায় নি"),
            ),
    );
  }
}
