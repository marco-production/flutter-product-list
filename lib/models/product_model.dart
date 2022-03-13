import 'dart:convert';

class ProductModel {
  ProductModel({
    this.id,
    required this.avaliable,
    this.image,
    required this.name,
    required this.price,
  }){
    if (image == null) {
      image == 'http://atrilco.com/wp-content/uploads/2017/11/ef3-placeholder-image.jpg';
    }
  }

  String? id;
  bool avaliable;
  String? image;
  String name;
  double price;


  factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    avaliable: json["avaliable"],
    image: json["image"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "avaliable": avaliable,
    "image": image,
    "name": name,
    "price": price,
  };

  ProductModel copy() => ProductModel(
      id: id,
      avaliable: avaliable,
      image: image,
      name: name,
      price: price
  );

}
