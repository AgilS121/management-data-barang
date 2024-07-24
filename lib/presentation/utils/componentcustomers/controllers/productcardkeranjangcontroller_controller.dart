import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class ProductcardkeranjangcontrollerController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<int, int> quantities = <int, int>{}.obs;
  final RxInt paymentStep = 0.obs;
  final RxInt ongkir = 0.obs;
  var localAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Contoh data
    cartItems.addAll([
      Product(id: "1", name: 'Kayu Alba', price: 900000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(id: "2", name: 'Kayu Jati', price: 1500000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(id: "3", name: 'Kayu Jati', price: 1500000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
      Product(id: "4", name: 'Kayu Jati', price: 1500000, image: [
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
        'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png'
      ]),
    ]);
    for (var item in cartItems) {
      quantities[int.parse(item.id!)] = 1;
    }
  }

  int get subTotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * getQuantity(item)));
  int get total => subTotal + ongkir.value;

  void increaseQuantity(Product product) {
    quantities[int.parse(product.id!)] = (quantities[product.id] ?? 0) + 1;
  }

  void decreaseQuantity(Product product) {
    if ((quantities[product.id] ?? 0) > 0) {
      quantities[int.parse(product.id!)] = quantities[product.id]! - 1;
      if (quantities[product.id] == 0) {
        removeItem(product);
      }
    }
  }

  void removeItem(Product product) {
    cartItems.remove(product);
    quantities.remove(product.id);
  }

  int getQuantity(Product product) {
    return quantities[product.id] ?? 0;
  }

  void nextStep() {
    if (paymentStep.value < 1) paymentStep.value++;
  }

  void previousStep() {
    if (paymentStep.value > 0) paymentStep.value--;
  }

  void calculateOngkir(String address) {
    // Calculate ongkir based on address
    ongkir.value = 55000; // Example value
  }
}
