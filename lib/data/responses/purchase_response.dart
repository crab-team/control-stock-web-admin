import 'package:control_stock_web_admin/domain/entities/purchase.dart';

class PurchaseResponse {
  final int id;
  final int productId;
  final String productCode;
  final int customerId;
  final String customerName;
  final String customerLastName;
  final int quantity;
  final double unitPrice;
  final double totalShopping;
  final double debt;
  final String productName;
  final double productPrice;
  final int paymentMethodId;
  final String paymentMethodName;
  final int surchargePercentage;

  PurchaseResponse({
    required this.id,
    required this.productId,
    required this.productCode,
    required this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.quantity,
    required this.unitPrice,
    required this.totalShopping,
    required this.debt,
    required this.productName,
    required this.productPrice,
    required this.paymentMethodId,
    required this.paymentMethodName,
    required this.surchargePercentage,
  });

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) {
    return PurchaseResponse(
      id: json['id'],
      productId: json['productId'],
      productCode: json['productCode'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerLastName: json['customerLastName'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      totalShopping: json['totalShopping'],
      debt: json['debt'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      paymentMethodId: json['paymentMethodId'],
      paymentMethodName: json['paymentMethodName'],
      surchargePercentage: json['surchargePercentage'],
    );
  }

  Purchase toDomain() {
    return Purchase(
      id: id,
      productId: productId,
      productCode: productCode,
      customerName: customerName,
      customerLastName: customerLastName,
      quantity: quantity,
      unitPrice: unitPrice,
      totalShopping: totalShopping,
      debt: debt,
      productName: productName,
      productPrice: productPrice,
      paymentMethodId: paymentMethodId,
      paymentMethodName: paymentMethodName,
      surchargePercentage: surchargePercentage,
    );
  }
}
