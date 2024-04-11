class CustomerModel {
  final int? id;
  final String? name;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;
  final double? positiveBalance;

  CustomerModel({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.positiveBalance,
  });

  toCreateJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'positiveBalance': positiveBalance ?? 0.0,
    };
  }

  toUpdateJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'positiveBalance': positiveBalance,
    };
  }
}
