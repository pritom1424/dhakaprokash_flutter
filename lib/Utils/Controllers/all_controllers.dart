import 'package:dummy_app/Controllers/bookmark_controller.dart';
import 'package:dummy_app/Controllers/category_controller.dart';
import 'package:dummy_app/Controllers/detailpage_controller.dart';
import 'package:dummy_app/Controllers/homepage_controller.dart';
import 'package:dummy_app/Controllers/login_controller.dart';
import 'package:dummy_app/Controllers/recent_page_controller.dart';
import 'package:dummy_app/Controllers/registration_controller.dart';
import 'package:dummy_app/Controllers/searchpage_controller.dart';
import 'package:dummy_app/Controllers/video_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryViewController =
    ChangeNotifierProvider<CategoryViewController>((ref) {
  return CategoryViewController();
});

final detailPageController =
    ChangeNotifierProvider<DetailPageController>((ref) {
  return DetailPageController();
});

final homepageController = ChangeNotifierProvider<HomepageController>((ref) {
  return HomepageController();
});

final videoController = ChangeNotifierProvider<VideoProvider>((ref) {
  return VideoProvider();
});

final recentPageController =
    ChangeNotifierProvider<RecentPageController>((ref) {
  return RecentPageController();
});

final searchController = ChangeNotifierProvider<SearchPageController>((ref) {
  return SearchPageController();
});
final bookmarkController = ChangeNotifierProvider<BookmarkController>((ref) {
  return BookmarkController();
});
final loginController = ChangeNotifierProvider<LoginProvider>((ref) {
  return LoginProvider();
});
final registrationController =
    ChangeNotifierProvider<RegistrationProvider>((ref) {
  return RegistrationProvider();
});
