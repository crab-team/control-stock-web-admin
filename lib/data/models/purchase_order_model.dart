import 'package:control_stock_web_admin/data/models/purchase_order_product_model.dart';

class PurchaseOrderModel {
  final int? id;
  final List<PurchaseOrderProductModel> products;
  final int paymentMethodId;
  final double debt;

  PurchaseOrderModel({
    this.id,
    required this.products,
    required this.paymentMethodId,
    required this.debt,
  });

  copyWith({
    int? id,
    int? customerId,
    List<PurchaseOrderProductModel>? products,
    int? paymentMethodId,
    double? debt,
  }) {
    return PurchaseOrderModel(
      id: id ?? this.id,
      products: products ?? this.products,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      debt: debt ?? this.debt,
    );
  }

  toJson() {
    return {
      'id': id,
      'products': products.map((e) => e.toJson()).toList(),
      'paymentMethodId': paymentMethodId,
    };
  }

  toCreateJson() {
    return {
      'products': products.map((e) => e.toCreateJson()).toList(),
      'paymentMethodId': paymentMethodId,
    };
  }
}
