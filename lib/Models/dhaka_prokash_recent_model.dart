// To parse this JSON data, do
//
//     final dhakaProkashRecentModel = dhakaProkashRecentModelFromJson(jsonString);

import 'dart:convert';

List<DhakaProkashRecentModel> dhakaProkashRecentModelFromJson(String str) =>
    List<DhakaProkashRecentModel>.from(
        json.decode(str).map((x) => DhakaProkashRecentModel.fromJson(x)));

String dhakaProkashRecentModelToJson(List<DhakaProkashRecentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaProkashRecentModel {
  int contentId;
  int contentType;
  String imgBgPath;
  String contentHeading;
  String contentDetails;
  DateTime createdAt;
  DateTime updatedAt;
  String bnCatName;
  String catSlug;
  String? subcatSlug;

  DhakaProkashRecentModel({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.bnCatName,
    required this.catSlug,
    this.subcatSlug,
  });

  factory DhakaProkashRecentModel.fromJson(Map<String, dynamic> json) =>
      DhakaProkashRecentModel(
        contentId: json["content_id"],
        contentType: json["content_type"],
        imgBgPath: json["img_bg_path"],
        contentHeading: json["content_heading"],
        contentDetails: json["content_details"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bnCatName: json["bn_cat_name"],
        catSlug: json["cat_slug"],
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "img_bg_path": imgBgPath,
        "content_heading": contentHeading,
        "content_details": contentDetails,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "bn_cat_name": bnCatName,
        "cat_slug": catSlug,
        "subcat_slug": subcatSlug,
      };
}
