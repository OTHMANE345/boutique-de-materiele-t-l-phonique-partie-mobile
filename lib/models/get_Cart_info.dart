import 'dart:convert';

class CartInfo {
  int id;
  int productId; // Matches 'product_id' field in the PHP model
  int quantity;
  String price;
  int userId; // Matches 'user_id' field in the PHP model
  String productName;
  String image;

  CartInfo({
    this.id = 0,
    this.productId = 0,
    this.quantity = 0,
    this.price = '',
    this.userId = 0,
    this.productName = '',
    this.image = '',
  });

  CartInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['product_id'],
        quantity = json['quantity'],
        price = json['price'],
        userId = json['user_id'],
        productName = json['product_name'],
        image = json['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'user_id': userId,
      'product_name': productName,
      'image': image,
    };
  }


}
