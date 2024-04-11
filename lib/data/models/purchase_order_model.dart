import 'package:control_stock_web_admin/data/models/purchase_order_product_model.dart';

class PurchaseOrderModel {
  final int? id;
  final List<PurchaseOrderProductModel> products;
  final double debt;
  final int paymentMethodId;

  PurchaseOrderModel({
    this.id,
    required this.products,
    required this.debt,
    required this.paymentMethodId,
  });

  copyWith({
    int? id,
    int? customerId,
    double? debt,
    List<PurchaseOrderProductModel>? products,
    int? paymentMethodId,
  }) {
    return PurchaseOrderModel(
      id: id ?? this.id,
      products: products ?? this.products,
      debt: debt ?? this.debt,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }

  toJson() {
    return {
      'id': id,
      'debt': debt,
      'products': products.map((e) => e.toJson()).toList(),
      'paymentMethodId': paymentMethodId,
    };
  }

  toCreateJson() {
    return {
      'debt': debt,
      'products': products.map((e) => e.toCreateJson()).toList(),
      'paymentMethodId': paymentMethodId,
    };
  }
}
