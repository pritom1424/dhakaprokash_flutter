// To parse this JSON data, do
//
//     final dhakaProkashRegularModel = dhakaProkashRegularModelFromJson(jsonString);

import 'dart:convert';

List<DhakaProkashRegularModel> dhakaProkashRegularModelFromJson(String str) =>
    List<DhakaProkashRegularModel>.from(
        json.decode(str).map((x) => DhakaProkashRegularModel.fromJson(x)));

String dhakaProkashRegularModelToJson(List<DhakaProkashRegularModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaProkashRegularModel {
  int? contentId;
  int? contentType;
  String? imgBgPath;
  String? contentHeading;
  String? contentDetails;
  String? bnCatName;
  String? catSlug;
  String? subcatSlug;
  DateTime? createdAt;

  DhakaProkashRegularModel({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentDetails,
    required this.bnCatName,
    required this.catSlug,
    required this.subcatSlug,
    required this.createdAt,
  });

  factory DhakaProkashRegularModel.fromJson(Map<String, dynamic> json) =>
      DhakaProkashRegularModel(
        contentId: json["content_id"],
        contentType: json["content_type"],
        imgBgPath: json["img_bg_path"],
        contentHeading: json["content_heading"],
        contentDetails: json["content_details"],
        bnCatName: json["bn_cat_name"],
        catSlug: json["cat_slug"],
        subcatSlug: json["subcat_slug"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "img_bg_path": imgBgPath,
        "content_heading": contentHeading,
        "content_details": contentDetails,
        "bn_cat_name": bnCatName,
        "cat_slug": catSlug,
        "subcat_slug": subcatSlug,
        "created_at": createdAt?.toIso8601String(),
      };
}
