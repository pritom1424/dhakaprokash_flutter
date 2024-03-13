import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:flutter/material.dart';

class PostTagTile extends StatelessWidget {
  final int crossAxisCount;
  final List<String> tagList;
  const PostTagTile(
      {super.key, required this.tagList, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final double cellHeight = 0.06;
    return tagList.isEmpty
        ? SizedBox(
            height: 0,
          )
        : Container(
            height: GenericVars.scSize.height *
                cellHeight *
                (tagList.length / crossAxisCount)
                    .ceil(), //  (itemCount / crossAxisCount).ceil(),
            width: double.infinity,
            child: GridView.count(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 9 / 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    tagList.length,
                    (index) => TextButton(
                        style: TextButton.styleFrom(
                            shape: LinearBorder(side: BorderSide.none),
                            fixedSize: Size(cellHeight * (9 / 2), cellHeight),
                            padding: EdgeInsets.all(0),
                            backgroundColor:
                                const Color.fromARGB(255, 193, 222, 235)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  CategoryView(categoryName: tagList[index])));
                        },
                        child: Text(tagList[index])))),
          );
  }
}
