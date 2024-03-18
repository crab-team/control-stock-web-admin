class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  @override
  String toString() {
    return 'Category{id: $id, name $name}';
  }
}
