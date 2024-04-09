class CustomerRecordModel {
  int? id;
  int productId;
  String paymentStatus;
  int quantity;
  double unitPrice;
  int paymentMethodId;

  CustomerRecordModel({
    this.id,
    required this.productId,
    required this.paymentStatus,
    required this.quantity,
    required this.unitPrice,
    required this.paymentMethodId,
  });

  CustomerRecordModel copyWith({
    int? id,
    int? productId,
    String? paymentStatus,
    int? quantity,
    double? unitPrice,
    int? paymentMethodId,
  }) {
    return CustomerRecordModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }

  toJson() {
    return {
      'id': id,
      'productId': productId,
      'paymentStatus': paymentStatus,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'paymentMethodId': paymentMethodId,
    };
  }
}
