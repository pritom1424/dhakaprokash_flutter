import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/pages/deskview/desk_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DeskViewBar extends StatelessWidget {
  final String date;
  const DeskViewBar({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String iconPath = "assets/images/dhakaprokash_icon.png";
    String title = "Dhaka Prokash Desk";
    String publishedDate = date;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => CategoryView(categoryName: title))),
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    publishedDate,
                    style: TextStyle(fontSize: 15),
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
