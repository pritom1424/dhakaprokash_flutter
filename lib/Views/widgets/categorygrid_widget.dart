import 'package:dummy_app/Models/photo_model.dart';
import 'package:dummy_app/Models/post_model.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/home_page.dart';
import 'package:dummy_app/Views/widgets/categorygrid_tile.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CategoryGridWidget extends StatelessWidget {
  final String categoryName;
  final List<PhotoModel> photoModels;
  final List<PostModel> postModels;
  final int itemCount;
  final double gridHeight;
  const CategoryGridWidget(
      {super.key,
      required this.photoModels,
      required this.postModels,
      required this.categoryName,
      required this.itemCount,
      required this.gridHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      //category home widget column startted
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //part 1//categoryname + More Button section

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CategoryView(categoryName: categoryName)));
            },
            child: Container(
              height: GenericVars.scSize.height * 0.07,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          width: 0.3,
                          color: Color.fromARGB(255, 151, 144, 144)))),
              child: Row(
                children: [
                  Text(
                    categoryName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),

          //part 3//Category News Lists
          Container(
              height: GenericVars.scSize.height * gridHeight,
              //gridHeight
              // padding: EdgeInsets.symmetric(vertical: 2),
              child: GridView.count(
                  //physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    itemCount,
                    (index) {
                      if (index < itemCount) {
                        return CategoryGridTile(
                            categoryName: categoryName,
                            imagePath: photoModels[index].url,
                            newsTitle: photoModels[index].description,
                            newsDescription: postModels[index].body,
                            /*postModels[index].title, */
                            newsDate: DateFormat.yMEd().format(DateTime.now()));
                      } else {
                        return Text("No list");
                      }
                    },
                  )))
        ],
      ),
    );
  }
}
