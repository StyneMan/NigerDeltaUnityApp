class VendorModel {
  int? id;
  String? name;
  String? logo;
  String? phone;
  String? image;
  bool? blocked;
  String? opensAt;
  String? address;
  String? website;
  late bool is24Hours;
  String? closesAt;
  String? category;
  String? description;
  late List<dynamic>? catalog = [];

  VendorModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.image,
    required this.phone,
    required this.address,
    required this.website,
    required this.blocked,
    required this.opensAt,
    required this.catalog,
    required this.closesAt,
    required this.category,
    required this.is24Hours,
    required this.description,
  });

  VendorModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    logo = parsedJson['logo'];
    image = parsedJson['image'];
    phone = parsedJson['phone'];
    address = parsedJson['address'];
    website = parsedJson['website'];
    if (parsedJson['catalog'] != null) {
      catalog = [];
      parsedJson['docs']?.forEach((v) {
        catalog?.add((v));
      });
    }
    blocked = parsedJson['blocked'];
    opensAt = parsedJson['opensAt'];
    closesAt = parsedJson['closesAt'];
    category = parsedJson['category'];
    is24Hours = parsedJson['is24Hours'];
    description = parsedJson['description'];
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo': logo,
    'phone': phone,
    'image': image,
    'website': website,
    'address': address,
    // 'catalog': catalog,
    'blocked': blocked,
    'opensAt': opensAt,
    'closesAt': closesAt,
    'category': category,
    'is24Hours': is24Hours,
    'description': description,
  };

  // factory VendorModel.fromMap(Map data) {
  //   return VendorModel(
  //     id: data['id'],
  //     name: data['name'],
  //     logo: data['logo'],
  //     image: data['image'],
  //     phone: data['phone'],
  //     address: data['address'],
  //     website: data['website'],
  //     // (data['catalog'] != null ? ) {
  //     // catalog = [];
  //     // parsedJson['docs'].forEach((v) {
  //     //   catalog?.add((v));
  //     // });
  //   // },
  //     // catalog = parsedJson['catalog'],
  //     blocked: data['blocked'],
  //     opensAt: data['opensAt'],
  //     closesAt: data['closesAt'],
  //     category: data['category'],
  //     is24Hours: data['is24Hours'],
  //     description: data['description'],
  //   );
  // }

}