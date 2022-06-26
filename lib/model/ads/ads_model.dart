class AdsModel {
  int? id;
  String? name;
  String? phone;
  String? status;
  String? banner;
  String? address;
  String? placement;

  AdsModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.status,
    required this.banner,
    required this.address,
    required this.placement
  });

  AdsModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    phone = parsedJson['phone'];
    status = parsedJson['status'];
    banner = parsedJson['banner'];
    address = parsedJson['address'];
    placement = parsedJson['placement'];
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'status': status,
    'banner': banner,
    'address': address,
    'placement': placement,
  };

  factory AdsModel.fromMap(Map data) {
    return AdsModel(
      id: data['id'],
      name: data['name'],
      phone: data['phone'],
      status: data['status'],
      banner: data['banner'],
      address: data['address'],
      placement: data['placement'],
    );
  }

}