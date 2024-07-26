class Product {
  final String? id;
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
  final String? category;

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
      this.stok = 0,
      this.category});

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
        stok: json['stok'],
        category: json['category']);
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
      'stok': stok,
      'category': category
    };
  }

  Product copyWith(
      {String? id,
      String? name,
      int? price,
      List<String>? image,
      String? deskripsi,
      bool? adalahKayuGelondongan,
      List<String>? dimensi,
      List<String>? konfigurasi,
      String? jenisKayu,
      String? kualitas,
      String? sertifikasiKeberlanjutan,
      int? stok,
      String? category}) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        image: image ?? this.image,
        deskripsi: deskripsi ?? this.deskripsi,
        adalahKayuGelondongan:
            adalahKayuGelondongan ?? this.adalahKayuGelondongan,
        dimensi: dimensi ?? this.dimensi,
        konfigurasi: konfigurasi ?? this.konfigurasi,
        jenisKayu: jenisKayu ?? this.jenisKayu,
        kualitas: kualitas ?? this.kualitas,
        sertifikasiKeberlanjutan:
            sertifikasiKeberlanjutan ?? this.sertifikasiKeberlanjutan,
        stok: stok ?? this.stok,
        category: category ?? this.category);
  }
}
