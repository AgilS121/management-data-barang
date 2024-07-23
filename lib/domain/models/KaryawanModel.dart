class KaryawanModel {
  final int id;
  final String name;
  final String position;
  final String status;
  final String email;
  final String phone;
  final String image;
  final String salary;
  final String? bio;

  KaryawanModel(
      {required this.id,
      required this.name,
      required this.position,
      required this.status,
      required this.email,
      required this.phone,
      required this.image,
      required this.salary,
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
}
