import 'dart:ffi';

import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/app_drawer.dart';
import 'package:dummy_app/Views/pages/categories_view/sports_view.dart';
import 'package:dummy_app/Views/pages/contact_view/contact_view.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/latest_view/latestnews_view.dart';
import 'package:dummy_app/Views/pages/popular_view/popularnews_view.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/category_avatar_widget.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavIndex = 0;

  List<Widget> _NavViews(PhotoController pcontrol, PostController postControl) {
    return [
      homeBaseWidget(postControl, pcontrol),
      LatestNewsView(
        pcontroller: postControl,
        phController: pcontrol,
      ),
      PopularNewsView(
        pcontroller: postControl,
        phController: pcontrol,
      ),
      FavoritesNewsView(
        pcontroller: postControl,
        phController: pcontrol,
      ),
      ContactView()
    ];
  }

  void _onNavigationTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    GenericVars.scSize = MediaQuery.of(context).size;
    PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    return Scaffold(
        appBar: (_selectedNavIndex != 4) ? AppbarDefault() : null,
        drawer: AppDrawer(),

//navigation bar
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedNavIndex,
            onTap: _onNavigationTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.blue,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.timelapse,
                  ),
                  label: 'latest'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.trending_up,
                  ),
                  label: 'popular'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                  ),
                  label: 'favorites'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contact_page,
                  ),
                  label: 'Contact')
            ]),
        body: FutureBuilder(
          future: photoController.loadAllItems(),
          builder: (ctx, photosnapShot) => (photosnapShot.connectionState ==
                  ConnectionState.waiting)
              ? const LoaderWidget()
              : FutureBuilder(
                  future: postController.loadAllItems(),
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const LoaderWidget()
                        : _NavViews(
                            photoController, postController)[_selectedNavIndex];
                  }),
        ));
  }

  Widget homeBaseWidget(
      PostController pcontroller, PhotoController phController) {
    return Scrollbar(
      thumbVisibility: true,
//main section started
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
//main news + headline+recent lists
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Recent",
              didMoreButtonShow: false,
              didHeadSectionShow: true,
              listItemLength: 10,
              didFloat: false,
            ),
//For you
            CategoryGridWidget(
                photoModels: phController.Items,
                postModels: pcontroller.Items,
                categoryName: "For you",
                itemCount: 4,
                gridHeight: 0.4),
//tab widget

//sports
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Sports",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),
//national news
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "National News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),
//international news
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "International News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),

//bindon special widget
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Entertainment",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: true,
            ),

//life style
            CategoryGridWidget(
                photoModels: phController.Items,
                postModels: pcontroller.Items,
                categoryName: "Lifestyle",
                itemCount: 4,
                gridHeight: 0.4),
//motamot special widget

            CategoryAvatatarWidget(
                photoModels: phController.Items,
                postModels: pcontroller.Items,
                categoryName: "Opinion/Editorial",
                didMoreButtonShow: true,
                listItemLength: 5),

            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Business",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
//video section
            CategoryGridWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Video",
              itemCount: 5,
              gridHeight: 0.4,
            ),
// education
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Education",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
//job
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Job",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
//science
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Technology",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
// gadgets
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Gadgets",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
//onno alo
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Onno ALo",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
//dur porobash
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Dur Porobash",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
//nagorik shongbad
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Nagorik News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
//Religion
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Religion",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
// Health
            CategoryWidget(
              photoModels: phController.Items,
              postModels: pcontroller.Items,
              categoryName: "Health",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            HomePageFooter()
          ]),
        ),
      ),
    );
  }
}
