class HistoricalProductVariationsModel {
  final int? id;
  final int productId;
  final double price;
  final int stock;
  final DateTime createdAt;

  HistoricalProductVariationsModel({
    this.id,
    required this.productId,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

  Map<String, dynamic> toCreateJson() {
    return {
      'productId': productId,
      'price': price,
      'stock': stock,
    };
  }
}
