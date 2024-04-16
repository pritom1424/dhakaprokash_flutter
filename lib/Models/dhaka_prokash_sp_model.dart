// To parse this JSON data, do
//
//     final dhakaProkashSpecialModel = dhakaProkashSpecialModelFromJson(jsonString);

import 'dart:convert';

List<DhakaProkashSpecialModel> dhakaProkashSpecialModelFromJson(String str) =>
    List<DhakaProkashSpecialModel>.from(
        json.decode(str).map((x) => DhakaProkashSpecialModel.fromJson(x)));

String dhakaProkashSpecialModelToJson(List<DhakaProkashSpecialModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaProkashSpecialModel {
  int? contentId;
  int? contentType;
  int? catId;
  int? subcatId;
  int? specialCatId;
  int? countryId;
  int? divisionId;
  int? districtId;
  int? upozillaId;
  String? contentHeading;
  String? contentSubHeading;
  String? authorSlugs;
  dynamic authorName;
  String? contentBrief;
  String? contentDetails;
  String? imgXsPath;
  String? imgSmPath;
  dynamic imgSmCaption;
  String? imgBgPath;
  String? ogImage;
  String? imgbgCaption;
  dynamic relatedIds;
  dynamic photoIds;
  dynamic videoType;
  dynamic videoId;
  int? uploaderId;
  dynamic reporterId;
  List<String>? tags;
  String? metaKeywords;
  dynamic timelineTag;
  dynamic podcastId;
  int? status;
  int? scroll;
  int? totalHit;
  int? deletable;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;
  Subcategory? subcategory;

  DhakaProkashSpecialModel({
    required this.contentId,
    required this.contentType,
    required this.catId,
    required this.subcatId,
    required this.specialCatId,
    required this.countryId,
    required this.divisionId,
    required this.districtId,
    required this.upozillaId,
    required this.contentHeading,
    required this.contentSubHeading,
    required this.authorSlugs,
    required this.authorName,
    required this.contentBrief,
    required this.contentDetails,
    required this.imgXsPath,
    required this.imgSmPath,
    required this.imgSmCaption,
    required this.imgBgPath,
    required this.ogImage,
    required this.imgbgCaption,
    required this.relatedIds,
    required this.photoIds,
    required this.videoType,
    required this.videoId,
    required this.uploaderId,
    required this.reporterId,
    required this.tags,
    required this.metaKeywords,
    required this.timelineTag,
    required this.podcastId,
    required this.status,
    required this.scroll,
    required this.totalHit,
    required this.deletable,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.subcategory,
  });

  factory DhakaProkashSpecialModel.fromJson(Map<String, dynamic> json) =>
      DhakaProkashSpecialModel(
        contentId: json["content_id"],
        contentType: json["content_type"],
        catId: json["cat_id"],
        subcatId: json["subcat_id"],
        specialCatId: json["special_cat_id"],
        countryId: json["country_id"],
        divisionId: json["division_id"],
        districtId: json["district_id"],
        upozillaId: json["upozilla_id"],
        contentHeading: json["content_heading"],
        contentSubHeading: json["content_sub_heading"],
        authorSlugs: json["author_slugs"],
        authorName: json["author_name"],
        contentBrief: json["content_brief"],
        contentDetails: json["content_details"],
        imgXsPath: json["img_xs_path"],
        imgSmPath: json["img_sm_path"],
        imgSmCaption: json["img_sm_caption"],
        imgBgPath: json["img_bg_path"],
        ogImage: json["og_image"],
        imgbgCaption: json["img_bg_caption"],
        relatedIds: json["related_ids"],
        photoIds: json["photo_ids"],
        videoType: json["video_type"],
        videoId: json["video_id"],
        uploaderId: json["uploader_id"],
        reporterId: json["reporter_id"],
        tags: json["tags"].toString().split(','),
        metaKeywords: json["meta_keywords"],
        timelineTag: json["timeline_tag"],
        podcastId: json["podcast_id"],
        status: json["status"],
        scroll: json["scroll"],
        totalHit: json["total_hit"],
        deletable: json["deletable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "cat_id": catId,
        "subcat_id": subcatId,
        "special_cat_id": specialCatId,
        "country_id": countryId,
        "division_id": divisionId,
        "district_id": districtId,
        "upozilla_id": upozillaId,
        "content_heading": contentHeading,
        "content_sub_heading": contentSubHeading,
        "author_slugs": authorSlugs,
        "author_name": authorName,
        "content_brief": contentBrief,
        "content_details": contentDetails,
        "img_xs_path": imgXsPath,
        "img_sm_path": imgSmPath,
        "img_sm_caption": imgSmCaption,
        "img_bg_path": imgBgPath,
        "og_image": ogImage,
        "img_bg_caption": imgbgCaption,
        "related_ids": relatedIds,
        "photo_ids": photoIds,
        "video_type": videoType,
        "video_id": videoId,
        "uploader_id": uploaderId,
        "reporter_id": reporterId,
        "tags": tags,
        "meta_keywords": metaKeywords,
        "timeline_tag": timelineTag,
        "podcast_id": podcastId,
        "status": status,
        "scroll": scroll,
        "total_hit": totalHit,
        "deletable": deletable,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "updated_at":
            updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "category": category?.toJson() ?? "",
        "subcategory": subcategory?.toJson(),
      };
}

class Category {
  int catId;
  String catName;
  String catNameBn;
  String catSlug;

  Category({
    required this.catId,
    required this.catName,
    required this.catNameBn,
    required this.catSlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catId: json["cat_id"],
        catName: json["cat_name"],
        catNameBn: json["cat_name_bn"],
        catSlug: json["cat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
        "cat_name_bn": catNameBn,
        "cat_slug": catSlug,
      };
}

class Subcategory {
  int subcatId;
  String subcatName;
  String subcatNameBn;
  String subcatSlug;

  Subcategory({
    required this.subcatId,
    required this.subcatName,
    required this.subcatNameBn,
    required this.subcatSlug,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        subcatId: json["subcat_id"],
        subcatName: json["subcat_name"],
        subcatNameBn: json["subcat_name_bn"],
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "subcat_id": subcatId,
        "subcat_name": subcatName,
        "subcat_name_bn": subcatNameBn,
        "subcat_slug": subcatSlug,
      };
}
