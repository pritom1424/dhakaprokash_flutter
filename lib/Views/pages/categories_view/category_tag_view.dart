import 'package:dummy_app/Controllers/detailpage_controller.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorylist_tile.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CategoryTagnAuthorView extends StatefulWidget {
  final String slug;
  final bool? isAuthor;
  final String? name;
  const CategoryTagnAuthorView(
      {super.key, required this.slug, this.isAuthor, this.name});

  @override
  State<CategoryTagnAuthorView> createState() => _CategoryTagnAuthorViewState();
}

class _CategoryTagnAuthorViewState extends State<CategoryTagnAuthorView> {
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
    DetailPageController detailPageController =
        Provider.of<DetailPageController>(context, listen: false);
    return Scaffold(
      appBar: AppbarDefault(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                height: GenericVars.scSize.height * 0.1,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.3, color: Colors.black38))),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      child: Image.asset("assets/images/dhakaprokash_icon.png"),
                    ),
                    /*   Icon(
                    /*   (widget.isAuthor == null || widget.isAuthor == false)
                          ? Icons.tag
                          : CupertinoIcons.pen, */
                      color: AppColors.logoColorDeep,
                    ) */
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      (widget.isAuthor == null || widget.isAuthor == false)
                          ? widget.slug
                          : widget.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontFamily: GenericVars.currenFontFamily,
                          fontWeight: FontWeight.bold,
                          color: AppColors.logoColorDeep),
                    )
                  ],
                ),
              ),
              if (widget.isAuthor == null || widget.isAuthor == false)
                FutureBuilder(
                    future: detailPageController.loadtagPost(widget.slug, itm),
                    //  : detailPageController.loadAuthorPost(widget.slug, itm),
                    builder: (ctx, snap) => (snap.hasData)
                        ? Column(
                            children: [
                              Column(
                                children: List.generate(
                                    snap.data!.content.length,
                                    (index) => CategoryListTile(
                                          imagePath:
                                              "https://admin.dhakaprokash24.com/media/content/images/${snap.data!.content[index].imgBgPath}",
                                          newsTitle: snap.data!.content[index]
                                                  .contentHeading ??
                                              "",
                                          itemHeight: 0.16,
                                          dateTime: snap.data!.content[index]
                                                  .createdAt ??
                                              DateTime.now(),
                                          id: snap.data!.content[index]
                                                  .contentId ??
                                              -1,
                                          updateDateTime: snap
                                              .data!.content[index].updatedAt,
                                        )),
                              ),
                              Visibility(
                                visible: (snap.data!.content.length >= 10)
                                    ? true
                                    : false,
                                child: GestureDetector(
                                  onTap: () {
                                    AddMore(2000); //snapShot.data!.totalPost
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
                          )
                        : Container(
                            height: GenericVars.scSize.height * 0.6,
                            child: LoaderWidget()))
              else
                FutureBuilder(
                    future:
                        detailPageController.loadAuthorPost(widget.slug, itm),
                    //  : detailPageController.loadAuthorPost(widget.slug, itm),
                    builder: (ctx, snap) => (snap.hasData)
                        ? Column(
                            children: [
                              Column(
                                children: List.generate(
                                    snap.data!.content.length,
                                    (index) => CategoryListTile(
                                          imagePath:
                                              "https://admin.dhakaprokash24.com/media/content/images/${snap.data!.content[index].imgBgPath}",
                                          newsTitle: snap.data!.content[index]
                                                  .contentHeading ??
                                              "",
                                          itemHeight: 0.16,
                                          dateTime: snap.data!.content[index]
                                                  .createdAt ??
                                              DateTime.now(),
                                          id: snap.data!.content[index]
                                                  .contentId ??
                                              -1,
                                          updateDateTime: snap
                                              .data!.content[index].updatedAt,
                                        )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AddMore(100); //snapShot.data!.totalPost
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
                            ],
                          )
                        : Container(
                            height: GenericVars.scSize.height * 0.6,
                            child: LoaderWidget())),
            ],
          ),
        ),
      ),
    );
  }
}
