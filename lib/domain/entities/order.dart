import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/product_order.dart';

class Order {
  final int? id;
  final Customer customer;
  final List<ProductOrder> products;
  final String paymentMethod;

  Order({
    this.id,
    required this.customer,
    required this.products,
    required this.paymentMethod,
  });

  copyWith({
    int? id,
    Customer? customer,
    List<ProductOrder>? products,
    String? paymentMethod,
  }) {
    return Order(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      products: products ?? this.products,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
