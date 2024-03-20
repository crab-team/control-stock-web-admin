import 'package:control_stock_web_admin/domain/entities/product.dart';

class ProductResponse {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int stock;

  ProductResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      stock: json['stock'],
    );
  }

  Product toDomain() {
    return Product(
      id: id,
      name: name,
      code: '',
      imageUrl: imageUrl,
      price: price,
      stock: stock,
      type: '',
    );
  }
}
