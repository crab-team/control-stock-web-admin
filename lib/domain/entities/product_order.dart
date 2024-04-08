class ProductPurchaseOrder {
  final int id;
  final String code;
  final int quantity;
  final double price;

  ProductPurchaseOrder({
    required this.id,
    required this.code,
    required this.quantity,
    required this.price,
  });

  copyWith({
    int? id,
    String? code,
    int? quantity,
    double? price,
  }) {
    return ProductPurchaseOrder(
      id: id ?? this.id,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  toJson() {
    return {
      'id': id,
      'code': code,
      'quantity': quantity,
      'price': price,
    };
  }
}
