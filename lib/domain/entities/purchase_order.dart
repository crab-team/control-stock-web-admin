import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_order_product.dart';

class PurchaseOrder {
  final int? id;
  final Customer customer;
  final List<PurchaseOrderProduct> products;
  final PaymentMethod paymentMethod;

  PurchaseOrder({
    this.id,
    required this.customer,
    required this.products,
    required this.paymentMethod,
  });

  copyWith({
    int? id,
    Customer? customer,
    List<PurchaseOrderProduct>? products,
    PaymentMethod? paymentMethod,
  }) {
    return PurchaseOrder(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      products: products ?? this.products,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  toJson() {
    return {
      'id': id,
      'customer': customer.toJson(),
      'products': products.map((e) => e.toJson()).toList(),
      'paymentMethodId': paymentMethod,
    };
  }
}
