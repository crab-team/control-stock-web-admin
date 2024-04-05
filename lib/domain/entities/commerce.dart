class Commerce {
  final int? id;
  final String name;
  final String address;
  final double discountCashPercentage;

  Commerce({
    this.id,
    required this.name,
    required this.address,
    required this.discountCashPercentage,
  });

  Commerce copyWith({
    int? id,
    String? name,
    String? address,
    double? discountCashPercentage,
  }) {
    return Commerce(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      discountCashPercentage: discountCashPercentage ?? this.discountCashPercentage,
    );
  }
}
