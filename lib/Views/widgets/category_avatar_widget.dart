import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/widgets/categoryavatarlist_%20tile.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryAvatatarWidget extends StatelessWidget {
  final String categoryName;
  final List<PhotoModel> photoModels;
  final List<PostModel> postModels;

  final bool didMoreButtonShow;
  final int listItemLength;

  const CategoryAvatatarWidget({
    super.key,
    required this.photoModels,
    required this.postModels,
    required this.categoryName,
    required this.didMoreButtonShow,
    required this.listItemLength,
  });

  @override
  Widget build(BuildContext context) {
    final double itemHeight = 0.18;

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
                    builder: (ctx) =>
                        CategoryView(categoryName: categoryName)));
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
                        name: "name",
                        categoryName: categoryName,
                        imagePath: photoModels[index].url,
                        newsTitle: photoModels[index].description,
                        newsDescription: postModels[index].body,
                        itemHeight: itemHeight,
                        /*postModels[index].title, */
                        newsDate: DateFormat.yMEd().format(DateTime.now()));
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
