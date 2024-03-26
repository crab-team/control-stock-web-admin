class CommerceModel {
  final String id;
  final String name;
  final String address;
  final double cashPaymentPercentage;

  CommerceModel({
    required this.id,
    required this.name,
    required this.address,
    required this.cashPaymentPercentage,
  });

  factory CommerceModel.fromJson(Map<String, dynamic> json) {
    return CommerceModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      cashPaymentPercentage: json['cashPaymentPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'cashPaymentPercentage': cashPaymentPercentage,
    };
  }

  toUpdateCashPaymentPercentageJson(double cashPaymentPercentage) {
    return {
      'cashPaymentPercentage': cashPaymentPercentage,
    };
  }
}
