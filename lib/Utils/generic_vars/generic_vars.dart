import 'package:dummy_app/Utils/api_constants.dart';
import 'package:dummy_app/Views/widgets/categorylist_tile.dart';
import 'package:flutter/material.dart';

class GenericVars {
  static Size scSize = Size(600, 800);

  static Map<String, IconData> newspaperCategories = {
    "সর্বশেষ": Icons.newspaper,
    "জাতীয়": Icons.flag,
    "রাজনীতি": Icons.gavel,
    "অর্থনীতি": Icons.monetization_on,
    "সারাদেশ": Icons.location_city,
    "সারাবিশ্ব": Icons.public,
    "খেলা": Icons.sports_soccer,
    "বিনোদন": Icons.movie,
    "লাইফস্টাইল": Icons.favorite,
    "স্বাস্থ্য": Icons.health_and_safety,
    "সাহিত্য": Icons.menu_book,
    "শিক্ষা": Icons.school,
    "বিশেষ প্রতিবেদন": Icons.priority_high,
    "ভিজ্যুয়াল মিডিয়া": Icons.video_camera_back,
    "মতামত": Icons.comment,
    "ক্যারিয়ার": Icons.business_center,
    "ধর্ম": Icons.mosque,

    "শিল্প-সংস্কৃতি": Icons.category,
    "বিজ্ঞান-তথ্যপ্রযুক্তি": Icons.science,
    "সরেজমিন": Icons.broadcast_on_home,
    "টিভি লাইভ": Icons.live_tv,

    "অপরাধ": Icons.dangerous,

    "ইতিহাস-ঐতিহ্য": Icons.history_edu,
    "সোশ্যাল মিডিয়া": Icons.social_distance,
    "পাঠকের কথা": Icons.drafts,
    "পরিবেশ জলবায়ু": Icons.wb_sunny,
    "রাশিফল": Icons.stars,
    "আইন আদালত": Icons.balance,
    "পর্যটন": Icons.travel_explore,
    "গণমাধ্যম": Icons.tv,
    "ফিচার": Icons.star,
    "কৃষি": Icons.agriculture,
    "প্রবাস": Icons.flight_takeoff,
    "ক্যাম্পাস": Icons.apartment,
    "রাজধানী": Icons.account_balance,
    "হৃদয়ের জানালা": Icons.favorite,
    "শুভেচ্ছা বার্তা": Icons.waving_hand,
    "বিশেষ নিবন্ধ": Icons.folder_special,
    "সাক্ষাৎকার": Icons.handshake,
    "কর্পোরেট": Icons.business,
    "মুক্তিযুদ্ধ": Icons.shield,
    "শিশু-কিশোর": Icons.child_care,
    "মোটিভেশন": Icons.lightbulb,

    // "Recent News": Icons.access_time,
  };
  static Map<String, String?> newspaperCategoriesLink = {
    "সর্বশেষ": ApiConstant.homePageSpecialContentLink,
    "জাতীয়": ApiConstant.nationalCategoryLink,
    "রাজনীতি": ApiConstant.politicsCategoryLink,
    "অর্থনীতি": ApiConstant.ecomonomicsCategoryLink,
    "সারাদেশ": ApiConstant.saradeshCategoryLink,
    "সারাবিশ্ব": ApiConstant.internationalCategoryLink,
    "খেলা": ApiConstant.sportsCategoryLink,
    "বিনোদন": ApiConstant.entertainmentCategoryLink,
    "লাইফস্টাইল": ApiConstant.lifeStyleCategoryLink,
    "স্বাস্থ্য": ApiConstant.healthCategoryLink,
    "সাহিত্য": null,
    "শিক্ষা": ApiConstant.healthCategoryLink,
    "বিশেষ প্রতিবেদন": ApiConstant.specialReportCategoryLink,
    "ভিজ্যুয়াল মিডিয়া": null,
    "মতামত": null,
    "ক্যারিয়ার": ApiConstant.careerCategoryLink,
    "ধর্ম": null,

    "শিল্প-সংস্কৃতি": ApiConstant.artCategoryLink,
    "বিজ্ঞান-তথ্যপ্রযুক্তি": null,
    "সরেজমিন": null,
    "টিভি লাইভ": null,

    "অপরাধ": ApiConstant.crimeCategoryLink,

    "ইতিহাস-ঐতিহ্য": null,
    "সোশ্যাল মিডিয়া": null,
    "পাঠকের কথা": null,
    "পরিবেশ জলবায়ু": null,
    "রাশিফল": null,
    "আইন আদালত": ApiConstant.courtLawLink,
    "পর্যটন": null,
    "গণমাধ্যম": null,
    "ফিচার": null,
    "কৃষি": null,
    "প্রবাস": null,
    "ক্যাম্পাস": null,
    "রাজধানী": null,
    "হৃদয়ের জানালা": null,
    "শুভেচ্ছা বার্তা": null,
    "বিশেষ নিবন্ধ": null,
    "সাক্ষাৎকার": null,
    "কর্পোরেট": null,
    "মুক্তিযুদ্ধ": null,
    "শিশু-কিশোর": null,
    "মোটিভেশন": null,

    // "Recent News": Icons.access_time,
  };
  static String currentSearchString = "";
  static String currenFontFamily = "Helvetica"; //"Shurjo-un-regular";
  //"SolaimanLipi"; //"Raleway"//"NotoSerif-Regular";

  static double scrollOffset = 0;

  static String currentPageVideoLink = "";
  static List<Map<String, String>> getVideoData = [
    {
      "title": "সংযমের মাসেও সংযম হারাচ্ছেনিত্যপণ্যের দাম",
      "category": "জাতীয়",
      "url": "https://youtu.be/m2G8mkNq008?si=WLrQbMPmxfkj1RrP"
    },
    {
      "title": "রমজানের ক্লান্ত দুুপুরে রাজধানীতে স্বস্তির বৃষ্টি",
      "category": "জাতীয়",
      "url": "https://youtu.be/Cjb5GBCdkOg?si=ZgjPPPJZuppgFZDV"
    },
    {
      "title": "মেট্রোরেলের নতুন সময়সূচি",
      "category": "জাতীয়",
      "url": "https://youtu.be/vt-SA67KnLY?si=4kGT_QKd-DKO_CKp"
    },
    {
      "title":
          "উৎকণ্ঠায় এমভি আব্দুল্লাহর প্রধান প্রকৌশলী সাইদুজ্জামানের পরিবার",
      "category": "জাতীয়",
      "url": "https://youtu.be/DJRtsOhU9tY?si=nWBd9J76eBaQUEpX"
    },
    {
      "title": "ইতিহাসের নিদর্শন হবিগঞ্জের শংকরপাশা শাহী মসজিদ",
      "category": "পর্যটন",
      "url": "https://youtu.be/mtNSv33biI8?si=dFrZRufrmjFSSlOl"
    },
  ];

  static List<CategoryListTile> favoritesList = [];
}
//পর্যটন