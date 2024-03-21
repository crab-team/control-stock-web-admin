class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  @override
  String toString() {
    return 'Category{id: $id, name $name}';
  }

  toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }
}
