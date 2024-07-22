import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class HomeadminController extends GetxController {
  final RxList<String> categories =
      ['Semua', 'Kayu', 'Kayu', 'Kayu', 'Kayu'].obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    products.value = [
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
    ];
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    // Logika untuk memfilter produk berdasarkan kategori bisa ditambahkan di sini
  }
}
