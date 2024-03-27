// To parse this JSON data, do
//
//     final dhakaProkashPhotoModel = dhakaProkashPhotoModelFromJson(jsonString);

import 'dart:convert';

List<DhakaProkashPhotoModel> dhakaProkashPhotoModelFromJson(String str) =>
    List<DhakaProkashPhotoModel>.from(
        json.decode(str).map((x) => DhakaProkashPhotoModel.fromJson(x)));

String dhakaProkashPhotoModelToJson(List<DhakaProkashPhotoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DhakaProkashPhotoModel {
  String catName;
  String catSlug;
  int albumId;
  String albumName;
  String shortDescription;
  String? photoCaption;
  String photo;

  DhakaProkashPhotoModel({
    required this.catName,
    required this.catSlug,
    required this.albumId,
    required this.albumName,
    required this.shortDescription,
    required this.photoCaption,
    required this.photo,
  });

  factory DhakaProkashPhotoModel.fromJson(Map<String, dynamic> json) =>
      DhakaProkashPhotoModel(
        catName: json["cat_name"],
        catSlug: json["cat_slug"],
        albumId: json["album_id"],
        albumName: json["album_name"],
        shortDescription: json["short_description"],
        photoCaption: json["photo_caption"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "cat_name": catName,
        "cat_slug": catSlug,
        "album_id": albumId,
        "album_name": albumName,
        "short_description": shortDescription,
        "photo_caption": photoCaption,
        "photo": photo,
      };
}
