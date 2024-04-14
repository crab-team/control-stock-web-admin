import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';

class PurchaseProductResponse {
  final int id;
  final String code;
  final int quantity;
  final double unitPrice;
  final String name;

  PurchaseProductResponse({
    required this.id,
    required this.code,
    required this.quantity,
    required this.unitPrice,
    required this.name,
  });

  factory PurchaseProductResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseProductResponse(
      id: json['id'],
      code: json['code'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      name: json['name'],
    );
  }

  PurchaseProduct toDomain() {
    return PurchaseProduct(
      id: id,
      code: code,
      quantity: quantity,
      unitPrice: unitPrice,
      name: name,
    );
  }
}
