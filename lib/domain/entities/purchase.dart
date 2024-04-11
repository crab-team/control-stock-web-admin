import 'package:control_stock_web_admin/data/models/customer_record_model.dart';

class Purchase {
  final int? id;
  final int productId;
  final String customerName;
  final String customerLastName;
  final PaymentStatus paymentStatus;
  final int quantity;
  final double unitPrice;
  final double debt;
  final int paymentMethodId;
  final String? paymentMethodName;
  final int? surchargePercentage;
  final String? productCode;
  final double? totalShopping;
  final String? productName;
  final double? productPrice;

  Purchase({
    this.id,
    required this.productId,
    required this.customerName,
    required this.customerLastName,
    required this.paymentStatus,
    required this.quantity,
    required this.unitPrice,
    required this.debt,
    required this.paymentMethodId,
    this.paymentMethodName,
    this.surchargePercentage,
    this.productCode,
    this.totalShopping,
    this.productName,
    this.productPrice,
  });

  Purchase copyWith({
    int? id,
    int? productId,
    String? customerName,
    String? customerLastName,
    PaymentStatus? paymentStatus,
    int? quantity,
    double? unitPrice,
    double? debt,
    String? productCode,
    double? totalShopping,
    String? productName,
    double? productPrice,
    int? paymentMethodId,
    String? paymentMethodName,
    int? surchargePercentage,
  }) {
    return Purchase(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      customerName: customerName ?? this.customerName,
      customerLastName: customerLastName ?? this.customerLastName,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      debt: debt ?? this.debt,
      productCode: productCode ?? this.productCode,
      totalShopping: totalShopping ?? this.totalShopping,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      paymentMethodName: paymentMethodName ?? this.paymentMethodName,
      surchargePercentage: surchargePercentage ?? this.surchargePercentage,
    );
  }

  PurchaseModel toCreateCustomerRecordModel() {
    return PurchaseModel(
      productId: productId,
      paymentStatus: paymentStatus.label,
      quantity: quantity,
      unitPrice: unitPrice,
      paymentMethodId: paymentMethodId,
    );
  }

  String get fullName => '$customerName $customerLastName';
}

enum PaymentStatus {
  pending,
  paid,
  canceled,
  none,
}

extension PaymentStatusExtension on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pendiente';
      case PaymentStatus.paid:
        return 'Pagado';
      case PaymentStatus.canceled:
        return 'Cancelado';
      case PaymentStatus.none:
        return '-';
    }
  }
}
