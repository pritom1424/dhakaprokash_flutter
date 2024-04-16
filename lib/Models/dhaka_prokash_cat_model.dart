// To parse this JSON data, do
//
//     final dhakaprokashCatModel = dhakaprokashCatModelFromJson(jsonString);

import 'dart:convert';

DhakaprokashCatModel dhakaprokashCatModelFromJson(String str) =>
    DhakaprokashCatModel.fromJson(json.decode(str));

String dhakaprokashCatModelToJson(DhakaprokashCatModel data) =>
    json.encode(data.toJson());

class DhakaprokashCatModel {
  Category category;
  List<dynamic> subcat;
  List<Content> contents;
  int? totalPost;

  DhakaprokashCatModel(
      {required this.category,
      required this.subcat,
      required this.contents,
      required this.totalPost});

  factory DhakaprokashCatModel.fromJson(Map<String, dynamic> json) =>
      DhakaprokashCatModel(
        totalPost: json['total_post'],
        category: Category.fromJson(json["category"]),
        subcat: List<dynamic>.from(json["subcat"].map((x) => x)),
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "subcat": List<dynamic>.from(subcat.map((x) => x)),
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        'total_post': totalPost
      };
}

class Category {
  String? catNameBn;
  String? catSlug;

  Category({
    required this.catNameBn,
    required this.catSlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catNameBn: json["cat_name_bn"]!,
        catSlug: json["cat_slug"]!,
      );

  Map<String, dynamic> toJson() => {
        "cat_name_bn": catNameBn,
        "cat_slug": catSlug,
      };
}

enum CatNameBn { EMPTY }

final catNameBnValues = EnumValues({"জাতীয়": CatNameBn.EMPTY});

enum CatSlug { NATIONAL }

final catSlugValues = EnumValues({"national": CatSlug.NATIONAL});

class Content {
  int? contentId;
  int? contentType;
  String? imgBgPath;
  String? contentHeading;
  String? contentDetails;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bnCatName;
  String? catSlug;

  Content({
    required this.contentId,
    required this.contentType,
    required this.imgBgPath,
    required this.contentHeading,
    required this.contentDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.bnCatName,
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
        bnCatName: json["bn_cat_name"].toString(),
        catSlug: json["cat_slug"].toString(),
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
        "bn_cat_name": bnCatName,
        "cat_slug": catSlug,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
