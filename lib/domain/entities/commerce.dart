class Commerce {
  final int? id;
  final String name;
  final String address;
  final double cashPaymentPercentage;

  Commerce({
    this.id,
    required this.name,
    required this.address,
    required this.cashPaymentPercentage,
  });

  Commerce copyWith({
    int? id,
    String? name,
    String? address,
    double? cashPaymentPercentage,
  }) {
    return Commerce(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      cashPaymentPercentage: cashPaymentPercentage ?? this.cashPaymentPercentage,
    );
  }
}
