import 'package:dummy_app/Models/dhaka_prokash_sp_model.dart';
import 'package:dummy_app/Utils/Controllers/all_controllers.dart';
import 'package:dummy_app/Utils/api_constants.dart';

import 'package:dummy_app/Utils/app_colors.dart';

import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';

import 'package:dummy_app/Views/pages/newspage_view/detailedpost_view.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorylist_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryWidgetSpecial extends ConsumerWidget {
  final String categoryName;
  final List<DhakaProkashSpecialModel> dhakaprokashModels;

  final bool didMoreButtonShow;
  final bool didHeadSectionShow;
  final int listItemLength;
  final bool didFloat;

  const CategoryWidgetSpecial({
    super.key,
    required this.dhakaprokashModels,
    required this.categoryName,
    required this.didMoreButtonShow,
    required this.didHeadSectionShow,
    required this.listItemLength,
    required this.didFloat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double itemHeight = 0.13;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //part 1//categoryname + More Button section

        if (didMoreButtonShow)
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CategoryView(
                        categoryName: categoryName,
                        catSlug: dhakaprokashModels[0].category?.catSlug ?? "",
                      )));
            },
            child: Container(
                height: GenericVars.scSize.height * 0.07,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                /*  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            width: 0.3,
                            color: Color.fromARGB(255, 151, 144, 144)))), */
                child: Row(
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .fontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.categoryNameColor),
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: AppColors.categoryNameColor,
                    ),
                  ],
                )),
          ),

        //part 2//HeadImagePreview + title+description
        if (didHeadSectionShow)
          GestureDetector(
            onTap: () {
              ref.watch(videoController).pauseVideoState();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => DetailedPostView(
                        id: dhakaprokashModels[0].contentId ?? -1,
                      )));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: (!didFloat)
                      ? const Border(
                          bottom: BorderSide(
                              width: 0.3,
                              color: Color.fromARGB(255, 136, 135, 135)))
                      : const Border(
                          bottom:
                              BorderSide(width: 0, color: Colors.transparent))),
              width: double.infinity,
              height: (didFloat)
                  ? GenericVars.scSize.height * 0.45
                  : GenericVars.scSize.height * 0.40,
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: (didFloat)
                  ? Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[0].imgBgPath.toString()}",
                                fit: BoxFit.fitWidth,
                                filterQuality: FilterQuality.low,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    (loadingProgress == null)
                                        ? child
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Image.asset(
                                              "assets/images/dhakaprokash_logo.png",
                                            ),
                                          ),
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const CircularProgressIndicator(),
                                  // Image.asset(
                                  //   ApiConstant.imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                  // ),
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: GenericVars.scSize.height * 0.15,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: const Color.fromARGB(
                                        255, 129, 127, 127),
                                  )),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(categoryName),
                                  Text(
                                    dhakaprokashModels[0].contentHeading!,
                                    textAlign: TextAlign.justify,

                                    // "${StringLimiter().limitString(dhakaprokashModels[0].contentHeading!, 25)} . . .",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.alarm,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      /* Text(
                                        "প্রকাশঃ ${DateFormatter().defaultFormat(dhakaprokashModels[0].createdAt ?? DateTime.now())}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ), */
                                      Text(
                                        "${dhakaprokashModels[0].category?.catNameBn} | ${DateFormatter().defaultFormat(dhakaprokashModels[0].createdAt ?? DateTime.now())}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[0].imgBgPath.toString()}",
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    (loadingProgress == null)
                                        ? child
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Image.asset(
                                              ApiConstant
                                                  .imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                            ),
                                          ),
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                  // Image.asset(
                                  //   ApiConstant.imagePlaceHolder /* "assets/images/dhakaprokash_logo.png" */,
                                  // ),
                                ),
                              )),
                        ),
                        Text(
                          dhakaprokashModels[0].contentHeading!,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
            ),
          ),

        //part 3//Category News Lists
        if (didHeadSectionShow)
          SizedBox(
            height:
                GenericVars.scSize.height * itemHeight * (listItemLength - 1),
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listItemLength - 1,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return CategoryListTile(
                    id: dhakaprokashModels[index + 1].contentId ?? -1,
                    imagePath:
                        "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[index + 1].imgBgPath.toString()}",
                    newsTitle: dhakaprokashModels[index + 1].contentHeading!,
                    itemHeight: itemHeight,
                    /*postModels[index].title, */
                    dateTime: dhakaprokashModels[index + 1].createdAt ??
                        DateTime.now(),
                  );
                }),
          ),
        if (!didHeadSectionShow)
          SizedBox(
            height: GenericVars.scSize.height * itemHeight * (listItemLength),
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listItemLength,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return CategoryListTile(
                    id: dhakaprokashModels[index].contentId ?? -1,
                    imagePath:
                        "https://admin.dhakaprokash24.com/media/content/images/${dhakaprokashModels[index].imgBgPath.toString()}",
                    newsTitle: dhakaprokashModels[index].contentHeading!,
                    itemHeight: itemHeight,
                    /*postModels[index].title, */
                    dateTime:
                        dhakaprokashModels[index].createdAt ?? DateTime.now(),
                  );
                }),
          )
      ],
    );
  }
}
