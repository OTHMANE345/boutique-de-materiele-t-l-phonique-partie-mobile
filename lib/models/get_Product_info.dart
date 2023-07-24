import 'dart:convert';

class ProductInfo {
  int id;
  String name;
  String description;
  String price;
  int categoryId;
  String image;

  ProductInfo({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.price = '',
    this.categoryId = 0,
    this.image = '',
  });

  ProductInfo.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        categoryId = json['category_id'],
        image = json['image'];
  Map toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'image': image,
    };
  }
}
