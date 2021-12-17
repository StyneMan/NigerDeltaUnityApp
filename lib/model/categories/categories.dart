class CategoriesModel {
  String? id;
  String? title;
  String? url;

  CategoriesModel({required this.id, required this.title, required this.url});

  factory CategoriesModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return CategoriesModel(
      id: parsedJson['id'],
      title: parsedJson['title'],
      url: parsedJson['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'url': url,
      };
}
