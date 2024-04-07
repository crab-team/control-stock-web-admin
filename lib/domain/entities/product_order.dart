class ProductOrder {
  final int id;
  final String code;
  final int quantity;
  final double price;

  ProductOrder({
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
    return ProductOrder(
      id: id ?? this.id,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
