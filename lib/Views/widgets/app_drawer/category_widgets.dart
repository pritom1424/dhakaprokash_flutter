import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:flutter/material.dart';

class CategoryWidgets extends StatelessWidget {
  final List<String> foundCategories;
  const CategoryWidgets({super.key, required this.foundCategories});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      childAspectRatio: 3 / 2,
      children: List.generate(
          foundCategories.length,
          (index) => Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.2, color: Colors.grey))),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  foundCategories[index],
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(),
              ))),
    );

    /* ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => SingleCategoryTile());
  } */
  }
}
