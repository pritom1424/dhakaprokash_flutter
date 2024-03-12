import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/material.dart';

class CategoryWidgets extends StatelessWidget {
  final List<String> foundCategories;
  const CategoryWidgets({super.key, required this.foundCategories});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      childAspectRatio: 3 / 2,
      children: List.generate(
          foundCategories.length,
          (index) => Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.2, color: Colors.grey))),
              child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(),
                  child: Text(
                    foundCategories[index],
                    textAlign: TextAlign.center,
                  )))),
    );

    /* ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => SingleCategoryTile());
  } */
  }
}
