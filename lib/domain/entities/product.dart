class Product {
  final String? id;
  final String code;
  final String name;
  final String category;
  final double price;
  final int stock;
  final String imageUrl;

  Product({
    this.id,
    required this.code,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.imageUrl,
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
    );
  }
}
