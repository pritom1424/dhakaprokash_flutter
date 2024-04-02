import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';

import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/categories_view/category_video_view.dart';

import 'package:dummy_app/Views/pages/contact_view/contact_view.dart';
import 'package:dummy_app/Views/pages/custom_appdrawer.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/my%20app/myapp_view.dart';
import 'package:dummy_app/Views/pages/popular_view/popularnews_view.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/category_photo_grid_widget.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_video_grid_widget.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_sp.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_reg.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_sp.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/categoryvideo_widget.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:dummy_app/Views/widgets/navbar_widget.dart';
import 'package:dummy_app/database/database_helper.dart';

import 'package:flutter/material.dart';

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

  List<Widget> _NavViews() {
    _showScrollToTop = false;
    return [
      homeBaseWidget(),
      PopularNewsView(),
      CategoryVideoView(),
      FavoritesNewsView(),
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
    return Scaffold(
        floatingActionButton: (_selectedNavIndex == 0)
            ? ValueListenableBuilder(
                valueListenable: _scrollOffset,
                builder: (ctx, offset, _) => Visibility(
                  visible: _showScrollToTop,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: AppColors.logoColorDeep,
                    foregroundColor: Colors.white,
                    elevation: 10,
                    onPressed: () {
// Scroll to the top logic here
                      _scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Icon(
                      size: 40,
                      Icons.arrow_upward,
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: (_selectedNavIndex == 0)
            ? FloatingActionButtonLocation.endFloat
            : null,
        appBar: (_selectedNavIndex != 6) ? AppbarDefault() : null,
        drawer: CustomAppDrawer(), //AppDrawer(),
        onDrawerChanged: (isOpened) {
          if (isOpened) {
            GenericVars.isAppdrawerGlow = true;
          } else {
            GenericVars.isAppdrawerGlow = false;
          }
        },
//navigation bar
        bottomNavigationBar: NavBarWidget(
          currentIndex: _selectedNavIndex,
          onTap: _onNavigationTap,
        ),
        body: _NavViews()[_selectedNavIndex]);
  }

  Widget homeBaseWidget() {
    HomepageController homepageController =
        Provider.of<HomepageController>(context);
    var bookmarkController =
        Provider.of<BookmarkController>(context, listen: false);
    return FutureBuilder(
        future: bookmarkController.getFromList(),
        builder: (context, snap) {
          return FutureBuilder(
              future: homepageController.loadAllSpItems(),
              builder: (ctx, homePageSnapShot) {
                return (homePageSnapShot.connectionState ==
                        ConnectionState.waiting)
                    ? const LoaderWidget()
                    : (homePageSnapShot.hasData)
                        ? Scrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            //main section started
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              controller: _scrollController,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(children: [
                                  CategoryWidgetSpecial(
                                      dhakaprokashModels:
                                          homepageController.Items,
                                      categoryName: 'সর্বশেষ',
                                      didMoreButtonShow: false,
                                      didHeadSectionShow: true,
                                      listItemLength: 5,
                                      didFloat: false),

                                  /* CategoryVideoWidget(
                                    didPause: Provider.of<VideoProvider>(context)
                                        .IsVideoPause,
                                    dhakaprokashModels: homepageController.Items,
                                    categoryName: "ভিজ্যুয়াল মিডিয়া",
                                    didMoreButtonShow: false,
                                    didHeadSectionShow: true,
                                    listItemLength: 5,
                                    didFloat: false), */
                                  CategoryVideoGridWidget(
                                      itemCount:
                                          GenericVars.getVideoData.length,
                                      didAxisHorizontal: true,
                                      crossAxisCount: 1,
                                      didDescriptionShow: true,
                                      isScroll: true,
                                      elevation: 5),

                                  CategoryGridWidgetSpecial(
                                    dhakaprokashModels:
                                        homepageController.Items.sublist(5),
                                    categoryName: "সর্বশেষ",
                                    itemCount: 6,
                                    didAxisHorizontal: false,
                                    crossAxisCount: 2,
                                    didDescriptionShow: false,
                                    isScroll: false,
                                    elevation: 0,
                                  ),

                                  //national

                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.nationalCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "জাতীয়",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),

                                  //politics
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.politicsCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "রাজনীতি",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //economics
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .ecomonomicsCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "অর্থনীতি",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //international
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .internationalCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "সারাবিশ্ব",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //health
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .specialReportCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName:
                                                          "বিশেষ প্রতিবেদন",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //sports
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.sportsCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "খেলা",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //entertainment
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .entertainmentCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "বিনোদন",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //photo gallery
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllPhotoItems(),
                                      builder: (ctx, snap) => (snap
                                                  .connectionState ==
                                              ConnectionState.waiting)
                                          ? LoaderWidget()
                                          : (snap.hasData)
                                              ? CategoryPhotoGridWidget(
                                                  itemCount: snap.data!.length,
                                                  dhakaprokashModels:
                                                      snap.data!,
                                                  didAxisHorizontal: true,
                                                  crossAxisCount: 1,
                                                  didDescriptionShow: true,
                                                  isScroll: true,
                                                  elevation: 5)
                                              : SizedBox.shrink()),

                                  //saradesh
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.saradeshCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryGridWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "সারাদেশ",
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
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.courtLawLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryGridWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "আইন আদালত",
                                                      itemCount: 4,
                                                      didAxisHorizontal: true,
                                                      crossAxisCount: 1,
                                                      didDescriptionShow: true,
                                                      isScroll: true,
                                                      elevation: 5,
                                                      itemHeight: 0.4,
                                                    )
                                                  : SizedBox.shrink()),
                                  //crime
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.crimeCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "অপরাধ",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),

                                  //lifestyle
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .lifeStyleCategoryLink),
                                      builder: (ctx, snap) => (snap
                                                  .connectionState ==
                                              ConnectionState.waiting)
                                          ? LoaderWidget()
                                          : (snap.hasData)
                                              ? CategoryGridWidgetRegular(
                                                  dhakaprokashModels:
                                                      snap.data!,
                                                  categoryName: "লাইফস্টাইল",
                                                  itemCount: 4,
                                                  didAxisHorizontal: true,
                                                  crossAxisCount: 1,
                                                  didDescriptionShow: true,
                                                  isScroll: true,
                                                  elevation: 5,
                                                  itemHeight: 0.4,
                                                )
                                              : SizedBox.shrink()),
                                  //religion
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.religionCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "ধর্ম",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //health
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.healthCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryGridWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "স্বাস্থ্য",
                                                      itemCount: 4,
                                                      didAxisHorizontal: false,
                                                      crossAxisCount: 2,
                                                      didDescriptionShow: false,
                                                      isScroll: false,
                                                      elevation: 0,
                                                      itemHeight: 0.23,
                                                    )
                                                  : SizedBox.shrink()),
                                  //education
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .educationCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "শিক্ষা",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //art-culture
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.artCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName:
                                                          "শিল্প-সংস্কৃতি",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 4,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),

                                  //science-tech
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .scinenceTechCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryGridWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName:
                                                          "বিজ্ঞান-তথ্যপ্রযুক্তি",
                                                      itemCount: 4,
                                                      didAxisHorizontal: false,
                                                      crossAxisCount: 2,
                                                      didDescriptionShow: false,
                                                      isScroll: false,
                                                      elevation: 0,
                                                      itemHeight: 0.23,
                                                    )
                                                  : SizedBox.shrink()),

                                  //career
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.careerCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "ক্যারিয়ার",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 5,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //campus
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.campusCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "ক্যাম্পাস",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 3,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //child
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.childCategoryLink),
                                      builder: (ctx, snap) => (snap
                                                  .connectionState ==
                                              ConnectionState.waiting)
                                          ? LoaderWidget()
                                          : (snap.hasData)
                                              ? CategoryWidgetRegular(
                                                  dhakaprokashModels:
                                                      snap.data!,
                                                  categoryName: "শিশু-কিশোর",
                                                  didMoreButtonShow: true,
                                                  didHeadSectionShow: true,
                                                  listItemLength: 3,
                                                  didFloat: false)
                                              : SizedBox.shrink()),
                                  //motivation
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .motivationCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "মোটিভেশন",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 3,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //prbash
                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.probashCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "প্রবাস",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 3,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //corporate
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .corporateCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "কর্পোরেট",
                                                      didMoreButtonShow: true,
                                                      didHeadSectionShow: true,
                                                      listItemLength: 3,
                                                      didFloat: false)
                                                  : SizedBox.shrink()),
                                  //literature
                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .literatureCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryGridWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "সাহিত্য",
                                                      itemCount: 4,
                                                      didAxisHorizontal: false,
                                                      crossAxisCount: 2,
                                                      didDescriptionShow: false,
                                                      isScroll: false,
                                                      elevation: 0,
                                                      itemHeight: 0.23,
                                                    )
                                                  : SizedBox.shrink()),
                                  //motamot

                                  FutureBuilder(
                                      future:
                                          homepageController.loadAllRegItems(
                                              ApiConstant.opinionCategoryLink),
                                      builder: (ctx, snap) =>
                                          (snap.connectionState ==
                                                  ConnectionState.waiting)
                                              ? LoaderWidget()
                                              : (snap.hasData)
                                                  ? CategoryGridWidgetRegular(
                                                      dhakaprokashModels:
                                                          snap.data!,
                                                      categoryName: "মতামত",
                                                      itemCount: 4,
                                                      didAxisHorizontal: true,
                                                      crossAxisCount: 1,
                                                      didDescriptionShow: true,
                                                      isScroll: true,
                                                      elevation: 5,
                                                      itemHeight: 0.4,
                                                    )
                                                  : SizedBox.shrink()),

                                  //special article

                                  FutureBuilder(
                                      future: homepageController
                                          .loadAllRegItems(ApiConstant
                                              .specialArticleCategoryLink),
                                      builder: (ctx, snap) => (snap
                                                  .connectionState ==
                                              ConnectionState.waiting)
                                          ? LoaderWidget()
                                          : (snap.hasData)
                                              ? CategoryWidgetRegular(
                                                  dhakaprokashModels:
                                                      snap.data!,
                                                  categoryName: "বিশেষ নিবন্ধ",
                                                  didMoreButtonShow: true,
                                                  didHeadSectionShow: true,
                                                  listItemLength: 3,
                                                  didFloat: false)
                                              : SizedBox.shrink()),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: HomePageFooter(),
                                  )
                                ]),
                              ),
                            ),
                          )
                        : Center(
                            child:
                                Text("কোনো তথ্য নেই! একটু পর আবার চেষ্টা করুন"),
                          );
              });
        });
  }
}
