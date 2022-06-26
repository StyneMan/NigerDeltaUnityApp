class CatalogModel {
  int? id;
  String? image;
  String? name;
  String? price;
  String? vendorAddress;
  int? vendorID;
  String? vendorName;
  String? vendorPhone;
  String? description;

  CatalogModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.vendorID,
    required this.vendorName,
    required this.vendorPhone,
    required this.vendorAddress,
    required this.description,
  });

   CatalogModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    image = parsedJson['image'];
    price = parsedJson['price'];
    vendorID = parsedJson['vendorID'];
    vendorName = parsedJson['vendorName'];
    vendorPhone = parsedJson['vendorPhone'];
    vendorAddress = parsedJson['vendorAddress'];
    description = parsedJson['description'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'vendorID': vendorID,
    'vendorName': vendorName,
    'vendorPhone': vendorPhone,
    'vendorAddress': vendorAddress,
    'description': description,
  };

}