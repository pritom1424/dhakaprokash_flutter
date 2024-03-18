// To parse this JSON data, do
//
//     final dhakaProkash = dhakaProkashFromJson(jsonString);

import 'dart:convert';

List<DhakaProkash> dhakaProkashFromJson(String str) => List<DhakaProkash>.from(
    json.decode(str).map((x) => DhakaProkash.fromJson(x)));

String dhakaProkashToJson(List<DhakaProkash> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaProkash {
  int? contentId;
  int? contentType;
  String? imgBgPath;
  String? contentHeading;
  dynamic contentSubHeading;
  String? contentDetails;
  String? bnCatName;
  String? catSlug;
  DateTime? createdAt;
  String? subcatSlug;

  DhakaProkash({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentSubHeading,
    required this.contentDetails,
    required this.bnCatName,
    required this.catSlug,
    required this.createdAt,
    this.subcatSlug,
  });

  factory DhakaProkash.fromJson(Map<String, dynamic> json) => DhakaProkash(
        contentId: json["content_id"],
        contentType: json["content_type"],
        imgBgPath: json["img_bg_path"],
        contentHeading: json["content_heading"],
        contentSubHeading: json["content_sub_heading"],
        contentDetails: json["content_details"],
        bnCatName: json["bn_cat_name"],
        catSlug: json["cat_slug"],
        createdAt: DateTime.parse(json["created_at"]),
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "img_bg_path": imgBgPath,
        "content_heading": contentHeading,
        "content_sub_heading": contentSubHeading,
        "content_details": contentDetails,
        "bn_cat_name": bnCatName,
        "cat_slug": catSlug,
        "created_at": createdAt!.toIso8601String(),
        "subcat_slug": subcatSlug,
      };
}
