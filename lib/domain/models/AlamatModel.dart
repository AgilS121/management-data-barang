class Address {
  final String? id;
  final String name;
  final String phone;
  final String street;
  final String city;
  final String postalCode;

  Address({
    this.id,
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      street: json['street'],
      city: json['city'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'street': street,
      'city': city,
      'postalCode': postalCode,
    };
  }
}
