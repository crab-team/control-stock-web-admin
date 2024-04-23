class Category {
  final int id;
  final String name;
  final double percentageProfit;
  final double extraCosts;

  Category({required this.id, required this.name, required this.percentageProfit, required this.extraCosts});

  @override
  String toString() {
    return 'Category{id: $id, name $name, percentageProfit: $percentageProfit}';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'percentageProfit': percentageProfit,
      'extraCosts': extraCosts,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      percentageProfit: map['percentageProfit'],
      extraCosts: map['extraCosts'],
    );
  }

  copyWith({
    int? id,
    String? name,
    double? percentageProfit,
    double? extraCosts,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      percentageProfit: percentageProfit ?? this.percentageProfit,
      extraCosts: extraCosts ?? this.extraCosts,
    );
  }
}
