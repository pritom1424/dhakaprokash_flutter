// To parse this JSON data, do
//
//     final detailTagModel = detailTagModelFromJson(jsonString);

import 'dart:convert';

DetailTagModel detailTagModelFromJson(String str) =>
    DetailTagModel.fromJson(json.decode(str));

String detailTagModelToJson(DetailTagModel data) => json.encode(data.toJson());

class DetailTagModel {
  Tag tag;
  List<Content> content;

  DetailTagModel({
    required this.tag,
    required this.content,
  });

  factory DetailTagModel.fromJson(Map<String, dynamic> json) => DetailTagModel(
        tag: Tag.fromJson(json["tag"]),
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tag": tag.toJson(),
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  int? contentId;
  int? contentType;
  String? imgBgPath;
  String? contentHeading;
  String? contentDetails;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? catSlug;

  Content({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.catSlug,
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
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "img_bg_path": imgBgPath,
        "content_heading": contentHeading,
        "content_details": contentDetails,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at":
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "cat_slug": catSlug,
      };
}

class Tag {
  String tagName;
  String tagSlug;

  Tag({
    required this.tagName,
    required this.tagSlug,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        tagName: json["tag_name"],
        tagSlug: json["tag_slug"],
      );

  Map<String, dynamic> toJson() => {
        "tag_name": tagName,
        "tag_slug": tagSlug,
      };
}
