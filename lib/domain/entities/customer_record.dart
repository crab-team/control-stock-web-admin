class CustomerRecord {
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

  CustomerRecord({
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

  CustomerRecord copyWith({
    int? id,
    String? productCode,
    String? customerId,
    String? paymentStatus,
    int? quantity,
    int? unitPrice,
    int? shoppingTotal,
    String? productName,
    int? productPrice,
    String? paymentMethod,
    int? surchargePercentage,
  }) {
    return CustomerRecord(
      id: id ?? this.id,
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
}
