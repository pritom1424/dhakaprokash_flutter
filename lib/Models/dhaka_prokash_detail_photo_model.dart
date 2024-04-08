// To parse this JSON data, do
//
//     final detailPhotoModel = detailPhotoModelFromJson(jsonString);

import 'dart:convert';

DetailPhotoModel detailPhotoModelFromJson(String str) =>
    DetailPhotoModel.fromJson(json.decode(str));

String detailPhotoModelToJson(DetailPhotoModel data) =>
    json.encode(data.toJson());

class DetailPhotoModel {
  String albumName;
  DateTime createdAt;
  DateTime updatedAt;
  String shortDescription;
  String catName;
  String catSlug;
  List<PhotoGallery> photoGalleries;

  DetailPhotoModel({
    required this.albumName,
    required this.createdAt,
    required this.updatedAt,
    required this.shortDescription,
    required this.catName,
    required this.catSlug,
    required this.photoGalleries,
  });

  factory DetailPhotoModel.fromJson(Map<String, dynamic> json) =>
      DetailPhotoModel(
        albumName: json["album_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shortDescription: json["short_description"],
        catName: json["cat_name"],
        catSlug: json["cat_slug"],
        photoGalleries: List<PhotoGallery>.from(
            json["photo_galleries"].map((x) => PhotoGallery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "album_name": albumName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "short_description": shortDescription,
        "cat_name": catName,
        "cat_slug": catSlug,
        "photo_galleries":
            List<dynamic>.from(photoGalleries.map((x) => x.toJson())),
      };
}

class PhotoGallery {
  int id;
  int albumId;
  String photo;
  String photoCapture;
  String featureImage;
  DateTime createdAt;
  DateTime updatedAt;

  PhotoGallery({
    required this.id,
    required this.albumId,
    required this.photo,
    required this.photoCapture,
    required this.featureImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PhotoGallery.fromJson(Map<String, dynamic> json) => PhotoGallery(
        id: json["id"],
        albumId: json["album_id"],
        photo: json["photo"],
        photoCapture: json["photo_capture"],
        featureImage: json["feature_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "album_id": albumId,
        "photo": photo,
        "photo_capture": photoCapture,
        "feature_image": featureImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
