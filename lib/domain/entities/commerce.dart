import 'package:control_stock_web_admin/data/models/commerce_model.dart';

class Commerce {
  final int? id;
  final String name;
  final String address;
  final String? phone;
  final String? email;
  final String? imageUrl;

  Commerce({
    this.id,
    required this.name,
    required this.address,
    this.phone,
    this.email,
    this.imageUrl,
  });

  Commerce copyWith({
    int? id,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? imageUrl,
  }) {
    return Commerce(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  CommerceModel toUpdateCommerceModel() {
    return CommerceModel(
      id: id.toString(),
      name: name,
      address: address,
      phone: phone ?? '',
      email: email ?? '',
    );
  }
}
