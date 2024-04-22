import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';

enum PurchaseStatus { pending, confirmed, canceled, modified }

extension PurchaseStatusExtension on PurchaseStatus {
  String get name {
    switch (this) {
      case PurchaseStatus.pending:
        return 'Pendiente';
      case PurchaseStatus.confirmed:
        return 'Confirmada';
      case PurchaseStatus.canceled:
        return 'Cancelada';
      case PurchaseStatus.modified:
        return 'Modificada';
    }
  }

  String get string {
    switch (this) {
      case PurchaseStatus.pending:
        return 'PENDING';
      case PurchaseStatus.confirmed:
        return 'CONFIRMED';
      case PurchaseStatus.canceled:
        return 'CANCELED';
      case PurchaseStatus.modified:
        return 'MODIFIED';
    }
  }

  String get color {
    switch (this) {
      case PurchaseStatus.pending:
        return 'FFA500';
      case PurchaseStatus.confirmed:
        return '008000';
      case PurchaseStatus.canceled:
        return 'FF0000';
      case PurchaseStatus.modified:
        return '0000FF';
    }
  }
}

extension PurchaseStatusStringExtension on String {
  PurchaseStatus toPurchaseStatus() {
    switch (this) {
      case 'PENDING':
        return PurchaseStatus.pending;
      case 'CONFIRMED':
        return PurchaseStatus.confirmed;
      case 'CANCELED':
        return PurchaseStatus.canceled;
      case 'MODIFIED':
        return PurchaseStatus.modified;
      default:
        return PurchaseStatus.pending;
    }
  }
}

class Purchase {
  final int? id;
  final int? customerId;
  final String customerName;
  final String customerLastName;
  final int paymentMethodId;
  final String? paymentMethodName;
  final int? paymentMethodSurchargePercentage;
  final double? totalShopping;
  final List<PurchaseProduct> purchaseProducts;
  final DateTime? createdAt;
  final PurchaseStatus? status;

  Purchase({
    this.id,
    this.customerId,
    required this.customerName,
    required this.customerLastName,
    required this.paymentMethodId,
    this.paymentMethodName,
    this.paymentMethodSurchargePercentage,
    this.totalShopping,
    required this.purchaseProducts,
    this.createdAt,
    this.status,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerLastName: json['customerLastName'],
      totalShopping: json['totalShopping'],
      paymentMethodId: json['paymentMethodId'],
      paymentMethodName: json['paymentMethodName'],
      paymentMethodSurchargePercentage: json['paymentMethodSurcharge'],
      purchaseProducts: List<PurchaseProduct>.from(json['purchaseProducts'].map((x) => PurchaseProduct.fromJson(x))),
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
    );
  }

  copyWith({
    int? id,
    int? customerId,
    String? customerName,
    String? customerLastName,
    int? paymentMethodId,
    String? paymentMethodName,
    int? paymentMethodSurchargePercentage,
    double? totalShopping,
    List<PurchaseProduct>? purchaseProducts,
    DateTime? createdAt,
    PurchaseStatus? status,
  }) {
    return Purchase(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerLastName: customerLastName ?? this.customerLastName,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      paymentMethodName: paymentMethodName ?? this.paymentMethodName,
      paymentMethodSurchargePercentage: paymentMethodSurchargePercentage ?? this.paymentMethodSurchargePercentage,
      totalShopping: totalShopping ?? this.totalShopping,
      purchaseProducts: purchaseProducts ?? this.purchaseProducts,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  String get fullName => '$customerName $customerLastName';

  toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'customerLastName': customerLastName,
      'totalShopping': totalShopping,
      'paymentMethodId': paymentMethodId,
      'paymentMethodName': paymentMethodName,
      'paymentMethodSurcharge': paymentMethodSurchargePercentage,
      'purchaseProducts': purchaseProducts.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'status': status,
    };
  }
}
