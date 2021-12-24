class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? gender;
  String? state;
  String? userType;
  String? photo;
  String? osPlatform;
  bool? isActive;
  bool? isBlocked;

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.gender,
    required this.lastname,
    required this.phone,
    required this.photo,
    required this.state,
    required this.userType,
    required this.isBlocked,
    required this.isActive,
    required this.osPlatform,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    return UserModel(
      email: parsedJson['email'],
      firstname: parsedJson['firstname'],
      gender: parsedJson['gender'],
      id: parsedJson['id'],
      lastname: parsedJson['lastname'],
      phone: parsedJson['phone'],
      photo: parsedJson['photo'],
      state: parsedJson['state'],
      userType: parsedJson['userType'],
      isActive: parsedJson['isActive'],
      isBlocked: parsedJson['isBlocked'],
      osPlatform: parsedJson['osPlatform'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstname': firstname,
        'gender': gender,
        'id': id,
        'lastname': lastname,
        'phone': phone,
        'photo': photo,
        'state': state,
        'userType': userType,
        'isActive': isActive,
        'isBlocked': isBlocked,
        'osPlatform': osPlatform
      };
}
