// To parse this JSON data, do
//
//     final dhakaProkashSingleVideoModel = dhakaProkashSingleVideoModelFromJson(jsonString);

import 'dart:convert';

DhakaProkashSingleVideoModel dhakaProkashSingleVideoModelFromJson(String str) =>
    DhakaProkashSingleVideoModel.fromJson(json.decode(str));

String dhakaProkashSingleVideoModelToJson(DhakaProkashSingleVideoModel data) =>
    json.encode(data.toJson());

class DhakaProkashSingleVideoModel {
  TVideo currentVideo;
  List<TVideo> getVideos;

  DhakaProkashSingleVideoModel({
    required this.currentVideo,
    required this.getVideos,
  });

  factory DhakaProkashSingleVideoModel.fromJson(Map<String, dynamic> json) =>
      DhakaProkashSingleVideoModel(
        currentVideo: TVideo.fromJson(json["currentVideo"]),
        getVideos:
            List<TVideo>.from(json["getVideos"].map((x) => TVideo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currentVideo": currentVideo.toJson(),
        "getVideos": List<dynamic>.from(getVideos.map((x) => x.toJson())),
      };
}

class TVideo {
  int? id;
  int? catId;
  int? type;
  String? title;
  String? code;
  String? imgBgPath;
  dynamic link;
  String? catNameBn;
  String? catSlug;
  DateTime? createdAt;

  TVideo({
    required this.id,
    required this.catId,
    required this.type,
    required this.title,
    required this.code,
    required this.imgBgPath,
    required this.link,
    required this.catNameBn,
    required this.catSlug,
    required this.createdAt,
  });

  factory TVideo.fromJson(Map<String, dynamic> json) => TVideo(
        id: json["id"],
        catId: json["cat_id"],
        type: json["type"],
        title: json["title"],
        code: json["code"],
        imgBgPath: json["img_bg_path"],
        link: json["link"],
        catNameBn: json["cat_name_bn"],
        catSlug: json["cat_slug"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "type": type,
        "title": title,
        "code": code,
        "img_bg_path": imgBgPath,
        "link": link,
        "cat_name_bn": catNameBn,
        "cat_slug": catSlug,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };
}
