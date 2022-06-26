class HistoryModel {
  int? id;
  String? title;
  String? body;
  String? image;
  String? summary;

  HistoryModel({
    required this.id, 
    required this.body,
    required this.image,
    required this.title,
    required this.summary,
  });

  HistoryModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    body = parsedJson['body'];
    title = parsedJson['title'];
    image = parsedJson['image'];
    summary = parsedJson['summary'];
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'body': body,
    'title': title,
    'image': image,
    'summary': summary,
  };

  factory HistoryModel.fromMap(Map data) {
    return HistoryModel(
      id: data['id'],
      body: data['body'],
      title: data['title'],
      image: data['image'],
      summary: data['summary'],
    );
  }

}