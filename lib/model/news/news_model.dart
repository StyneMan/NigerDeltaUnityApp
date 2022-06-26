class NewsModel {
  int? id;
  String? category;
  String? title;
  String? authorName;
  String? authorPhoto;
  String? body;
  String? image;
  String? summary;

  NewsModel({
    required this.id, 
    required this.body,
    required this.image,
    required this.title,
    required this.summary,
    required this.category,
    required this.authorName,
    required this.authorPhoto,
  });

  NewsModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    body = parsedJson['body'];
    title = parsedJson['title'];
    image = parsedJson['image'];
    summary = parsedJson['summary'];
    category = parsedJson['category'];
    authorName = parsedJson['authorName'];
    authorPhoto = parsedJson['authorPhoto'];
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'body': body,
    'title': title,
    'image': image,
    'summary': summary,
    'category': category,
    'authorName': authorName,
    'authorPhoto': authorPhoto,
  };

  factory NewsModel.fromMap(Map data) {
    return NewsModel(
      id: data['id'],
      body: data['body'],
      title: data['title'],
      image: data['image'],
      summary: data['summary'],
      category: data['category'],
      authorName: data['authorName'],
      authorPhoto: data['authorPhoto'],
    );
  }

}