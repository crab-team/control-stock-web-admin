import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/product_order.dart';

class PurcharseOrder {
  final int? id;
  final Customer customer;
  final List<ProductPurchaseOrder> products;
  final String paymentMethod;

  PurcharseOrder({
    this.id,
    required this.customer,
    required this.products,
    required this.paymentMethod,
  });

  copyWith({
    int? id,
    Customer? customer,
    List<ProductPurchaseOrder>? products,
    String? paymentMethod,
  }) {
    return PurcharseOrder(
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
      'paymentMethod': paymentMethod,
    };
  }
}
