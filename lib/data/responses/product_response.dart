import 'package:control_stock_web_admin/domain/entities/product.dart';

class ProductResponse {
  final String id;
  final String name;
  final String code;
  final double price;
  final int stock;
  final String category;
  final String? imageUrl;
  final String? qrUrl;

  ProductResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.price,
    required this.stock,
    required this.category,
    this.imageUrl,
    this.qrUrl,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'],
      stock: json['stock'],
      category: json['category'],
      qrUrl: json['qrURL'],
    );
  }

  Product toDomain() {
    return Product(
      id: id,
      name: name,
      code: code,
      imageUrl: imageUrl ?? '',
      price: price,
      stock: stock,
      category: category,
      qrUrl: qrUrl,
    );
  }
}
