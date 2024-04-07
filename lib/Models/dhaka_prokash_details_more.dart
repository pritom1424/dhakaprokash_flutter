// To parse this JSON data, do
//
//     final detailMorePostModel = detailMorePostModelFromJson(jsonString);

import 'dart:convert';

List<DetailMorePostModel> detailMorePostModelFromJson(String str) =>
    List<DetailMorePostModel>.from(
        json.decode(str).map((x) => DetailMorePostModel.fromJson(x)));

String detailMorePostModelToJson(List<DetailMorePostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailMorePostModel {
  int contentId;
  int contentType;
  String contentHeading;
  String imgBgPath;
  String catSlug;
  String? subcatSlug;

  DetailMorePostModel({
    required this.contentId,
    required this.contentType,
    required this.contentHeading,
    required this.imgBgPath,
    required this.catSlug,
    this.subcatSlug,
  });

  factory DetailMorePostModel.fromJson(Map<String, dynamic> json) =>
      DetailMorePostModel(
        contentId: json["content_id"],
        contentType: json["content_type"],
        contentHeading: json["content_heading"],
        imgBgPath: json["img_bg_path"],
        catSlug: json["cat_slug"],
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "content_heading": contentHeading,
        "img_bg_path": imgBgPath,
        "cat_slug": catSlug,
        "subcat_slug": subcatSlug,
      };
}
