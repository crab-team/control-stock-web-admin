import 'package:control_stock_web_admin/data/responses/customer_response.dart';
import 'package:control_stock_web_admin/data/responses/payment_method_response.dart';
import 'package:control_stock_web_admin/data/responses/purchase_product_response.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';

class PurchaseResponse {
  final int id;
  final CustomerResponse customer;
  final double totalShopping;
  final PaymentMethodResponse paymentMethod;
  final List<PurchaseProductResponse> purchaseProductsResponses;
  final String createdAt;
  final String status;

  PurchaseResponse({
    required this.id,
    required this.customer,
    required this.totalShopping,
    required this.paymentMethod,
    required this.purchaseProductsResponses,
    required this.createdAt,
    required this.status,
  });

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseResponse(
      id: json['id'],
      customer: CustomerResponse.fromJson(json['customer']),
      paymentMethod: PaymentMethodResponse.fromJson(json['paymentMethod']),
      totalShopping: json['totalShopping'],
      purchaseProductsResponses:
          List<PurchaseProductResponse>.from(json['purchaseProducts'].map((x) => PurchaseProductResponse.fromJson(x))),
      createdAt: json['createdAt'],
      status: json['status'],
    );
  }

  Purchase toDomain() {
    var dateLocal = DateTime.parse(createdAt).toLocal();

    return Purchase(
      id: id,
      customer: customer.toDomain(),
      totalShopping: totalShopping,
      paymentMethod: paymentMethod.toDomain(),
      purchaseProducts: purchaseProductsResponses.map((e) => e.toDomain()).toList(),
      createdAt: dateLocal,
      status: status.toPurchaseStatus(),
    );
  }
}
