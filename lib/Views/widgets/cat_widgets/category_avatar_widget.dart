import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';

import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categoryavatarlist_%20tile.dart';

import 'package:flutter/material.dart';

class CategoryAvatatarWidget extends StatelessWidget {
  final String categoryName;
  final List<DhakaProkashRegularModel> dhakaProkashRegModels;

  final bool didMoreButtonShow;
  final int listItemLength;

  const CategoryAvatatarWidget({
    super.key,
    required this.dhakaProkashRegModels,
    required this.categoryName,
    required this.didMoreButtonShow,
    required this.listItemLength,
  });

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 0.16;

    return Container(
      //category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//part 1//categoryname + More Button section

          if (didMoreButtonShow)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => CategoryView(
                          categoryName: categoryName,
                          catSlug: dhakaProkashRegModels[0].catSlug,
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.red,
                      ),
                    ],
                  )),
            ),

//part 3//Category News Lists
          Container(
            height: GenericVars.scSize.height * itemHeight * listItemLength,
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: listItemLength,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  if (index < listItemLength) {
                    return CategoryAvatarListTile(
                        id: dhakaProkashRegModels[index].contentId ?? -1,
                        name: "name",
                        categoryName: categoryName,
                        imagePath: dhakaProkashRegModels[index].imgBgPath ??
                            "assets/images/character_placeholder.png",
                        newsTitle:
                            dhakaProkashRegModels[index].contentHeading ??
                                "not found",
                        newsDescription:
                            dhakaProkashRegModels[index].contentDetails ??
                                "not found",
                        itemHeight: itemHeight,
                        /*postModels[index].title, */
                        dateTime: DateTime.now());
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}
