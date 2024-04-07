class CustomerModel {
  final int? id;
  final String? name;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? address;

  CustomerModel({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.phone,
    this.address,
  });

  toCreateJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  toUpdateJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}
