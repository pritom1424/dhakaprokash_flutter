// To parse this JSON data, do
//
//     final dhakaProkashAllVideo = dhakaProkashAllVideoFromJson(jsonString);

import 'dart:convert';

DhakaProkashAllVideo dhakaProkashAllVideoFromJson(String str) =>
    DhakaProkashAllVideo.fromJson(json.decode(str));

String dhakaProkashAllVideoToJson(DhakaProkashAllVideo data) =>
    json.encode(data.toJson());

class DhakaProkashAllVideo {
  List<Video> videos;
  int totalVideos;

  DhakaProkashAllVideo({
    required this.videos,
    required this.totalVideos,
  });

  factory DhakaProkashAllVideo.fromJson(Map<String, dynamic> json) =>
      DhakaProkashAllVideo(
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        totalVideos: json["total_videos"],
      );

  Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "total_videos": totalVideos,
      };
}

class Video {
  int id;
  String? title;
  String? code;
  String? imgBgPath;
  DateTime? createdAt;

  Video({
    required this.id,
    required this.title,
    required this.code,
    required this.imgBgPath,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        code: json["code"],
        imgBgPath: json["img_bg_path"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "img_bg_path": imgBgPath,
        "created_at":
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };
}
