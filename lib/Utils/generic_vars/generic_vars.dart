import 'package:dummy_app/Utils/api_constants.dart';
import 'package:flutter/cupertino.dart';
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
    "সর্বশেষ": null,
    "জাতীয়": 'national',
    "রাজনীতি": 'politics',
    "অর্থনীতি": 'economy',
    "সারাদেশ": 'saradesh',
    "সারাবিশ্ব": 'international',
    "খেলা": 'sports',
    "বিনোদন": 'entertainment',
    "লাইফস্টাইল": 'lifestyle',
    "স্বাস্থ্য": 'health',
    "সাহিত্য": 'literature',
    "শিক্ষা": 'education',
    "বিশেষ প্রতিবেদন": 'special-report',
    "ভিজ্যুয়াল মিডিয়া": null,
    "মতামত": 'opinion',
    "ক্যারিয়ার": 'career',
    "ধর্ম": 'religion',

    "শিল্প-সংস্কৃতি": 'art-culture',
    "বিজ্ঞান-তথ্যপ্রযুক্তি": 'technology',
    "সরেজমিন": 'sorejomin',
    "টিভি লাইভ": 'tv-live',

    "অপরাধ": 'crime',

    "ইতিহাস-ঐতিহ্য": 'history-tradition',
    "সোশ্যাল মিডিয়া": 'social-media',
    "পাঠকের কথা": 'readers-talk',
    "পরিবেশ জলবায়ু": 'environment-climate',
    "রাশিফল": 'horoscope',
    "আইন আদালত": 'law-court',
    "পর্যটন": 'tourism',
    "গণমাধ্যম": 'mass-media',
    "ফিচার": 'feature',
    "কৃষি": 'agriculture',
    "প্রবাস": 'probash',
    "ক্যাম্পাস": 'campus',
    "রাজধানী": 'capital',
    "হৃদয়ের জানালা": 'ridoyer-janala',
    "শুভেচ্ছা বার্তা": 'greetings',
    "বিশেষ নিবন্ধ": 'bishesh-nibondho',
    "সাক্ষাৎকার": 'interview',
    "কর্পোরেট": 'corporate',
    "মুক্তিযুদ্ধ": 'liberation-war',
    "শিশু-কিশোর": 'child-adolescent',
    "মোটিভেশন": 'motivation',
    //not in category
    "ফটো গ্যালারি": ApiConstant.photoGalleryCategoryLink,
    "স্পেশাল টপ": ApiConstant.homePageSpecialContentLink,
    // "Recent News": Icons.access_time,
  };

  static Map<String, String?> deskbarLink = {
    "ঢাকাপ্রকাশ ডেস্ক": null,
    "নিজস্ব প্রতিনিধি": null,
    "সারাবিশ্ব ডেস্ক": null,
    "স্পোর্টস ডেস্ক": null,
    "বিনোদন ডেস্ক": null,
    "নিজস্ব প্রতিবেদক": null,
    "তথ্যপ্রযুক্তি ডেস্ক": null,
    "সারাদেশ ডেস্ক": null,
  };
  static String currentSearchString = "";
  static String currenFontFamily = "Kalpurush"; //"Shurjo-un-regular";
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

  static bool isAppdrawerGlow = false;

  static Map<String, String> tabLinks = {
    "সর্বশেষ": ApiConstant.homeLatestPostLink,
    "জনপ্রিয়": ApiConstant.homePopularPostLink,
  };

  static double currentRootOffset = 0;
}
//পর্যটন