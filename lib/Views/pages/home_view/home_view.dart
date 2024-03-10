import 'package:dummy_app/Controllers/photo_controller.dart';
import 'package:dummy_app/Controllers/post_controller.dart';
import 'package:dummy_app/Utils/generic_vars/generic_vars.dart';
import 'package:dummy_app/Views/pages/app_drawer.dart';
import 'package:dummy_app/Views/pages/favorites_view/favoritesnews_view.dart';
import 'package:dummy_app/Views/pages/latest_view/latestnews_view.dart';
import 'package:dummy_app/Views/pages/popular_view/popularnews_view.dart';
import 'package:dummy_app/Views/widgets/category_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/headimage_widget.dart';
import 'package:dummy_app/Views/widgets/home_view/recentcategoryhome_widget.dart';
import 'package:dummy_app/Views/widgets/homepage_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      )
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
                  label: 'favorites')
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
                  builder: (ctx, postSnapShot) {
                    return (postSnapShot.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            //main news + headline
            Container(
              width: double.infinity,
              height: GenericVars.scSize.height * 0.4,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: HeadImageWidget(
                  title: pcontroller.Items[0].title,
                  url: phController.Items[0].url),
            ),
            //Recent news Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: RecentCategoryHomeWidget(
                categoryName: "Recent",
                photoModels: phController.Items,
                postModels: pcontroller.Items,
              ),
            ),

            //Category News List
            Column(
              children: List.generate(
                GenericVars.newspaperCategories.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: CategoryWidget(
                    categoryName: GenericVars.newspaperCategories[index],
                    photoModels: phController.Items,
                    postModels: pcontroller.Items,
                    listHeight: 0.33,
                    didMoreButtonShow: true,
                  ),
                ),
              ),
            ),

            HomePageFooter()
          ]),
        ),
      ),
    );
  }
}
