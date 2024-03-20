import 'package:control_stock_web_admin/domain/entities/category.dart';

class CategoryResponse {
  final String id;
  final String name;

  CategoryResponse({
    required this.id,
    required this.name,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
    );
  }

  Category toDomain() {
    return Category(
      id: id,
      name: name,
    );
  }
}
