import 'package:avatar_glow/avatar_glow.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/pages/contact_view/contact_view.dart';
import 'package:dummy_app/Views/pages/custom_appdrawer.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/my%20app/myapp_view.dart';
import 'package:dummy_app/Views/pages/popular_view/popularnews_view.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/category_avatar_widget.dart';
import 'package:dummy_app/Views/widgets/category_widget%20copy.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget%20copy.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget.dart';
import 'package:dummy_app/Views/widgets/categoryvideo_widget.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';
import 'package:dummy_app/Views/widgets/navbar_widget.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavIndex = 0;
  bool _showScrollToTop = false;
  late ScrollController _scrollController;
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0.0);
  bool didNavButtonGlow = false;
  // List<Widget> _navViewsNew(HomepageController homepageController,
  //     ScrollController scrollController) {
  //   return [homeBaseWidgetCopy(homepageController, scrollController)];
  // }

  List<Widget> _NavViews(
      PhotoController pcontrol,
      ScrollController scrollController,
      HomepageController homepageController) {
    _showScrollToTop = false;
    return [
      homeBaseWidget(pcontrol, scrollController, homepageController),
      PopularNewsView(
        phController: pcontrol,
      ),
      FavoritesNewsView(
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
      didNavButtonGlow = true;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollOffset);
    _showScrollToTop = false;

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _updateScrollOffset() {
    _scrollOffset.value = _scrollController.offset;
    if (_scrollOffset.value > 100) {
      _showScrollToTop = true;
    } else {
      _showScrollToTop = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    GenericVars.scSize = MediaQuery.of(context).size;
    //PostController postController = Provider.of<PostController>(context);
    PhotoController photoController = Provider.of<PhotoController>(context);
    HomepageController homepageController =
        Provider.of<HomepageController>(context);

    return Scaffold(
        floatingActionButton: (_selectedNavIndex == 0)
            ? ValueListenableBuilder(
                valueListenable: _scrollOffset,
                builder: (ctx, offset, _) => Visibility(
                  visible: _showScrollToTop,
                  child: FloatingActionButton(
                    onPressed: () {
// Scroll to the top logic here
                      _scrollController.animateTo(
                        0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Icon(Icons.arrow_upward),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: (_selectedNavIndex == 0)
            ? FloatingActionButtonLocation.endFloat
            : null,
        appBar: (_selectedNavIndex != 5) ? AppbarDefault() : null,
        drawer: CustomAppDrawer(), //AppDrawer(),

//navigation bar
        bottomNavigationBar: NavBarWidget(
          currentIndex: _selectedNavIndex,
          onTap: _onNavigationTap,
        ) /* Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(
                    10)) /* BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)) */
                ),
            child: BottomNavigationBar(
                iconSize: 20,
                selectedFontSize: 12,
                unselectedFontSize: 10,
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: _selectedNavIndex,
                onTap: _onNavigationTap,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepPurple,
                unselectedItemColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Colors.white),
                unselectedIconTheme: IconThemeData(color: Colors.white),
                selectedIconTheme: IconThemeData(color: Colors.yellow),
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF1D6ECC),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.home,
                        ),
                      ),
                    ),
                    label: 'home',
                  ),
                  BottomNavigationBarItem(
                      icon: AvatarGlow(
                        duration: (didNavButtonGlow && _selectedNavIndex == 1)
                            ? Duration(milliseconds: 800)
                            : Duration(seconds: 0),
                        glowCount: 2,
                        animate: (didNavButtonGlow && _selectedNavIndex == 1),
                        repeat: false,
                        glowColor: Colors.blue,
                        curve: Curves.ease,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF1D6ECC),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.trending_up,
                            ),
                          ),
                        ),
                      ),
                      label: 'popular'),
                  BottomNavigationBarItem(
                      icon: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF1D6ECC),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.star,
                          ),
                        ),
                      ),
                      label: 'favorites'),
                  BottomNavigationBarItem(
                      icon: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF1D6ECC),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(Icons.search),
                          )),
                      label: 'search'),
                  BottomNavigationBarItem(
                      icon: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF1D6ECC),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.contact_page,
                          ),
                        ),
                      ),
                      label: 'Contact'),
                  BottomNavigationBarItem(
                      icon: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF1D6ECC),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.login_sharp,
                          ),
                        ),
                      ),
                      label: 'My App'),
                ]),
          ),
        ) */
        ,
        body: (_selectedNavIndex != 3)
            ? /* FutureBuilder(
                future: homepageController.loadAllItems(),
                builder: (ctx, homeSnapShot) {
                  return (homeSnapShot.connectionState ==
                          ConnectionState.waiting)
                      ? LoaderWidget()
                      : _navViewsNew(homepageController, _scrollController)[
                          _selectedNavIndex];
                })
            : _navViewsNew(
                homepageController, _scrollController)[_selectedNavIndex]); */

            //  FutureBuilder(future: homepageController.loadAllItems(), builder: (ctx, homeSnapShot)=>(homeSnapShot.connectionState==ConnectionState.waiting)?LoaderWidget():)

            FutureBuilder(
                future: photoController.loadAllItems(),
                builder: (ctx, photosnapShot) =>
                    (photosnapShot.connectionState == ConnectionState.waiting)
                        ? const LoaderWidget()
                        : FutureBuilder(
                            future: homepageController.loadAllItems(),
                            builder: (ctx, homePageSnapShot) {
                              return (homePageSnapShot.connectionState ==
                                      ConnectionState.waiting)
                                  ? const LoaderWidget()
                                  : _NavViews(
                                      photoController,
                                      _scrollController,
                                      homepageController)[_selectedNavIndex];
                            }),
              )
            : _NavViews(photoController, _scrollController, homepageController)[
                _selectedNavIndex]);
  }

  Widget homeBaseWidget(
      PhotoController phController,
      ScrollController scrollController,
      HomepageController homepageController) {
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
            /*  ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          SpeechScreen() /*VideoTest() TestPage() */));
                },
                child: Text("debug")), */

            CategoryWidgetCopy(
                dhakaprokashModels: homepageController.Items,
                categoryName: 'Recent',
                didMoreButtonShow: false,
                didHeadSectionShow: true,
                listItemLength: 5,
                didFloat: false),

            CategoryVideoWidget(
                didPause: Provider.of<VideoProvider>(context).IsVideoPause,
                dhakaprokashModels: homepageController.Items,
                categoryName: "Video",
                didMoreButtonShow: false,
                didHeadSectionShow: true,
                listItemLength: 5,
                didFloat: false),

            CategoryGridWidgetCopy(
              dhakaprokashModels: homepageController.Items.sublist(5),
              categoryName: "More",
              itemCount: 6,
              didAxisHorizontal: false,
              crossAxisCount: 2,
              didDescriptionShow: false,
              isScroll: false,
              elevation: 0,
            ),
            //main news + headline+recent lists
            /* CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Recent",
              didMoreButtonShow: false,
              didHeadSectionShow: true,
              listItemLength: 10,
              didFloat: false,
            ), */
            //For you
            CategoryGridWidget(
              photoModels: phController.Items,
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
              categoryName: "Sports",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),
            //national news
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "National News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),
            //international news
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "International News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),

            //bindon special widget
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Entertainment",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: true,
            ),

            //life style
            CategoryGridWidget(
              photoModels: phController.Items,
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
                categoryName: "Opinion/Editorial",
                didMoreButtonShow: true,
                listItemLength: 5),

            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Business",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            //video section
            CategoryGridWidget(
              photoModels: phController.Items,
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
              categoryName: "Education",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //job
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Job",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //science
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Technology",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            // gadgets
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Gadgets",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //onno alo
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Onno ALo",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            //dur porobash
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Dur Porobash",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //nagorik shongbad
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Nagorik News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //Religion
            CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Religion",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            // Health
            CategoryWidget(
              photoModels: phController.Items,
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




 /* Widget homeBaseWidgetCopy(
      HomepageController hcontroller, ScrollController scontroller) {
    return Scrollbar(
      thumbVisibility: true,
      controller: scontroller,
      //main section started
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scontroller,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            /*  ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          SpeechScreen() /*VideoTest() TestPage() */));
                },
                child: Text("debug")), */
            //main news + headline+recent lists
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Recent",
              didMoreButtonShow: false,
              didHeadSectionShow: true,
              listItemLength: 10,
              didFloat: false,
            ),
            //For you
            CategoryGridWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "For you",
              itemCount: 6,
              didAxisHorizontal: false,
              crossAxisCount: 2,
              didDescriptionShow: true,
              isScroll: false,
              elevation: 0,
            ),
            //tab widget

            //sports
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Sports",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),
            //national news
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "National News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),
            //international news
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "International News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ),

            //bindon special widget
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Entertainment",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: true,
            ),

            //life style
            CategoryGridWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Lifestyle",
              itemCount: 4,
              didAxisHorizontal: true,
              crossAxisCount: 1,
              didDescriptionShow: true,
              isScroll: true,
              elevation: 5,
            ),
            //motamot special widget

            /*   CategoryAvatatarWidgetCopy(
                 dhakaprokashModels: hcontroller.Items,
                categoryName: "Opinion/Editorial",
                didMoreButtonShow: true,
                listItemLength: 5), */

            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Business",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            //video section
            CategoryGridWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Video",
              itemCount: 5,
              didAxisHorizontal: true,
              crossAxisCount: 1,
              didDescriptionShow: true,
              isScroll: true,
              elevation: 5,
            ),
            // education
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Education",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //job
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Job",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //science
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Technology",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            // gadgets
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Gadgets",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //onno alo
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Onno ALo",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            //dur porobash
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Dur Porobash",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //nagorik shongbad
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Nagorik News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ),
            //Religion
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
              categoryName: "Religion",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ),
            // Health
            CategoryWidgetCopy(
              dhakaprokashModels: hcontroller.Items,
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
  } */