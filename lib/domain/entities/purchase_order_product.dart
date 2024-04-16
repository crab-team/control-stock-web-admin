import 'package:control_stock_web_admin/data/models/purchase_order_product_model.dart';

class PurchaseOrderProduct {
  final int id;
  final String code;
  final int quantity;
  final double unitPrice;
  final double? ajustedPrice;

  PurchaseOrderProduct({
    required this.id,
    required this.code,
    required this.quantity,
    required this.unitPrice,
    this.ajustedPrice,
  });

  copyWith({
    int? id,
    String? code,
    int? quantity,
    double? unitPrice,
    double? ajustedPrice,
  }) {
    return PurchaseOrderProduct(
      id: id ?? this.id,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      ajustedPrice: ajustedPrice ?? this.ajustedPrice,
    );
  }

  toJson() {
    return {
      'id': id,
      'code': code,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'ajustedPrice': ajustedPrice,
    };
  }

  PurchaseOrderProductModel toModel() {
    return PurchaseOrderProductModel(
      id: id,
      quantity: quantity,
      unitPrice: ajustedPrice ?? unitPrice,
    );
  }
}
