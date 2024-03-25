import 'package:avatar_glow/avatar_glow.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';

import 'package:dummy_app/Views/pages/contact_view/contact_view.dart';
import 'package:dummy_app/Views/pages/custom_appdrawer.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/my%20app/myapp_view.dart';
import 'package:dummy_app/Views/pages/popular_view/popularnews_view.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';
import 'package:dummy_app/Views/widgets/category_avatar_widget.dart';
import 'package:dummy_app/Views/widgets/category_widget_reg.dart';
import 'package:dummy_app/Views/widgets/category_widget_sp.dart';
import 'package:dummy_app/Views/widgets/categorygrid_widget_reg.dart';

import 'package:dummy_app/Views/widgets/categorygrid_widget_sp.dart';
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
        ),
        body: (_selectedNavIndex != 3)
            ? FutureBuilder(
                future: homepageController.loadAllSpItems(),
                builder: (ctx, homePageSnapShot) {
                  return (homePageSnapShot.connectionState ==
                          ConnectionState.waiting)
                      ? const LoaderWidget()
                      : _NavViews(photoController, _scrollController,
                          homepageController)[_selectedNavIndex];
                })
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
            CategoryWidgetSpecial(
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

            CategoryGridWidgetSpecial(
              dhakaprokashModels: homepageController.Items.sublist(5),
              categoryName: "More",
              itemCount: 6,
              didAxisHorizontal: false,
              crossAxisCount: 2,
              didDescriptionShow: false,
              isScroll: false,
              elevation: 0,
            ),

            //national

            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.nationalCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "National",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),

            //politics
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.politicsCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Politics",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //economics
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.ecomonomicsCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Economics",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //international
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.internationalCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "International",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //health
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.crimeCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Crime",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //sports
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.sportsCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Sports",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //entertainment
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.entertainmentCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Entertainment",
                                didMoreButtonShow: false,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: true)
                            : SizedBox.shrink()),

//lifestyle
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.lifeStyleCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Lifestyle",
                                itemCount: 4,
                                didAxisHorizontal: true,
                                crossAxisCount: 1,
                                didDescriptionShow: true,
                                isScroll: true,
                                elevation: 5,
                                itemHeight: 0.4,
                              )
                            : SizedBox.shrink()),
            //saradesh
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.saradeshCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Saradesh",
                                itemCount: 6,
                                didAxisHorizontal: false,
                                crossAxisCount: 2,
                                didDescriptionShow: false,
                                isScroll: false,
                                elevation: 0,
                                itemHeight: 0.23,
                              )
                            : SizedBox.shrink()),

            //Court Law
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.courtLawLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Court Law",
                                itemCount: 4,
                                didAxisHorizontal: true,
                                crossAxisCount: 1,
                                didDescriptionShow: true,
                                isScroll: true,
                                elevation: 5,
                                itemHeight: 0.4,
                              )
                            : SizedBox.shrink()),
            //career
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.careerCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Career",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //campus
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.campusCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Campus",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //health
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.healthCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "Health",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),

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
            /*  CategoryGridWidget(
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
            ), */
            //tab widget

            //sports
            /* CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Sports",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ), */
            //national news
            /* CategoryWidget(
              photoModels: phController.Items,
              categoryName: "National News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ), */
            //international news
            /* CategoryWidget(
              photoModels: phController.Items,
              categoryName: "International News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: false,
            ), */

            //bindon special widget
            /* CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Entertainment",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 4,
              didFloat: true,
            ), */

            //life style
            /*  CategoryGridWidget(
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
            ), */
            //motamot special widget

            /*   CategoryAvatatarWidget(
                photoModels: phController.Items,
                categoryName: "Opinion/Editorial",
                didMoreButtonShow: true,
                listItemLength: 5), */

            /*  CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Business",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ), */
            //video section
            /*  CategoryGridWidget(
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
            ), */
            // education
            /*  CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Education",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ), */
            //job
            /* CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Job",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ), */
            //science
            /*  CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Technology",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ), */
            // gadgets
            /*    CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Gadgets",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ), */
            //onno alo

            //dur porobash
            /*  CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Dur Porobash",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ), */
            //nagorik shongbad
            /*   CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Nagorik News",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 2,
              didFloat: false,
            ), */
            //Religion
            /*  CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Religion",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ), */
            // Health
            /*  CategoryWidget(
              photoModels: phController.Items,
              categoryName: "Health",
              didMoreButtonShow: true,
              didHeadSectionShow: true,
              listItemLength: 3,
              didFloat: false,
            ), */
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