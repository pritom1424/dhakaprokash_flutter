import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/app_drawer.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;
  const CategoryView({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 30),
          child: Image.asset(
            "assets/images/dhakaprokash_logo.png",
            width: GenericVars.scSize.width * 0.5,
            height: GenericVars.scSize.height * 0.2,
          ),
        ),
      ),
      body: FutureBuilder(
          future: photoController.loadAllItems(),
          builder: (ctx, photosnapShot) => (photosnapShot.connectionState ==
                  ConnectionState.waiting)
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

                                  CategoryWidget(
                                    photoModels: photoController.Items,
                                    postModels: postController.Items,
                                    categoryName: categoryName,
                                    listHeight: 1,
                                    didMoreButtonShow: false,
                                  ),
                                  HomePageFooter()
                                ]),
                              ),
                            ),
                          );
                  })),
    );
  }
}
