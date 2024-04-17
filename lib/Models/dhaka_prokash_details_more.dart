// To parse this JSON data, do
//
//     final detailsMorePostModel = detailsMorePostModelFromJson(jsonString);

import 'dart:convert';

DetailsMorePostModel detailsMorePostModelFromJson(String str) =>
    DetailsMorePostModel.fromJson(json.decode(str));

String detailsMorePostModelToJson(DetailsMorePostModel data) =>
    json.encode(data.toJson());

class DetailsMorePostModel {
  List<Content> contents;

  DetailsMorePostModel({
    required this.contents,
  });

  factory DetailsMorePostModel.fromJson(Map<String, dynamic> json) =>
      DetailsMorePostModel(
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
      };
}

class Content {
  int? contentId;
  int? contentType;
  String? imgBgPath;
  String? contentHeading;
  String? catSlug;

  Content({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.catSlug,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentId: json["content_id"],
        contentType: json["content_type"],
        imgBgPath: json["img_bg_path"],
        contentHeading: json["content_heading"],
        catSlug: json["cat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "img_bg_path": imgBgPath,
        "content_heading": contentHeading,
        "cat_slug": catSlug,
      };
}
