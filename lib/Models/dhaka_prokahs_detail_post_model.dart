// To parse this JSON data, do
//
//     final detailPostModel = detailPostModelFromJson(jsonString);

import 'dart:convert';

DetailPostModel detailPostModelFromJson(String str) =>
    DetailPostModel.fromJson(json.decode(str));

String detailPostModelToJson(DetailPostModel data) =>
    json.encode(data.toJson());

class DetailPostModel {
  DetailsContent detailsContent;
  List<MoreDetailContent> moreDetailContent;
  List<FirstRelatedContent> firstRelatedContents;

  DetailPostModel({
    required this.detailsContent,
    required this.moreDetailContent,
    required this.firstRelatedContents,
  });

  factory DetailPostModel.fromJson(Map<String, dynamic> json) =>
      DetailPostModel(
        detailsContent: DetailsContent.fromJson(json["detailsContent"]),
        moreDetailContent: List<MoreDetailContent>.from(
            json["moreDetailContent"]
                .map((x) => MoreDetailContent.fromJson(x))),
        firstRelatedContents: List<FirstRelatedContent>.from(
            json["firstRelatedContents"]
                .map((x) => FirstRelatedContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "detailsContent": detailsContent.toJson(),
        "moreDetailContent":
            List<dynamic>.from(moreDetailContent.map((x) => x.toJson())),
        "firstRelatedContents":
            List<dynamic>.from(firstRelatedContents.map((x) => x.toJson())),
      };
}

class DetailsContent {
  int contentId;
  int contentType;
  int catId;
  int subcatId;
  int specialCatId;
  int countryId;
  int divisionId;
  int districtId;
  int upozillaId;
  String contentHeading;
  dynamic contentSubHeading;
  String? authorSlugs;
  String contentBrief;
  String contentDetails;
  String imgXsPath;
  String imgSmPath;
  dynamic imgSmCaption;
  String imgBgPath;
  String? imgBgCaption;
  String ogImage;
  String? tags;
  String metaKeywords;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;
  DetailsContentSubcategory subcategory;
  Author author;

  DetailsContent({
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
    required this.contentBrief,
    required this.contentDetails,
    required this.imgXsPath,
    required this.imgSmPath,
    required this.imgSmCaption,
    required this.imgBgPath,
    required this.imgBgCaption,
    required this.ogImage,
    required this.tags,
    required this.metaKeywords,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.subcategory,
    required this.author,
  });

  factory DetailsContent.fromJson(Map<String, dynamic> json) => DetailsContent(
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
        contentBrief: json["content_brief"],
        contentDetails: json["content_details"],
        imgXsPath: json["img_xs_path"],
        imgSmPath: json["img_sm_path"],
        imgSmCaption: json["img_sm_caption"],
        imgBgPath: json["img_bg_path"],
        imgBgCaption: json["img_bg_caption"],
        ogImage: json["og_image"],
        tags: json["tags"],
        metaKeywords: json["meta_keywords"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        subcategory: DetailsContentSubcategory.fromJson(json["subcategory"]),
        author: Author.fromJson(json["author"]),
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
        "content_brief": contentBrief,
        "content_details": contentDetails,
        "img_xs_path": imgXsPath,
        "img_sm_path": imgSmPath,
        "img_sm_caption": imgSmCaption,
        "img_bg_path": imgBgPath,
        "img_bg_caption": imgBgCaption,
        "og_image": ogImage,
        "tags": tags,
        "meta_keywords": metaKeywords,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "subcategory": subcategory.toJson(),
        "author": author.toJson(),
      };
}

class Author {
  int authorId;
  String authorNameBn;
  String authorSlug;
  String? imgPath;

  Author({
    required this.authorId,
    required this.authorNameBn,
    required this.authorSlug,
    required this.imgPath,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        authorId: json["author_id"],
        authorNameBn: json["author_name_bn"],
        authorSlug: json["author_slug"],
        imgPath: json["img_path"],
      );

  Map<String, dynamic> toJson() => {
        "author_id": authorId,
        "author_name_bn": authorNameBn,
        "author_slug": authorSlug,
        "img_path": imgPath,
      };
}

class Category {
  String catNameBn;
  int catId;
  String catSlug;

  Category({
    required this.catNameBn,
    required this.catId,
    required this.catSlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        catNameBn: json["cat_name_bn"],
        catId: json["cat_id"],
        catSlug: json["cat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "cat_name_bn": catNameBn,
        "cat_id": catId,
        "cat_slug": catSlug,
      };
}

class DetailsContentSubcategory {
  DetailsContentSubcategory();

  factory DetailsContentSubcategory.fromJson(Map<String, dynamic> json) =>
      DetailsContentSubcategory();

  Map<String, dynamic> toJson() => {};
}

class FirstRelatedContent {
  int contentId;
  int contentType;
  String contentHeading;
  dynamic contentSubHeading;
  String imgBgPath;
  String catSlug;
  String? subcatSlug;

  FirstRelatedContent({
    required this.contentId,
    required this.contentType,
    required this.contentHeading,
    this.contentSubHeading,
    required this.imgBgPath,
    required this.catSlug,
    this.subcatSlug,
  });

  factory FirstRelatedContent.fromJson(Map<String, dynamic> json) =>
      FirstRelatedContent(
        contentId: json["content_id"],
        contentType: json["content_type"],
        contentHeading: json["content_heading"],
        contentSubHeading: json["content_sub_heading"],
        imgBgPath: json["img_bg_path"],
        catSlug: json["cat_slug"],
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_type": contentType,
        "content_heading": contentHeading,
        "content_sub_heading": contentSubHeading,
        "img_bg_path": imgBgPath,
        "cat_slug": catSlug,
        "subcat_slug": subcatSlug,
      };
}

class MoreDetailContent {
  int contentId;
  int contentType;
  int catId;
  int subcatId;
  int specialCatId;
  int countryId;
  int divisionId;
  int districtId;
  int upozillaId;
  String contentHeading;
  dynamic contentSubHeading;
  String authorSlugs;
  String contentBrief;
  String contentDetails;
  String imgXsPath;
  String imgSmPath;
  dynamic imgSmCaption;
  String imgBgPath;
  String ogImage;
  String imgBgCaption;
  String tags;
  String metaKeywords;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;
  MoreDetailContentSubcategory subcategory;
  Author author;
  List<FirstRelatedContent> morecatwisePost;
  List<List<FirstRelatedContent>> morereletedcontentbelow;

  MoreDetailContent({
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
    required this.contentBrief,
    required this.contentDetails,
    required this.imgXsPath,
    required this.imgSmPath,
    required this.imgSmCaption,
    required this.imgBgPath,
    required this.ogImage,
    required this.imgBgCaption,
    required this.tags,
    required this.metaKeywords,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.subcategory,
    required this.author,
    required this.morecatwisePost,
    required this.morereletedcontentbelow,
  });

  factory MoreDetailContent.fromJson(Map<String, dynamic> json) =>
      MoreDetailContent(
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
        contentBrief: json["content_brief"],
        contentDetails: json["content_details"],
        imgXsPath: json["img_xs_path"],
        imgSmPath: json["img_sm_path"],
        imgSmCaption: json["img_sm_caption"],
        imgBgPath: json["img_bg_path"],
        ogImage: json["og_image"],
        imgBgCaption: json["img_bg_caption"],
        tags: json["tags"],
        metaKeywords: json["meta_keywords"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: Category.fromJson(json["category"]),
        subcategory: MoreDetailContentSubcategory.fromJson(json["subcategory"]),
        author: Author.fromJson(json["author"]),
        morecatwisePost: List<FirstRelatedContent>.from(json["morecatwisePost"]
            .map((x) => FirstRelatedContent.fromJson(x))),
        morereletedcontentbelow: List<List<FirstRelatedContent>>.from(
            json["morereletedcontentbelow"].map((x) =>
                List<FirstRelatedContent>.from(
                    x.map((x) => FirstRelatedContent.fromJson(x))))),
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
        "content_brief": contentBrief,
        "content_details": contentDetails,
        "img_xs_path": imgXsPath,
        "img_sm_path": imgSmPath,
        "img_sm_caption": imgSmCaption,
        "img_bg_path": imgBgPath,
        "og_image": ogImage,
        "img_bg_caption": imgBgCaption,
        "tags": tags,
        "meta_keywords": metaKeywords,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
        "subcategory": subcategory.toJson(),
        "author": author.toJson(),
        "morecatwisePost":
            List<dynamic>.from(morecatwisePost.map((x) => x.toJson())),
        "morereletedcontentbelow": List<dynamic>.from(morereletedcontentbelow
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class MoreDetailContentSubcategory {
  String? subcatNameBn;
  int? subcatId;
  String? subcatSlug;

  MoreDetailContentSubcategory({
    this.subcatNameBn,
    this.subcatId,
    this.subcatSlug,
  });

  factory MoreDetailContentSubcategory.fromJson(Map<String, dynamic> json) =>
      MoreDetailContentSubcategory(
        subcatNameBn: json["subcat_name_bn"],
        subcatId: json["subcat_id"],
        subcatSlug: json["subcat_slug"],
      );

  Map<String, dynamic> toJson() => {
        "subcat_name_bn": subcatNameBn,
        "subcat_id": subcatId,
        "subcat_slug": subcatSlug,
      };
}
