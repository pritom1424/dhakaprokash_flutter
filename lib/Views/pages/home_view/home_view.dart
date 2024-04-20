import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';

import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Utils/app_colors.dart';
import 'package:dummy_app/Utils/generic_methods/dateformatter.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Utils/scroll_controller.dart';
import 'package:dummy_app/Views/pages/categories_view/category_video_view.dart';

import 'package:dummy_app/Views/pages/contact_view/contact_view.dart';
import 'package:dummy_app/Views/pages/custom_appdrawer.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/my%20app/myapp_view.dart';
import 'package:dummy_app/Views/pages/latest_view/latestnews_view.dart';
import 'package:dummy_app/Views/pages/searchtoNewpage.dart';

import 'package:dummy_app/Views/widgets/app_bar.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/category_photo_grid_widget.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_tab_widget.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_video_grid_widget.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_reg.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/category_widget_sp.dart';
import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_reg.dart';

import 'package:dummy_app/Views/widgets/cat_widgets/categorygrid_widget_sp.dart';

//import 'package:dummy_app/Views/widgets/cat_widgets/categoryvideo_widget.dart';

import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:dummy_app/Views/widgets/loader_widget.dart';

import 'package:dummy_app/Views/widgets/navbar_widget.dart';
import 'package:dummy_app/database/database_helper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:dummy_app/Views/pages/categories_view/categorywise_video_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;
  bool _showScrollToTop = false;
  late ScrollController _scrollController;
  late ScrollController _scrollController1;

  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0.0);
  late TabController tabController;
  bool didNavButtonGlow = false;
  final tabBarItem = 5;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double _lastScrollOffset = 100;

  // List<Widget> _navViewsNew(HomepageController homepageController,
  //     ScrollController scrollController) {
  //   return [homeBaseWidgetCopy(homepageController, scrollController)];
  // }

  List<Widget> _NavViews() {
    _showScrollToTop = false;
    return [
      homeBaseWidgetVer2(),
      LatestNewsView(),
      CategryWiseVideo(),
      //CategoryVideoView(),
      FavoritesNewsView(),
      SearchToNewPage(),
      //  ContactView(),
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
    _scrollController1 = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(_updateScrollOffset);
    //_scrollController1.addListener(_scrollListener);
    _showScrollToTop = false;
    tabController = TabController(length: 2, vsync: this);
    var bookmarkController =
        Provider.of<BookmarkController>(context, listen: false);
    bookmarkController.getFromList();
    Provider.of<HomepageController>(context, listen: false).loadAllPhotoItems();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    tabController.dispose();
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
    //_scrollListener();
    // _scrollListener();
    //ScrollControl().customscrollListener(_scrollController, 20000);
  }

  void _scrollListener() {
    double currentScrollOffset = _scrollController.offset;
    if (currentScrollOffset <= _lastScrollOffset) {
      _slowScrollDown(_lastScrollOffset);
    } else {
      _lastScrollOffset = currentScrollOffset;
      _lastScrollOffset += 300;
    }
  }

  void _slowScrollDown(double _lastScOffset) {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (_lastScOffset > maxScrollExtent) {
      _lastScOffset = maxScrollExtent;
    } else {
      _scrollController.animateTo(
        _lastScOffset,
        duration: Duration(milliseconds: 50), // Adjust duration as needed
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    GenericVars.scSize = MediaQuery.of(context).size;

    print(
        "currentNumber:${Provider.of<HomepageController>(context, listen: false).photoShowNumber}");
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          floatingActionButton: (_selectedNavIndex == 0)
              ? ValueListenableBuilder(
                  valueListenable: _scrollOffset,
                  builder: (ctx, offset, _) => Visibility(
                    visible: _showScrollToTop,
                    child: FloatingActionButton(
                      mini: true,
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
                        size: 30,
                        Icons.arrow_upward,
                      ),
                    ),
                  ),
                )
              : null,
          floatingActionButtonLocation: (_selectedNavIndex == 0)
              ? FloatingActionButtonLocation.endFloat
              : null,
          appBar: (_selectedNavIndex != 5)
              ? AppBar(
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        // Scaffold.of(context).openDrawer();
                        scaffoldKey.currentState!.openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                      icon: Icon(
                        Icons.menu,
                        size: 32,
                        // color: Colors.red,
                      )),
                  title: Container(
                    width: GenericVars.scSize.width * 0.45,
                    /*  decoration: BoxDecoration(boxShadow: [
        BoxShadow(
        color: Colors.black.withOpacity(0.075),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
        blurStyle: BlurStyle.normal // changes position of shadow
        ),
      ]), */
                    child: Image.asset(
                      "assets/images/dhakaprokash_logo.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  /* bottom: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 0.1),
        child: DigitalClockWidget()), */
                  actions: [
                    // Notification Icon
                    Badge(
                      largeSize: 13,
                      label: Text(
                        "0",
                        style: TextStyle(fontSize: 10),
                      ),
                      offset: Offset(-12, 6),
                      child: IconButton(
                        icon: const Icon(
                          size: 23,
                          CupertinoIcons.bell,
                          // Icons.notifications_none_outlined,
                          color: AppColors.logoColorDeep,
                        ),
                        onPressed: () {
                          // Handle notification icon tap
                        },
                      ),
                    ),
                  ],
                )
              : null,
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
          body: _NavViews()[_selectedNavIndex]),
    );
  }

  Widget homeBaseWidget() {
    HomepageController homepageController =
        Provider.of<HomepageController>(context);

    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      //main section started
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            FutureBuilder(
                future: homepageController.loadAllSpItems(),
                builder: (ctx, homePageSnapShot) {
                  return (homePageSnapShot.connectionState ==
                          ConnectionState.waiting)
                      ? const LoaderWidget()
                      : (homePageSnapShot.hasData)
                          ? CategoryWidgetSpecial(
                              dhakaprokashModels: homepageController.Items,
                              categoryName: 'সর্বশেষ',
                              didMoreButtonShow: false,
                              didHeadSectionShow: true,
                              listItemLength: 5,
                              didFloat: false)
                          : SizedBox.shrink();
                  /*  
                          const Center(
                              child: Text(
                                  "কোনো তথ্য নেই! একটু পর আবার চেষ্টা করুন"),
                            ); */
                }),

            /* CategoryVideoWidget(
                                    didPause: Provider.of<VideoProvider>(context)
                                        .IsVideoPause,
                                    dhakaprokashModels: homepageController.Items,
                                    categoryName: "ভিজ্যুয়াল মিডিয়া",
                                    didMoreButtonShow: false,
                                    didHeadSectionShow: true,
                                    listItemLength: 5,
                                    didFloat: false), */
            /*   CategoryVideoGridWidget(
                itemCount: GenericVars.getVideoData.length,
                didAxisHorizontal: true,
                crossAxisCount: 1,
                didDescriptionShow: true,
                isScroll: true,
                elevation: 5), */

            TabBar(controller: tabController, isScrollable: false, tabs: const [
              Tab(
                icon: Text('সর্বশেষ'),
              ),
              Tab(
                icon: Text('জনপ্রিয়'),
              )
            ]),
            Container(
              height: GenericVars.scSize.height * tabBarItem * (0.09) +
                  GenericVars.scSize.height * 0.09,
              child: TabBarView(controller: tabController, children: [
                FutureBuilder(
                    future: homepageController.loadAllRegTabItemsPost(
                        ApiConstant.homeLatestPostLink, tabBarItem),
                    builder: (ctx, snap) =>
                        (snap.connectionState == ConnectionState.waiting)
                            ? LoaderWidget()
                            : (snap.hasData)
                                ? CategoryTabWidget(
                                    dhakaProkashModels: snap.data!,
                                    catName: "সর্বশেষ",
                                    itemNumber: tabBarItem,
                                  )
                                : SizedBox.shrink()),
                FutureBuilder(
                    future: homepageController.loadAllRegTabItemsPost(
                        ApiConstant.homePopularPostLink, tabBarItem),
                    builder: (ctx, snap) =>
                        (snap.connectionState == ConnectionState.waiting)
                            ? LoaderWidget()
                            : (snap.hasData)
                                ? CategoryTabWidget(
                                    dhakaProkashModels: snap.data!,
                                    catName: "জনপ্রিয়",
                                    itemNumber: tabBarItem,
                                  )
                                : SizedBox.shrink()),
              ]),
            ),

            CategoryGridWidgetSpecial(
              didHeadSectionShow: false,
              dhakaprokashModels: homepageController.Items.sublist(5),
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
                future: homepageController
                    .loadAllRegItems(ApiConstant.nationalCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "জাতীয়",
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
                                categoryName: "রাজনীতি",
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
                                categoryName: "অর্থনীতি",
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
                                categoryName: "সারাবিশ্ব",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //health
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.specialReportCategoryLink),
                builder: (ctx, snap) => (snap.connectionState ==
                        ConnectionState.waiting)
                    ? LoaderWidget()
                    : (snap.hasData)
                        ? CategoryWidgetRegular(
                            dhakaprokashModels: snap.data!,
                            categoryName: "বিশেষ প্রতিবেদন",
                            didMoreButtonShow: true,
                            didHeadSectionShow: true,
                            listItemLength: 4,
                            didFloat: false,
                            bariconColor: AppColors.logoColorDeep,
                            bartextColor: AppColors.defaultCategoryBarIconColor,
                          )
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
                                categoryName: "খেলা",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 5,
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
                                categoryName: "বিনোদন",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 5,
                                didFloat: false)
                            : SizedBox.shrink()),
            //photo gallery
            FutureBuilder(
                future: homepageController.loadAllPhotoItems(),
                builder: (ctx, snap) {
                  return (snap.connectionState == ConnectionState.waiting)
                      ? LoaderWidget()
                      : (snap.hasData)
                          ? CategoryPhotoGridWidget(
                              scrollController: _scrollController,
                              totalPhotoItems: snap.data!.length,
                              dhakaprokashModels: snap.data!,
                              didAxisHorizontal: false,
                              crossAxisCount: 2,
                              didDescriptionShow: false,
                              isScroll: false,
                              itemHeight: 0.23,
                              elevation: 0)
                          : SizedBox.shrink();
                }),

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
                future: homepageController
                    .loadAllRegItems(ApiConstant.courtLawLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "আইন আদালত",
                                itemCount: 5,
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
                future: homepageController
                    .loadAllRegItems(ApiConstant.crimeCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "অপরাধ",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
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
                                categoryName: "লাইফস্টাইল",
                                itemCount: 5,
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
                future: homepageController
                    .loadAllRegItems(ApiConstant.religionCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "ধর্ম",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
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
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
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
                    .loadAllRegItems(ApiConstant.educationCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "শিক্ষা",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),
            //art-culture
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.artCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "শিল্প-সংস্কৃতি",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 4,
                                didFloat: false)
                            : SizedBox.shrink()),

            //science-tech
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.scinenceTechCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "বিজ্ঞান-তথ্যপ্রযুক্তি",
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
                future: homepageController
                    .loadAllRegItems(ApiConstant.careerCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "ক্যারিয়ার",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 5,
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
                                categoryName: "ক্যাম্পাস",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //child
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.childCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "শিশু-কিশোর",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //motivation
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.motivationCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "মোটিভেশন",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //prbash
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.probashCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "প্রবাস",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //corporate
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.corporateCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "কর্পোরেট",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),
            //literature
            FutureBuilder(
                future: homepageController
                    .loadAllRegItems(ApiConstant.literatureCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
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
                future: homepageController
                    .loadAllRegItems(ApiConstant.opinionCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryGridWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "মতামত",
                                itemCount: 5,
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
                    .loadAllRegItems(ApiConstant.specialArticleCategoryLink),
                builder: (ctx, snap) =>
                    (snap.connectionState == ConnectionState.waiting)
                        ? LoaderWidget()
                        : (snap.hasData)
                            ? CategoryWidgetRegular(
                                dhakaprokashModels: snap.data!,
                                categoryName: "বিশেষ নিবন্ধ",
                                didMoreButtonShow: true,
                                didHeadSectionShow: true,
                                listItemLength: 3,
                                didFloat: false)
                            : SizedBox.shrink()),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: HomePageFooter(),
            )
          ]),
        ),
      ),
    );
  }

  Widget homeBaseWidgetVer2() {
    HomepageController homepageController =
        Provider.of<HomepageController>(context);

    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      //main section started
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        physics: ScrollPhysics(),
        child: FutureBuilder(
          future: homepageController.loadAllSpItems(),
          builder: (ctx, homeSpSnapShot) => (homeSpSnapShot.connectionState ==
                  ConnectionState.waiting)
              ? Container(
                  height: GenericVars.scSize.height * 0.8,
                  width: double.infinity,
                  child: Center(child: LoaderWidget()))
              : (homeSpSnapShot.hasData)
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(children: [
                        CategoryWidgetSpecial(
                            dhakaprokashModels: homepageController.Items,
                            categoryName: 'স্পেশাল টপ',
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
                        FutureBuilder(
                          future: homepageController.loadHomeVideosPost(10),
                          builder: (ctx, snap) =>
                              (snap.connectionState == ConnectionState.waiting)
                                  ? LoaderWidget()
                                  : CategoryVideoGridWidget(
                                      ids: snap.data!,
                                      itemHeight: 0.32,
                                      itemCount: 5,
                                      didAxisHorizontal: true,
                                      crossAxisCount: 1,
                                      didDescriptionShow: true,
                                      isScroll: true,
                                      elevation: 5,
                                      ratio: 3 / 4,
                                    ),
                        ),

                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 0.3, color: Colors.grey),
                                  left: BorderSide(
                                      width: 0.3, color: Colors.grey),
                                  right: BorderSide(
                                      width: 0.3, color: Colors.grey))),
                          child: TabBar(
                              controller: tabController,
                              isScrollable: false,
                              tabs: const [
                                Tab(
                                  icon: Text('সর্বশেষ'),
                                ),
                                Tab(
                                  icon: Text('জনপ্রিয়'),
                                )
                              ]),
                        ),
                        Container(
                          height:
                              GenericVars.scSize.height * tabBarItem * (0.09) +
                                  GenericVars.scSize.height * 0.09,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.3, color: Colors.grey)),
                          child:
                              TabBarView(controller: tabController, children: [
                            FutureBuilder(
                                future:
                                    homepageController.loadAllRegTabItemsPost(
                                        ApiConstant.homeLatestPostLink,
                                        tabBarItem),
                                builder: (ctx, snap) => (snap.connectionState ==
                                        ConnectionState.waiting)
                                    ? LoaderWidget()
                                    : (snap.hasData)
                                        ? CategoryTabWidget(
                                            dhakaProkashModels: snap.data!,
                                            catName: GenericVars.tabNames[0],
                                            itemNumber: tabBarItem,
                                          )
                                        : SizedBox.shrink()),
                            FutureBuilder(
                                future:
                                    homepageController.loadAllRegTabItemsPost(
                                        ApiConstant.homePopularPostLink,
                                        tabBarItem),
                                builder: (ctx, snap) => (snap.connectionState ==
                                        ConnectionState.waiting)
                                    ? LoaderWidget()
                                    : (snap.hasData)
                                        ? CategoryTabWidget(
                                            dhakaProkashModels: snap.data!,
                                            catName: GenericVars
                                                .tabNames[1], //"জনপ্রিয়",
                                            itemNumber: tabBarItem,
                                          )
                                        : SizedBox.shrink()),
                          ]),
                        ),

                        CategoryGridWidgetSpecial(
                          didHeadSectionShow: false,
                          dhakaprokashModels:
                              homepageController.Items.sublist(5),
                          categoryName: "স্পেশাল টপ",
                          itemCount: 6,
                          didAxisHorizontal: false,
                          crossAxisCount: 2,
                          didDescriptionShow: false,
                          isScroll: false,
                          elevation: 0,
                        ),

                        //national

                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.nationalCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "জাতীয়",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),

                        //politics
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.politicsCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "রাজনীতি",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //economics
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.ecomonomicsCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "অর্থনীতি",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //international
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.internationalCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "সারাবিশ্ব",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //health
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.specialReportCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "বিশেষ প্রতিবেদন",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false,
                                        bariconColor: AppColors.logoColorDeep,
                                        bartextColor: AppColors
                                            .defaultCategoryBarIconColor,
                                      )
                                    : SizedBox.shrink()),
                        //sports
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.sportsCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "খেলা",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 5,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //entertainment
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.entertainmentCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "বিনোদন",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 5,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //photo gallery

                        homepageController.photoes.isNotEmpty &&
                                homepageController.photoes != null
                            ? CategoryPhotoGridWidget(
                                scrollController: _scrollController,
                                totalPhotoItems:
                                    homepageController.photoes.length,
                                // itemCount: Provider.of<HomepageController>(ctx, listen: false).photoShowNumber,

                                dhakaprokashModels: homepageController.photoes,
                                didAxisHorizontal: false,
                                crossAxisCount: 2,
                                didDescriptionShow: false,
                                isScroll: false,
                                itemHeight: 0.24,
                                elevation: 0)
                            : LoaderWidget(),

                        //saradesh
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.saradeshCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
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
                            future: homepageController
                                .loadAllRegItems(ApiConstant.courtLawLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "আইন আদালত",
                                        itemCount: 5,
                                        didAxisHorizontal: true,
                                        crossAxisCount: 1,
                                        didDescriptionShow: true,
                                        isScroll: true,
                                        elevation: 5,
                                        itemHeight: 0.32,
                                        ratio: 4 / 5,
                                      )
                                    : SizedBox.shrink()),
                        //crime
                        FutureBuilder(
                            future: homepageController
                                .loadAllRegItems(ApiConstant.crimeCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "অপরাধ",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),

                        //lifestyle
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.lifeStyleCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "লাইফস্টাইল",
                                        itemCount: 5,
                                        didAxisHorizontal: true,
                                        crossAxisCount: 1,
                                        didDescriptionShow: true,
                                        isScroll: true,
                                        elevation: 5,
                                        itemHeight: 0.32,
                                        ratio: 4 / 5,
                                      )
                                    : SizedBox.shrink()),
                        //religion
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.religionCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "ধর্ম",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //health
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.healthCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
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
                            future: homepageController.loadAllRegItems(
                                ApiConstant.educationCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "শিক্ষা",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //art-culture
                        FutureBuilder(
                            future: homepageController
                                .loadAllRegItems(ApiConstant.artCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "শিল্প-সংস্কৃতি",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 4,
                                        didFloat: false)
                                    : SizedBox.shrink()),

                        //science-tech
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.scinenceTechCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "বিজ্ঞান-তথ্যপ্রযুক্তি",
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
                            future: homepageController.loadAllRegItems(
                                ApiConstant.careerCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "ক্যারিয়ার",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 5,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //campus
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.campusCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "ক্যাম্পাস",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 3,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //child
                        FutureBuilder(
                            future: homepageController
                                .loadAllRegItems(ApiConstant.childCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "শিশু-কিশোর",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 3,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //motivation
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.motivationCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "মোটিভেশন",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 3,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //prbash
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.probashCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "প্রবাস",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 3,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //corporate
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.corporateCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "কর্পোরেট",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 3,
                                        didFloat: false)
                                    : SizedBox.shrink()),
                        //literature
                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.literatureCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
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
                            future: homepageController.loadAllRegItems(
                                ApiConstant.opinionCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryGridWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "মতামত",
                                        itemCount: 5,
                                        didAxisHorizontal: true,
                                        crossAxisCount: 1,
                                        didDescriptionShow: true,
                                        isScroll: true,
                                        elevation: 5,
                                        itemHeight: 0.28,
                                        ratio: 2 / 3,
                                        maxLine: 1,
                                      )
                                    : SizedBox.shrink()),

                        //special article

                        FutureBuilder(
                            future: homepageController.loadAllRegItems(
                                ApiConstant.specialArticleCategoryLink),
                            builder: (ctx, snap) => (snap.connectionState ==
                                    ConnectionState.waiting)
                                ? LoaderWidget()
                                : (snap.hasData)
                                    ? CategoryWidgetRegular(
                                        dhakaprokashModels: snap.data!,
                                        categoryName: "বিশেষ নিবন্ধ",
                                        didMoreButtonShow: true,
                                        didHeadSectionShow: true,
                                        listItemLength: 3,
                                        didFloat: false)
                                    : SizedBox.shrink()),

                        const HomePageFooter()
                      ]),
                    )
                  : Container(
                      height: GenericVars.scSize.height * 0.8,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "কোনো তথ্য পাওয়া যায় নি",
                          //style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
