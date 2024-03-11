import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/app_drawer.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/cupertino.dart';
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
      appBar: AppbarDefault(),
      body: FutureBuilder(
          future: photoController.loadAllItems(),
          builder: (ctx, photosnapShot) => (photosnapShot.connectionState ==
                  ConnectionState.waiting)
              ? LoaderWidget()
              : FutureBuilder(
                  future: postController.loadAllItems(),
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? LoaderWidget()
                        : Scrollbar(
                            thumbVisibility: true,
                            child: CustomScrollView(
                              slivers: [
                                SliverAppBar(
                                  pinned: true,
                                  title: Text(
                                    categoryName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                  automaticallyImplyLeading: false,
                                ),
                                SliverList(
                                    delegate: SliverChildListDelegate([
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(children: [
                                      //Category News List

                                      CategoryWidget(
                                        photoModels: photoController.Items,
                                        postModels: postController.Items,
                                        categoryName: categoryName,
                                        didMoreButtonShow: false,
                                        didHeadSectionShow: false,
                                        listItemLength: 8,
                                        didFloat: false,
                                      ),
                                      HomePageFooter()
                                    ]),
                                  )
                                ]))
                              ],
                            )

                            /* SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(children: [
                                  //Category News List
                                  Text(categoryName)
                                  CategoryWidget(
                                    photoModels: photoController.Items,
                                    postModels: postController.Items,
                                    categoryName: categoryName,
                                    didMoreButtonShow: false,
                                    didHeadSectionShow: false,
                                    listItemLength: 8,
                                    didFloat: false,
                                  ),
                                  HomePageFooter()
                                ]),
                              ),
                            ), */
                            );
                  })),
    );
  }
}
