import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class BelanjaController extends GetxController {
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
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
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
