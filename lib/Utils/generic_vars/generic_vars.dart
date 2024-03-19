import 'package:flutter/material.dart';

class GenericVars {
  static Size scSize = Size(600, 800);

  static Map<String, IconData> newspaperCategories = {
    "Local News": Icons.location_city,
    "National News": Icons.flag,
    "International News": Icons.public,
    "Business": Icons.business,
    "Finance": Icons.account_balance,
    "Politics": Icons.gavel,
    "Sports": Icons.sports_soccer,
    "Entertainment": Icons.movie,
    "Lifestyle": Icons.favorite,
    "Technology": Icons.computer,
    "Science": Icons.science,
    "Health": Icons.health_and_safety,
    "Opinion/Editorial": Icons.comment,
    "Education": Icons.school,
    "Weather": Icons.wb_sunny,
    // "Recent News": Icons.access_time,
  };
  static String currentSearchString = "";
  static String currenFontFamily = "NotoSerif-Regular"; //"Raleway";

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
}
//পর্যটন