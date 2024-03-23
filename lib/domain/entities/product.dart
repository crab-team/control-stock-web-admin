class Product {
  final String? id;
  final String code;
  final String name;
  final String category;
  final double price;
  final int stock;
  final String imageUrl;
  final String? qrUrl;

  Product({
    this.id,
    required this.code,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.imageUrl,
    this.qrUrl,
  });

  toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
      'qrUrl': qrUrl,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      stock: json['stock'],
      imageUrl: json['imageUrl'],
      qrUrl: json['qrUrl'],
    );
  }

  copyWith({
    String? id,
    String? code,
    String? name,
    String? category,
    double? price,
    int? stock,
    String? imageUrl,
    String? qrUrl,
  }) {
    return Product(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
      qrUrl: qrUrl ?? this.qrUrl,
    );
  }
}
