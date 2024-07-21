import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class SemuaProductController extends GetxController {
  //TODO: Implement SemuaProductController
  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    products.value = [
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
      Product(name: 'Kayu Alba', price: 900000, image: ['404']),
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
