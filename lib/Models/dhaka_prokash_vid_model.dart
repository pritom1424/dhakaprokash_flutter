// To parse this JSON data, do
//
//     final dhakaprokashVidModel = dhakaprokashVidModelFromJson(jsonString);

import 'dart:convert';

List<DhakaprokashVidModel> dhakaprokashVidModelFromJson(String str) =>
    List<DhakaprokashVidModel>.from(
        json.decode(str).map((x) => DhakaprokashVidModel.fromJson(x)));

String dhakaprokashVidModelToJson(List<DhakaprokashVidModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaprokashVidModel {
  int id;
  int catId;
  String slug;
  int type;
  String title;
  String imgBgPath;
  String imgSmPath;
  String code;
  int isLive;
  int target;

  DhakaprokashVidModel({
    required this.id,
    required this.catId,
    required this.slug,
    required this.type,
    required this.title,
    required this.imgBgPath,
    required this.imgSmPath,
    required this.code,
    required this.isLive,
    required this.target,
  });

  factory DhakaprokashVidModel.fromJson(Map<String, dynamic> json) =>
      DhakaprokashVidModel(
        id: json["id"],
        catId: json["cat_id"],
        slug: json["slug"],
        type: json["type"],
        title: json["title"],
        imgBgPath: json["img_bg_path"],
        imgSmPath: json["img_sm_path"],
        code: json["code"],
        isLive: json["is_live"],
        target: json["target"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "slug": slug,
        "type": type,
        "title": title,
        "img_bg_path": imgBgPath,
        "img_sm_path": imgSmPath,
        "code": code,
        "is_live": isLive,
        "target": target,
      };
}
