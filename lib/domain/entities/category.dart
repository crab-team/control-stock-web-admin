class Category {
  final int id;
  final String name;
  final double percentageProfit;

  Category({required this.id, required this.name, required this.percentageProfit});

  @override
  String toString() {
    return 'Category{id: $id, name $name, percentageProfit: $percentageProfit}';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'percentageProfit': percentageProfit,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      percentageProfit: map['percentageProfit'],
    );
  }

  copyWith({
    int? id,
    String? name,
    double? percentageProfit,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      percentageProfit: percentageProfit ?? this.percentageProfit,
    );
  }
}
