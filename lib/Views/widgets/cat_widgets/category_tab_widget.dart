import 'package:dummy_app/Models/dhak_prokash_tab_model.dart';
import 'package:dummy_app/Models/dhaka_prokash_reg_model.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_view.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorytab_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoryTabWidget extends StatelessWidget {
  final String catName;
  final int itemNumber;
  final List<DhakaProkashRegularModel> dhakaProkashModels;
  const CategoryTabWidget(
      {super.key,
      required this.dhakaProkashModels,
      required this.catName,
      required this.itemNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(
              itemNumber,
              (index) => CategoryTabTile(
                  id: dhakaProkashModels[index].contentId ?? -1,
                  imageCaption: null,
                  dateTime: dhakaProkashModels[index].createdAt,
                  categoryName: dhakaProkashModels[index].bnCatName ?? "",
                  newsDescription:
                      dhakaProkashModels[index].contentDetails ?? "",
                  imagePath:
                      "https://admin.dhakaprokash24.com/media/content/images/${dhakaProkashModels[index].imgBgPath.toString()}",
                  rankString:
                      NumberFormat(null, 'Bn').format(index + 1).toString(),
                  title: dhakaProkashModels[index].contentHeading ?? "title")),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => CategoryView(
                      isPost: true,
                      categoryName: catName,
                      catSlug: dhakaProkashModels[0].catSlug,
                    )));
          },
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: AppColors.logoColorDeep)),
            child: Text(
              "$catName সব খবর",
              textAlign: TextAlign.center,
              style: GoogleFonts.tiroBangla(
                  fontWeight: FontWeight.bold, color: AppColors.logoColorDeep),
            ),
          ),
        )
      ],
    );
  }
}
