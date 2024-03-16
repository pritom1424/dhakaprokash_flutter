import 'dart:ffi';

import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/app_drawer.dart';
import 'package:dummy_app/Views/pages/categories_view/sports_view.dart';
import 'package:dummy_app/Views/pages/contact_view/contact_view.dart';
import 'package:dummy_app/Views/pages/custom_appdrawer.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/latest_view/latestnews_view.dart';
import 'package:dummy_app/Views/pages/my%20app/myapp_view.dart';
import 'package:dummy_app/Views/pages/popular_view/popularnews_view.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';
import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/category_avatar_widget.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:dummy_app/main.dart';
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

  List<Widget> _NavViews(PhotoController pcontrol, PostController postControl,
      ScrollController scrollController) {
    return [
      homeBaseWidget(postControl, pcontrol, scrollController),
      PopularNewsView(
        pcontroller: postControl,
        phController: pcontrol,
      ),
      FavoritesNewsView(
        pcontroller: postControl,
        phController: pcontrol,
      ),
      SearchToNewPage(),
      ContactView(),
      MyAppView()
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
    ScrollController _scrollController = ScrollController();
    return Scaffold(
        floatingActionButton: (_selectedNavIndex == 0)
            ? FloatingActionButton(
                onPressed: () {
                  // Scroll to the top logic here
                  _scrollController.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );

                  /*   setState(() {
              _scrollController.animateTo(
                0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }); */
                },
                child: Icon(Icons.arrow_upward),
              )
            : null,
        floatingActionButtonLocation: (_selectedNavIndex == 0)
            ? FloatingActionButtonLocation.endFloat
            : null,
        appBar: (_selectedNavIndex != 5) ? AppbarDefault() : null,
        drawer: CustomAppDrawer(), //AppDrawer(),

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
                    Icons.trending_up,
                  ),
                  label: 'popular'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                  ),
                  label: 'favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'search'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contact_page,
                  ),
                  label: 'Contact'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.login_sharp,
                  ),
                  label: 'My App'),
            ]),
        body: (_selectedNavIndex != 3)
            ? FutureBuilder(
                future: photoController.loadAllItems(),
                builder: (ctx, photosnapShot) =>
                    (photosnapShot.connectionState == ConnectionState.waiting)
                        ? const LoaderWidget()
                        : FutureBuilder(
                            future: postController.loadAllItems(),
                            builder: (ctx, postSnapShot) {
                              return (postSnapShot.connectionState ==
                                      ConnectionState.waiting)
                                  ? const LoaderWidget()
                                  : _NavViews(photoController, postController,
                                      _scrollController)[_selectedNavIndex];
                            }),
              )
            : _NavViews(photoController, postController, _scrollController)[
                _selectedNavIndex]);
  }

  Widget homeBaseWidget(PostController pcontroller,
      PhotoController phController, ScrollController scrollController) {
    return Scrollbar(
      thumbVisibility: true,
      controller: scrollController,
//main section started
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              cellHeight: 0.4,
              didAxisHorizontal: true,
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              didDescriptionShow: true,
              isScroll: true,
              elevation: 5,
            ),
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
              cellHeight: 0.4,
              didAxisHorizontal: true,
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              didDescriptionShow: true,
              isScroll: true,
              elevation: 5,
            ),
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
              didAxisHorizontal: true,
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              didDescriptionShow: true,
              cellHeight: 0.4,
              isScroll: true,
              elevation: 5,
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
