import 'package:control_stock_web_admin/data/responses/purchase_product_response.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';

class PurchaseResponse {
  final int id;
  final double debt;
  final int customerId;
  final String customerName;
  final String customerLastName;
  final double totalShopping;
  final int paymentMethodId;
  final String paymentMethodName;
  final int paymentMethodSurchargePercentage;
  final List<PurchaseProductResponse> purchaseProductsResponses;
  final String createdAt;

  PurchaseResponse({
    required this.id,
    required this.debt,
    required this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.totalShopping,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.paymentMethodSurchargePercentage,
    required this.purchaseProductsResponses,
    required this.createdAt,
  });

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseResponse(
      id: json['id'],
      debt: json['debt'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerLastName: json['customerLastName'],
      totalShopping: json['totalShopping'],
      paymentMethodId: json['paymentMethodId'],
      paymentMethodName: json['paymentMethodName'],
      paymentMethodSurchargePercentage: json['paymentMethodSurcharge'],
      purchaseProductsResponses:
          List<PurchaseProductResponse>.from(json['purchaseProducts'].map((x) => PurchaseProductResponse.fromJson(x))),
      createdAt: json['createdAt'],
    );
  }

  Purchase toDomain() {
    var dateLocal = DateTime.parse(createdAt).toLocal();

    return Purchase(
      id: id,
      debt: debt,
      customerName: customerName,
      customerLastName: customerLastName,
      totalShopping: totalShopping,
      paymentMethodId: paymentMethodId,
      paymentMethodName: paymentMethodName,
      paymentMethodSurchargePercentage: paymentMethodSurchargePercentage,
      purchaseProducts: purchaseProductsResponses.map((e) => e.toDomain()).toList(),
      createdAt: dateLocal,
    );
  }
}
