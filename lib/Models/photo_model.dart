class PhotoModel {
  int id;
  String title;
  String url;
  String description;

  PhotoModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.description});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'url': url, 'description': description};
  }
}
