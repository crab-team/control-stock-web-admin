import 'package:control_stock_web_admin/domain/entities/customer_record.dart';

class CustomerRecordResponse {
  int id;
  int productId;
  String productCode;
  String customerId;
  String paymentStatus;
  int quantity;
  double unitPrice;
  double shoppingTotal;
  String productName;
  double productPrice;
  String paymentMethod;
  int surchargePercentage;

  CustomerRecordResponse({
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

  factory CustomerRecordResponse.fromJson(Map<String, dynamic> json) {
    return CustomerRecordResponse(
      id: json['id'],
      productId: json['productId'],
      productCode: json['productCode'],
      customerId: json['customerId'],
      paymentStatus: json['paymentStatus'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      shoppingTotal: json['shoppingTotal'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      paymentMethod: json['paymentMethod'],
      surchargePercentage: json['surchargePercentage'],
    );
  }

  CustomerRecord toDomain() {
    return CustomerRecord(
      id: id,
      productId: productId,
      productCode: productCode,
      customerId: customerId,
      paymentStatus: paymentStatusEnum,
      quantity: quantity,
      unitPrice: unitPrice,
      shoppingTotal: shoppingTotal,
      productName: productName,
      productPrice: productPrice,
      paymentMethod: paymentMethodEnum,
      surchargePercentage: surchargePercentage,
    );
  }

  PaymentStatus get paymentStatusEnum {
    switch (paymentStatus) {
      case 'CANCELED':
        return PaymentStatus.canceled;
      case 'PENDING':
        return PaymentStatus.pending;
      case 'PAID':
        return PaymentStatus.paid;
      default:
        return PaymentStatus.none;
    }
  }

  PaymentMethod get paymentMethodEnum {
    switch (paymentMethod) {
      case 'CASH':
        return PaymentMethod.cash;
      case 'DEBIT':
        return PaymentMethod.debit;
      case 'THREE_CUOTES':
        return PaymentMethod.threeCuotes;
      case 'SIX_CUOTES':
        return PaymentMethod.sixCuotes;
      case 'TWELVE_CUOTES':
        return PaymentMethod.twelveCuotes;
      default:
        return PaymentMethod.cash;
    }
  }
}
