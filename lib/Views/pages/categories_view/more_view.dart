import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: photoController.loadAllItems(),
        builder: (ctx, photosnapShot) =>
            (photosnapShot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder(
                    future: postController.loadAllItems(),
                    builder: (ctx, postSnapShot) {
                      return (postSnapShot.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Scrollbar(
                              thumbVisibility: true,
//main section started
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(children: [
                                    //Category News List
                                    Column(
                                      children: List.generate(
                                        GenericVars.newspaperCategories.length,
                                        (index) => Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: CategoryWidget(
                                              categoryName: GenericVars
                                                  .newspaperCategories[index],
                                              photoModels: phController.Items,
                                              postModels: pcontroller.Items),
                                        ),
                                      ),
                                    ),

                                    HomePageFooter()
                                  ]),
                                ),
                              ),
                            );
                    }));
  }
}
