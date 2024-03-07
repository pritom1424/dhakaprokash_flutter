import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/app_drawer.dart';
import 'package:dummy_app/Views/widgets/home_view/categoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GenericVars.scSize = MediaQuery.of(context).size;
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
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.cabin,
                  color: Colors.blue,
                ),
                label: 'booking'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.navigation_rounded,
                  color: Colors.blue,
                ),
                label: 'navigate'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                label: 'bookmark')
          ]),
      body: FutureBuilder(
        future: photoController.loadAllItems(),
        builder: (ctx, photosnapShot) => (photosnapShot.connectionState ==
                ConnectionState.waiting)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: postController.loadAllItems(),
                builder: (ctx, postSnapShot) =>
                    (postSnapShot.connectionState == ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Scrollbar(
                            thumbVisibility: true,
//main section started
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
//main news + headline
                                Container(
                                  width: double.infinity,
                                  height: GenericVars.scSize.height * 0.5,
                                  child: HeadImageWidget(
                                      title: postController.Items[0].title,
                                      url: photoController.Items[0].url),
                                ),
//Recent news Section
                                RecentCategoryHomeWidget(
                                    photoModels: photoController.Items,
                                    postModels: postController.Items),
                                /* CategoryHomeWidget(
                                    categoryName:
                                        GenericVars.newspaperCategories[0],
                                    photoModels: photoController.Items,
                                    postModels: postController.Items), */
//Category News List
                                Column(
                                  children: List.generate(
                                    GenericVars.newspaperCategories.length,
                                    (index) => CategoryHomeWidget(
                                        categoryName: GenericVars
                                            .newspaperCategories[index],
                                        photoModels: photoController.Items,
                                        postModels: postController.Items),
                                  ),
                                ),

                                /* ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: GenericVars.newspaperCategories.length,
                              itemBuilder: (ctx, i) => CategoryHomeWidget(
                                  categoryName:
                                      GenericVars.newspaperCategories[i],
                                  photoModels: photoController.Items,
                                  postModels: postController.Items),
                            ), */
                                HomePageFooter()

                                // lates category news in list
                                //featured news
                                //all categories news in grid with two posts
                              ]),
                            ),
                          ),
              ),
      ),
    );
  }
}
