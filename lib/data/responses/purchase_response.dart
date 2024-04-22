import 'package:control_stock_web_admin/data/responses/purchase_product_response.dart';
import 'package:control_stock_web_admin/domain/entities/purchase.dart';

class PurchaseResponse {
  final int id;
  final int customerId;
  final String customerName;
  final String customerLastName;
  final double totalShopping;
  final int paymentMethodId;
  final String paymentMethodName;
  final double paymentMethodSurchargePercentage;
  final List<PurchaseProductResponse> purchaseProductsResponses;
  final String createdAt;
  final String status;

  PurchaseResponse({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.totalShopping,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.paymentMethodSurchargePercentage,
    required this.purchaseProductsResponses,
    required this.createdAt,
    required this.status,
  });

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseResponse(
      id: json['id'],
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
      status: json['status'],
    );
  }

  Purchase toDomain() {
    var dateLocal = DateTime.parse(createdAt).toLocal();

    return Purchase(
      id: id,
      customerId: customerId,
      customerName: customerName,
      customerLastName: customerLastName,
      totalShopping: totalShopping,
      paymentMethodId: paymentMethodId,
      paymentMethodName: paymentMethodName,
      paymentMethodSurchargePercentage: paymentMethodSurchargePercentage,
      purchaseProducts: purchaseProductsResponses.map((e) => e.toDomain()).toList(),
      createdAt: dateLocal,
      status: status.toPurchaseStatus(),
    );
  }
}
