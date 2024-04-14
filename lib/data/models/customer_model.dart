class CustomerModel {
  final int? id;
  final String? name;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;
  final double? balance;

  CustomerModel({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.balance,
  });

  toCreateJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'balance': balance ?? 0.0,
    };
  }

  toUpdateJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'balance': balance,
    };
  }
}
