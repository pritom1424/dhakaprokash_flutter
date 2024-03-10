import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:flutter/material.dart';

class PostTagTile extends StatelessWidget {
  final List<String> tagList;
  const PostTagTile({super.key, required this.tagList});

  @override
  Widget build(BuildContext context) {
    return tagList.isEmpty
        ? Text("No tags")
        : Container(
            height: GenericVars.scSize.height * 0.12,
            width: double.infinity,
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 7 / 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 5,
                //physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    tagList.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 193, 222, 235),
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 193, 222, 235))),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => CategoryView(
                                          categoryName: tagList[index])));
                                },
                                child: Text(tagList[index])),
                          ),
                        ))),
          );
  }
}
