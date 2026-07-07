

class ProductModel {
  String id;
  String name;
  String discription;
  String price;
  String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.discription,
    required this.price,
    required this.image,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
    String? image,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        discription: description ?? this.discription,
        price: price ?? this.price,
        image: image ?? this.image,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    discription: json['discription'] ?? '',
    price: json['price'].toString(),
    image: json['image'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "discription": discription,
    "price": price,
    "image": image,
  };
}