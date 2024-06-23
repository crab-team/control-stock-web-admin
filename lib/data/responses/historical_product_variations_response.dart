import 'package:control_stock_web_admin/domain/entities/historical_product_variations.dart';

class HistoricalProductVariationsResponse {
  final int? id;
  final int productId;
  final double price;
  final int stock;
  final DateTime createdAt;

  HistoricalProductVariationsResponse({
    this.id,
    required this.productId,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

  factory HistoricalProductVariationsResponse.fromJson(Map<String, dynamic> json) {
    return HistoricalProductVariationsResponse(
      id: json['id'],
      productId: json['productId'],
      price: json['price'],
      stock: json['stock'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  HistoricalProductVariations toDomain() {
    return HistoricalProductVariations(
      id: id!,
      productId: productId,
      price: price,
      stock: stock,
      createdAt: createdAt,
    );
  }
}
