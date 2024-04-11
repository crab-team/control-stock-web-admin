import 'package:control_stock_web_admin/data/models/purchase_order_product_model.dart';

class PurchaseOrderProduct {
  final int id;
  final String code;
  final int quantity;
  final double unitPrice;

  PurchaseOrderProduct({
    required this.id,
    required this.code,
    required this.quantity,
    required this.unitPrice,
  });

  copyWith({
    int? id,
    String? code,
    int? quantity,
    double? unitPrice,
  }) {
    return PurchaseOrderProduct(
      id: id ?? this.id,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  toJson() {
    return {
      'id': id,
      'code': code,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  PurchaseOrderProductModel toModel() {
    return PurchaseOrderProductModel(
      id: id,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }
}
