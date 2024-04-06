class ProductModel {
  final int? id;
  final String code;
  final String name;
  final double costPrice;
  final int stock;
  final int categoryId;
  final String? imageUrl;
  final bool hasQrPrinted;

  ProductModel({
    this.id,
    required this.code,
    required this.name,
    required this.costPrice,
    required this.stock,
    required this.categoryId,
    required this.hasQrPrinted,
    this.imageUrl,
  });

  Map<String, dynamic> toCreateProductJson() {
    return {
      'code': code,
      'name': name,
      'price': costPrice,
      'stock': stock,
      'categoryId': categoryId,
    };
  }

  Map<String, dynamic> toUpdateProductJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'price': costPrice,
      'stock': stock,
      'categoryId': categoryId,
      'imageUrl': '',
      'hasQrPrinted': hasQrPrinted,
    };
  }
}
