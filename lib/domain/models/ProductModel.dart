class Product {
  final int? id;
  final String name;
  final int price;
  final List<String> image;
  final String? deskripsi;
  final bool? adalahKayuGelondongan;
  final List<String>? dimensi;
  final List<String>? konfigurasi;
  final String? jenisKayu;
  final String? kualitas;
  final String? sertifikasiKeberlanjutan;
  final int? stok;

  Product(
      {this.id,
      required this.name,
      required this.price,
      required this.image,
      this.deskripsi,
      this.adalahKayuGelondongan = true,
      this.dimensi = const [],
      this.konfigurasi = const [],
      this.jenisKayu,
      this.kualitas,
      this.sertifikasiKeberlanjutan,
      this.stok = 0});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        image: List<String>.from(json['image']),
        deskripsi: json['deskripsi'],
        adalahKayuGelondongan: json['adalahKayuGelondongan'],
        dimensi: json['adalahKayuGelondongan']
            ? List<String>.from(json['dimensi'])
            : [],
        konfigurasi: !json['adalahKayuGelondongan']
            ? List<String>.from(json['konfigurasi'])
            : [],
        jenisKayu: json['jenisKayu'],
        kualitas: json['kualitas'],
        sertifikasiKeberlanjutan: json['sertifikasiKeberlanjutan'],
        stok: json['stok']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'deskripsi': deskripsi,
      'adalahKayuGelondongan': adalahKayuGelondongan,
      'dimensi': dimensi,
      'konfigurasi': konfigurasi,
      'jenisKayu': jenisKayu,
      'kualitas': kualitas,
      'sertifikasiKeberlanjutan': sertifikasiKeberlanjutan,
      'stok': stok
    };
  }
}
