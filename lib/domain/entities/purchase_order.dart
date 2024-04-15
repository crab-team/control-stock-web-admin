import 'package:control_stock_web_admin/data/models/purchase_order_model.dart';
import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order_product.dart';

class PurchaseOrder {
  final int? id;
  final Customer? customer;
  final List<PurchaseOrderProduct> products;
  final double total;
  final PaymentMethod paymentMethod;
  final double debt;

  PurchaseOrder({
    this.id,
    required this.customer,
    required this.products,
    required this.total,
    required this.paymentMethod,
    required this.debt,
  });

  copyWith({
    int? id,
    Customer? customer,
    List<PurchaseOrderProduct>? products,
    double? total,
    PaymentMethod? paymentMethod,
    double? debt,
  }) {
    return PurchaseOrder(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      products: products ?? this.products,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      debt: debt ?? this.debt,
    );
  }

  toJson() {
    return {
      'id': id,
      'customer': customer?.toJson(),
      'total': total,
      'products': products.map((e) => e.toJson()).toList(),
      'paymentMethodId': paymentMethod,
      'debt': debt,
    };
  }

  PurchaseOrderModel toModel() {
    return PurchaseOrderModel(
      id: id,
      products: products.map((e) => e.toModel()).toList(),
      paymentMethodId: paymentMethod.id!,
      debt: debt,
    );
  }
}
