import 'package:control_stock_web_admin/domain/entities/category.dart';

class CategoryResponse {
  final int id;
  final String name;
  final double percentageProfit;

  CategoryResponse({
    required this.id,
    required this.name,
    required this.percentageProfit,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      percentageProfit: double.parse(json['percentageProfit']),
    );
  }

  Category toDomain() {
    return Category(
      id: id,
      name: name,
      percentageProfit: percentageProfit,
    );
  }
}
