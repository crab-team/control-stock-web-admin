import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';

class Purchase {
  final int? id;
  final double? debt;
  final int? customerId;
  final String customerName;
  final String customerLastName;
  final int paymentMethodId;
  final String? paymentMethodName;
  final int? paymentMethodSurchargePercentage;
  final double? totalShopping;
  final List<PurchaseProduct> purchaseProducts;
  final DateTime? createdAt;

  Purchase({
    this.id,
    this.debt,
    this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.paymentMethodId,
    this.paymentMethodName,
    this.paymentMethodSurchargePercentage,
    this.totalShopping,
    required this.purchaseProducts,
    this.createdAt,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      debt: json['debt'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerLastName: json['customerLastName'],
      totalShopping: json['totalShopping'],
      paymentMethodId: json['paymentMethodId'],
      paymentMethodName: json['paymentMethodName'],
      paymentMethodSurchargePercentage: json['paymentMethodSurcharge'],
      purchaseProducts: List<PurchaseProduct>.from(json['purchaseProducts'].map((x) => PurchaseProduct.fromJson(x))),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  String get fullName => '$customerName $customerLastName';
}
