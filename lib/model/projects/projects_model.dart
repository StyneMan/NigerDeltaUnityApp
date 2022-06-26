class ProjectModel {
  int? id;
  String? image;
  String? title;
  String? state;
  int? stateId;
  String? description;
  dynamic createdAt;
  dynamic updatedAt;

  ProjectModel({
    required this.id, 
    required this.image,
    required this.title,
    required this.state,
    required this.stateId,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  ProjectModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    image = parsedJson['image'];
    state = parsedJson['state'];
    stateId = parsedJson['stateId'];
    createdAt = parsedJson['createdAt'];
    updatedAt = parsedJson['updatedAt'];
    description = parsedJson['description'];
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': image,
    'state': state,
    'stateId': stateId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'description': description,
  };

  factory ProjectModel.fromMap(Map data) {
    return ProjectModel(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      state: data['state'],
      stateId: data['stateId'],
      createdAt: data["createdAt"],
      updatedAt: data["updatedAt"],
      description: data['description'],
    );
  }
}