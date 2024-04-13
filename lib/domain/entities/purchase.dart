class Purchase {
  final int? id;
  final int productId;
  final int? customerId;
  final String customerName;
  final String customerLastName;
  final int quantity;
  final double unitPrice;
  final int paymentMethodId;
  final String? paymentMethodName;
  final int? surchargePercentage;
  final String? productCode;
  final double? totalShopping;
  final String? productName;
  final double? productPrice;

  Purchase({
    this.id,
    this.customerId,
    required this.productId,
    required this.customerName,
    required this.customerLastName,
    required this.quantity,
    required this.unitPrice,
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
    int? customerId,
    int? productId,
    String? customerName,
    String? customerLastName,
    int? quantity,
    double? unitPrice,
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
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      customerName: customerName ?? this.customerName,
      customerLastName: customerLastName ?? this.customerLastName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      productCode: productCode ?? this.productCode,
      totalShopping: totalShopping ?? this.totalShopping,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      paymentMethodName: paymentMethodName ?? this.paymentMethodName,
      surchargePercentage: surchargePercentage ?? this.surchargePercentage,
    );
  }

  String get fullName => '$customerName $customerLastName';
}
