import 'package:control_stock_web_admin/data/models/customer_record_model.dart';

class CustomerRecord {
  int? id;
  int productId;
  String productCode;
  String customerId;
  PaymentStatus paymentStatus;
  int quantity;
  double unitPrice;
  double shoppingTotal;
  String productName;
  double productPrice;
  PaymentMethod paymentMethod;
  int surchargePercentage;

  CustomerRecord({
    required this.id,
    required this.productId,
    required this.productCode,
    required this.customerId,
    required this.paymentStatus,
    required this.quantity,
    required this.unitPrice,
    required this.shoppingTotal,
    required this.productName,
    required this.productPrice,
    required this.paymentMethod,
    required this.surchargePercentage,
  });

  CustomerRecord copyWith({
    int? id,
    int? productId,
    String? productCode,
    String? customerId,
    PaymentStatus? paymentStatus,
    int? quantity,
    double? unitPrice,
    double? shoppingTotal,
    String? productName,
    double? productPrice,
    PaymentMethod? paymentMethod,
    int? surchargePercentage,
  }) {
    return CustomerRecord(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productCode: productCode ?? this.productCode,
      customerId: customerId ?? this.customerId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      shoppingTotal: shoppingTotal ?? this.shoppingTotal,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      surchargePercentage: surchargePercentage ?? this.surchargePercentage,
    );
  }

  CustomerRecordModel toCreateCustomerRecordModel() {
    return CustomerRecordModel(
      productId: int.parse(productCode),
      paymentStatus: paymentStatus.label,
      quantity: quantity,
      unitPrice: unitPrice,
      paymentMethodId: paymentMethod.index,
    );
  }
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

enum PaymentMethod {
  cash,
  debit,
  threeCuotes,
  sixCuotes,
  twelveCuotes,
}

extension PaymentMethodExtension on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.debit:
        return 'Débito';
      case PaymentMethod.threeCuotes:
        return '3 Cuotas';
      case PaymentMethod.sixCuotes:
        return '6 Cuotas';
      case PaymentMethod.twelveCuotes:
        return '12 Cuotas';
    }
  }
}
