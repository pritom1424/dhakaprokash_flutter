import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final List<String> foundCategories;
  const CategoryButton({super.key, required this.foundCategories});
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    double cellHeight = 0.08;
    int crossAxisCount = 2;

    return Container(
      height: GenericVars.scSize.height *
          (cellHeight + 0.005) *
          (foundCategories.length / crossAxisCount).ceil(),
      child: GridView.count(
        //physics: NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 5 / 3,
        children: List.generate(
          foundCategories.length,
          (index) => Container(
              height: GenericVars.scSize.height * 0.02,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.3, color: Colors.grey))),
              child: TextButton.icon(
                  icon: Icon(
                      color: Colors.black87,
                      GenericVars.newspaperCategories.values.toList()[index]),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CategoryView(
                                categoryLink:
                                    GenericVars.newspaperCategoriesLink[
                                        foundCategories[index]],
                                categoryName: foundCategories[index])));
                  },
                  style: TextButton.styleFrom(
                      shape: LinearBorder(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      disabledForegroundColor: Colors.blue,
                      padding: EdgeInsets.all(0)),

                  /*  ButtonStyle(
                        padding: MaterialStateProperty.all(Border.all()),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.resolveWith(getColor),
                      ), */
                  label: Text(
                    foundCategories[index],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12),
                  ))
              /*     Row(
                children: [
                  Icon(
                    GenericVars.newspaperCategories.values.toList()[index],
                    color: Colors.black54,
                  ),
                  Text(
                    foundCategories[index],
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  )
                ],
              ) */
              ),
        ),
      ),
    );

    /* ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => SingleCategoryTile());
  } */
  }
}
