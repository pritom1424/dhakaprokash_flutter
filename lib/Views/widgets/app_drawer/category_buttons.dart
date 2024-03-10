import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final List<String> foundCategories;
  const CategoryButton({super.key, required this.foundCategories});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 5,
      childAspectRatio: 3 / 2,
      children: List.generate(
          foundCategories.length,
          (index) => Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.2, color: Colors.grey))),
              child: TextButton.icon(
                  icon: Icon(
                      GenericVars.newspaperCategories.values.toList()[index]),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CategoryView(
                                categoryName: foundCategories[index])));
                  },
                  style: ButtonStyle(),
                  label: Text(
                    foundCategories[index],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12),
                  )))),
    );

    /* ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => SingleCategoryTile());
  } */
  }
}
