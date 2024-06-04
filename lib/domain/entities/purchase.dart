import 'package:control_stock_web_admin/domain/entities/customer.dart';
import 'package:control_stock_web_admin/domain/entities/payment_method.dart';
import 'package:control_stock_web_admin/domain/entities/purchase_products.dart';

class Purchase {
  final int? id;
  final Customer? customer;
  final PaymentMethod? paymentMethod;
  final double? totalShopping;
  final double? subtotalShopping;
  final List<PurchaseProduct> purchaseProducts;
  final DateTime? createdAt;
  final PurchaseStatus? status;
  final double? debt;

  Purchase({
    this.id,
    required this.customer,
    required this.paymentMethod,
    this.totalShopping,
    this.subtotalShopping,
    required this.purchaseProducts,
    this.createdAt,
    this.status,
    this.debt,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      customer: json['customer'],
      totalShopping: json['totalShopping'],
      subtotalShopping: json['subtotalShopping'],
      paymentMethod: json['paymentMethod'],
      purchaseProducts: List<PurchaseProduct>.from(json['purchaseProducts'].map((x) => PurchaseProduct.fromJson(x))),
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      debt: json['debt'],
    );
  }

  copyWith({
    int? id,
    Customer? customer,
    PaymentMethod? paymentMethod,
    double? totalShopping,
    double? subtotalShopping,
    List<PurchaseProduct>? purchaseProducts,
    DateTime? createdAt,
    PurchaseStatus? status,
    double? debt,
  }) {
    return Purchase(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalShopping: totalShopping ?? this.totalShopping,
      subtotalShopping: subtotalShopping ?? this.subtotalShopping,
      purchaseProducts: purchaseProducts ?? this.purchaseProducts,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      debt: debt ?? this.debt,
    );
  }

  String get fullName => '${customer!.name} ${customer!.lastName}';

  toJson() {
    return {
      'id': id,
      'customer': customer?.toJson(),
      'paymentMethod': paymentMethod?.toJson(),
      'totalShopping': totalShopping,
      'subtotalShopping': subtotalShopping,
      'purchaseProducts': purchaseProducts.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'status': status,
      'debt': debt,
    };
  }

  toConfirmPurchase() {
    return {
      'paymentMethodId': paymentMethod?.id,
      'products': purchaseProducts.map((e) => e.toCreateJson()).toList(),
      'debt': debt,
    };
  }
}

enum PurchaseStatus { pending, confirmed, cancelled, modified }

extension PurchaseStatusExtension on PurchaseStatus {
  String get name {
    switch (this) {
      case PurchaseStatus.pending:
        return 'Pendiente';
      case PurchaseStatus.confirmed:
        return 'Confirmada';
      case PurchaseStatus.cancelled:
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
      case PurchaseStatus.cancelled:
        return 'CANCELLED';
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
      case PurchaseStatus.cancelled:
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
      case 'CANCELLED':
        return PurchaseStatus.cancelled;
      case 'MODIFIED':
        return PurchaseStatus.modified;
      default:
        return PurchaseStatus.pending;
    }
  }
}
