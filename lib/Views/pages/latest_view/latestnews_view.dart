import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/material.dart';

class LatestNewsView extends StatelessWidget {
  final PhotoController phController;
  final PostController pcontroller;
  const LatestNewsView({
    super.key,
    required this.phController,
    required this.pcontroller,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
//main section started
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            //main news + headline
            Container(
              width: double.infinity,
              height: GenericVars.scSize.height * 0.4,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: HeadImageWidget(
                  title: pcontroller.Items[0].title,
                  url: phController.Items[0].url),
            ),
            //Recent news Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: RecentCategoryHomeWidget(
                categoryName: "Recent",
                photoModels: phController.Items,
                postModels: pcontroller.Items,
              ),
            ),

            //Category News List
            Column(
              children: List.generate(
                GenericVars.newspaperCategories.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: CategoryWidget(
                    categoryName: GenericVars.newspaperCategories[index],
                    photoModels: phController.Items,
                    postModels: pcontroller.Items,
                    listHeight: 0.33,
                    didMoreButtonShow: true,
                  ),
                ),
              ),
            ),

            HomePageFooter()
          ]),
        ),
      ),
    );
  }
}
