import 'package:control_stock_web_admin/domain/entities/customer_record.dart';

class CustomerRecordResponse {
  int id;
  String productCode;
  String customerId;
  String paymentStatus;
  int quantity;
  int unitPrice;
  int shoppingTotal;
  String productName;
  int productPrice;
  String paymentMethod;
  int surchargePercentage;

  CustomerRecordResponse({
    required this.id,
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
      productCode: productCode,
      customerId: customerId,
      paymentStatus: paymentStatus,
      quantity: quantity,
      unitPrice: unitPrice,
      shoppingTotal: shoppingTotal,
      productName: productName,
      productPrice: productPrice,
      paymentMethod: paymentMethod,
      surchargePercentage: surchargePercentage,
    );
  }
}
