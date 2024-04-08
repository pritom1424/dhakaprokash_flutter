// To parse this JSON data, do
//
//     final detailsMoreAuthorModel = detailsMoreAuthorModelFromJson(jsonString);

import 'dart:convert';

DetailsAuthorModel detailsMoreAuthorModelFromJson(String str) =>
    DetailsAuthorModel.fromJson(json.decode(str));

String detailsMoreAuthorModelToJson(DetailsAuthorModel data) =>
    json.encode(data.toJson());

class DetailsAuthorModel {
  Author author;
  List<Content> content;

  DetailsAuthorModel({
    required this.author,
    required this.content,
  });

  factory DetailsAuthorModel.fromJson(Map<String, dynamic> json) =>
      DetailsAuthorModel(
        author: Author.fromJson(json["author"]),
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Author {
  String authorNameBn;
  String authorSlug;

  Author({
    required this.authorNameBn,
    required this.authorSlug,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorNameBn: json["author_name_bn"],
        authorSlug: json["author_slug"],
      );

  Map<String, dynamic> toJson() => {
        "author_name_bn": authorNameBn,
        "author_slug": authorSlug,
      };
}

class Content {
  int contentId;
  int contentType;
  String imgBgPath;
  String contentHeading;
  String contentDetails;
  DateTime createdAt;
  DateTime updatedAt;
  String catSlug;
  String? subcatSlug;

  Content({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.catSlug,
    this.subcatSlug,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentId: json["content_id"],
        contentType: json["content_type"],
        imgBgPath: json["img_bg_path"],
        contentHeading: json["content_heading"],
        contentDetails: json["content_details"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "cat_slug": catSlug,
        "subcat_slug": subcatSlug,
      };
}
