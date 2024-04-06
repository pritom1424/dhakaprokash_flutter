// To parse this JSON data, do
//
//     final dhakaProkashTabModel = dhakaProkashTabModelFromJson(jsonString);

import 'dart:convert';

List<DhakaProkashTabModel> dhakaProkashTabModelFromJson(String str) =>
    List<DhakaProkashTabModel>.from(
        json.decode(str).map((x) => DhakaProkashTabModel.fromJson(x)));

String dhakaProkashTabModelToJson(List<DhakaProkashTabModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaProkashTabModel {
  int contentId;
  int contentType;
  String imgBgPath;
  String contentHeading;
  String contentDetails;
  String bnCatName;
  String catSlug;
  String? subcatSlug;

  DhakaProkashTabModel({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentDetails,
    required this.bnCatName,
    required this.catSlug,
    this.subcatSlug,
  });

  factory DhakaProkashTabModel.fromJson(Map<String, dynamic> json) =>
      DhakaProkashTabModel(
        contentId: json["content_id"],
        contentType: json["content_type"],
        imgBgPath: json["img_bg_path"],
        contentHeading: json["content_heading"],
        contentDetails: json["content_details"],
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
        "bn_cat_name": bnCatName,
        "cat_slug": catSlug,
        "subcat_slug": subcatSlug,
      };
}
