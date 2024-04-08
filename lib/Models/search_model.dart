// To parse this JSON data, do
//
//     final dhakaprokashSearchModel = dhakaprokashSearchModelFromJson(jsonString);

import 'dart:convert';

List<DhakaprokashSearchModel> dhakaprokashSearchModelFromJson(String str) =>
    List<DhakaprokashSearchModel>.from(
        json.decode(str).map((x) => DhakaprokashSearchModel.fromJson(x)));

String dhakaprokashSearchModelToJson(List<DhakaprokashSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaprokashSearchModel {
  int contentId;
  int contentType;
  String contentHeading;
  String contentDetails;
  String imgBgPath;
  String catSlug;
  DateTime createdAt;
  DateTime updatedAt;
  String? subcatSlug;

  DhakaprokashSearchModel({
    required this.contentId,
    required this.contentType,
    required this.contentHeading,
    required this.contentDetails,
    required this.imgBgPath,
    required this.catSlug,
    required this.createdAt,
    required this.updatedAt,
    this.subcatSlug,
  });

  factory DhakaprokashSearchModel.fromJson(Map<String, dynamic> json) =>
      DhakaprokashSearchModel(
        contentId: json["content_id"],
        contentType: json["content_type"],
        contentHeading: json["content_heading"],
        contentDetails: json["content_details"],
        imgBgPath: json["img_bg_path"],
        catSlug: json["cat_slug"]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "content_heading": contentHeading,
        "content_details": contentDetails,
        "img_bg_path": imgBgPath,
        "cat_slug": catSlug,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subcat_slug": subcatSlug,
      };
}

enum CatSlug { NATIONAL, POLITICS }

final catSlugValues =
    EnumValues({"national": CatSlug.NATIONAL, "politics": CatSlug.POLITICS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
