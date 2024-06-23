class HistoricalProductVariations {
  final int id;
  final int productId;
  final double price;
  final int stock;
  final DateTime createdAt;

  HistoricalProductVariations({
    required this.id,
    required this.productId,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

  HistoricalProductVariations copyWith({
    int? id,
    int? productId,
    double? price,
    int? stock,
    DateTime? createdAt,
  }) {
    return HistoricalProductVariations(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
