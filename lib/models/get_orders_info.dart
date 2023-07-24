import 'dart:convert';

class OrdersInfo {
  int id;
  int productId; // Matches 'product_id' field in the PHP model
  int quantity;
  String price;
  String total;
  String status;
  int userId; // Matches 'user_id' field in the PHP model
  String productName;

  OrdersInfo({
    this.id = 0,
    this.productId = 0,
    this.quantity = 0,
    this.price = '',
    this.total = '',
    this.status = '1',
    this.userId = 0,
    this.productName = '',
  });

  OrdersInfo.fromJson(Map json)
      : id = json['id'],
        productId = json['product_id'],
        quantity = json['quantity'],
        price = json['price'],
        total = json['total'],
        status = json['status'],
        userId = json['user_id'],
        productName = json['product_name'];
  Map toMap() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'total': total,
      'status': status,
      'user_id': userId,
      'product_name': productName,
    };
  }


}
