class SearchModel {
  String name;
  String image_url;
  String description;

  SearchModel(
      {required this.name, required this.image_url, required this.description});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        name: json['name'],
        image_url: json['image_url'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'image_url': image_url, 'description': description};
  }
}
