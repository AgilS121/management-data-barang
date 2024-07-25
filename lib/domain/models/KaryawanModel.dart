class KaryawanModel {
  final String? id;
  final String? name;
  final String? position;
  final String? status;
  final String? email;
  final String? phone;
  final String? image;
  final String? salary;
  final String? bio;

  KaryawanModel(
      {this.id,
      this.name,
      this.position,
      this.status,
      this.email,
      this.phone,
      this.image,
      this.salary,
      this.bio});

  // Factory constructor to create an KaryawanModel from a JSON map
  factory KaryawanModel.fromJson(Map<String, dynamic> json) {
    return KaryawanModel(
        id: json['id'],
        name: json['name'],
        position: json['position'],
        status: json['status'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        salary: json['salary'],
        bio: json['bio']);
  }

  // Method to convert an KaryawanModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'status': status,
      'email': email,
      'phone': phone,
      'image': image,
      'salary': salary,
      'bio': bio
    };
  }

  KaryawanModel copyWith({
    String? id,
    String? name,
    String? position,
    String? status,
    String? email,
    String? phone,
    String? image,
    String? salary,
    String? bio,
  }) {
    return KaryawanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      status: status ?? this.status,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      salary: salary ?? this.salary,
      bio: bio ?? this.bio,
    );
  }
}
