import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:flutter/material.dart';

class DeskViewBar extends StatelessWidget {
  final DateTime dateTime;
  const DeskViewBar({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    String iconPath = "assets/images/dhakaprokash_icon.png";
    String title = "Dhaka Prokash Desk";
    String publishedDate = DateFormatter().defaultFormat(dateTime);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => CategoryView(
                categoryName: title,
                categoryLink: null,
              ))),
      child: Container(
        decoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Colors.grey, width: 0.3))),
        child: Row(
          children: [
            Container(
              height: GenericVars.scSize.height * 0.04,
              child: Image.asset(
                iconPath,
                filterQuality: FilterQuality.low,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    publishedDate,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
