import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/follow_social.dart';
import 'package:flutter/material.dart';

class CategoryButtonList extends StatelessWidget {
  final List<String> foundCategories;
  const CategoryButtonList({super.key, required this.foundCategories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GenericVars.scSize.height * 0.7,
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
            foundCategories.length,
            (index) => Container(
                  // height: GenericVars.scSize.height * 0.07,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.3, color: Colors.grey))),
                  child: ListTile(
                    leading: Icon(
                        color: Colors.grey,
                        GenericVars.newspaperCategories.values.toList()[index]),
                    title: Text(
                      foundCategories[index],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: GenericVars.currenFontFamily),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CategoryView(
                                  categoryLink:
                                      GenericVars.newspaperCategoriesLink[
                                          foundCategories[index]],
                                  categoryName: foundCategories[index])));
                    },
                  ),
                )

            /*  TextButton.icon(
                    icon: Icon(
                        color: Colors.black,
                        GenericVars.newspaperCategories.values.toList()[index]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CategoryView(
                                  categoryName: foundCategories[index])));
                    },
                    style: TextButton.styleFrom(
                        shape: LinearBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    )) */
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
    );

    /* ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => SingleCategoryTile());
  } */
  }
}
