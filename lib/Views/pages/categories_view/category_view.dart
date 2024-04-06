import 'package:dummy_app/Controllers/category_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_total.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

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
  int addMore = 4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void AddMore() {
    setState(() {
      itm += addMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomepageController homepageController = Provider.of(context, listen: false);
    CategoryViewController catViewControl = Provider.of(context, listen: false);

    print("Cat slug : ${widget.catSlug}");
    return Scaffold(
      appBar: AppbarDefault(),
      body: (widget.catSlug != null)
          ? FutureBuilder(
              future: homepageController.loadAllRegCatItemsPost(
                  widget.catSlug!, catViewControl.TotalShowNumber),

              /* (isPost == null || isPost == false)
                  ? homepageController.loadAllRegItems(categoryLink!)
                  : homepageController.loadAllRegTabItemsPost(
                      categoryLink!, 10), */
              builder: (ctx, snapShot) =>
                  (snapShot.connectionState == ConnectionState.waiting)
                      ? LoaderWidget()
                      : Scrollbar(
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
                              SliverList(
                                  delegate: SliverChildListDelegate([
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(children: [
                                    //Category News List
                                    CategoryWidgetTotal(
                                        dhakaprokashModel: snapShot.data!,
                                        categoryName: widget.categoryName,
                                        didMoreButtonShow: false,
                                        didHeadSectionShow: false,
                                        listItemLength:
                                            snapShot.data!.contents.length,
                                        didFloat: false),
                                    Visibility(
                                      visible: catViewControl.isButtonVisible,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            catViewControl.addMoreItems(100);
                                          },
                                          child: Text("more")),
                                    ),
                                    /* CategoryWidgetRegular(
                                      dhakaprokashModels: snapShot.data!,
                                      categoryName: categoryName,
                                      didMoreButtonShow: false,
                                      didHeadSectionShow: false,
                                      listItemLength: snapShot.data!.length,
                                      didFloat: false,
                                    ), */
                                    HomePageFooter()
                                  ]),
                                )
                              ])),
                            ],
                          )))
          : Center(
              child: Text("কোনো তথ্য পাওয়া যায় নি"),
            ),
    );
  }
}
