// To parse this JSON data, do
//
//     final dhakaProkashVidTotal = dhakaProkashVidTotalFromJson(jsonString);

import 'dart:convert';

DhakaProkashVidTotal dhakaProkashVidTotalFromJson(String str) =>
    DhakaProkashVidTotal.fromJson(json.decode(str));

String dhakaProkashVidTotalToJson(DhakaProkashVidTotal data) =>
    json.encode(data.toJson());

class DhakaProkashVidTotal {
  List<CategoryVideo> categoryVideos;
  List<dynamic> specialTopVideos;
  List<dynamic> allCategory;

  DhakaProkashVidTotal({
    required this.categoryVideos,
    required this.specialTopVideos,
    required this.allCategory,
  });

  factory DhakaProkashVidTotal.fromJson(Map<String, dynamic> json) =>
      DhakaProkashVidTotal(
        categoryVideos: List<CategoryVideo>.from(
            json["categoryVideos"].map((x) => CategoryVideo.fromJson(x))),
        specialTopVideos:
            List<dynamic>.from(json["specialTopVideos"].map((x) => x)),
        allCategory: List<dynamic>.from(json["allCategory"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "categoryVideos":
            List<dynamic>.from(categoryVideos.map((x) => x.toJson())),
        "specialTopVideos": List<dynamic>.from(specialTopVideos.map((x) => x)),
        "allCategory": List<dynamic>.from(allCategory.map((x) => x)),
      };
}

class CategoryVideo {
  List<Video> videos;
  Category category;

  CategoryVideo({
    required this.videos,
    required this.category,
  });

  factory CategoryVideo.fromJson(Map<String, dynamic> json) => CategoryVideo(
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "category": category.toJson(),
      };
}

class Category {
  int id;
  String name;
  String slug;
  String nameBn;
  String metaKeywords;
  String metaDescription;
  dynamic ogImgPath;
  int position;
  int userId;
  int status;
  int deletable;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.nameBn,
    required this.metaKeywords,
    required this.metaDescription,
    required this.ogImgPath,
    required this.position,
    required this.userId,
    required this.status,
    required this.deletable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        nameBn: json["name_bn"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        ogImgPath: json["og_img_path"],
        position: json["position"],
        userId: json["user_id"],
        status: json["status"],
        deletable: json["deletable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "name_bn": nameBn,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "og_img_path": ogImgPath,
        "position": position,
        "user_id": userId,
        "status": status,
        "deletable": deletable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Video {
  int id;
  int catId;
  int type;
  String title;
  String code;
  String imgBgPath;
  String imgSmPath;
  String imgXsPath;
  dynamic link;
  dynamic metaKeywords;
  dynamic metaDescription;
  int userId;
  int target;
  int isLive;
  int status;
  int deletable;
  DateTime createdAt;
  DateTime updatedAt;

  Video({
    required this.id,
    required this.catId,
    required this.type,
    required this.title,
    required this.code,
    required this.imgBgPath,
    required this.imgSmPath,
    required this.imgXsPath,
    required this.link,
    required this.metaKeywords,
    required this.metaDescription,
    required this.userId,
    required this.target,
    required this.isLive,
    required this.status,
    required this.deletable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        catId: json["cat_id"],
        type: json["type"],
        title: json["title"],
        code: json["code"],
        imgBgPath: json["img_bg_path"],
        imgSmPath: json["img_sm_path"],
        imgXsPath: json["img_xs_path"],
        link: json["link"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        userId: json["user_id"],
        target: json["target"],
        isLive: json["is_live"],
        status: json["status"],
        deletable: json["deletable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "type": type,
        "title": title,
        "code": code,
        "img_bg_path": imgBgPath,
        "img_sm_path": imgSmPath,
        "img_xs_path": imgXsPath,
        "link": link,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "user_id": userId,
        "target": target,
        "is_live": isLive,
        "status": status,
        "deletable": deletable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
