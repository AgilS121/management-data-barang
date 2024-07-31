import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class ProductcardkeranjangcontrollerController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<String, int> quantities = <String, int>{}.obs;
  final RxInt paymentStep = 0.obs;
  final RxInt ongkir = 0.obs;
  var localAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi dengan data keranjang yang diteruskan dari layar sebelumnya
    var args = Get.arguments;
    if (args != null && args is List<Product>) {
      cartItems.assignAll(args);
      for (var item in cartItems) {
        quantities[item.id!] = item.stok ?? 1;
      }
    }
  }

  int get subTotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * getQuantity(item)));
  int get total => subTotal + ongkir.value;

  void increaseQuantity(Product product) {
    quantities[product.id!] = (quantities[product.id!] ?? 0) + 1;
    update();
  }

  void decreaseQuantity(Product product) {
    if ((quantities[product.id!] ?? 0) > 1) {
      quantities[product.id!] = quantities[product.id!]! - 1;
    } else {
      removeItem(product);
    }
    update();
  }

  void removeItem(Product product) {
    cartItems.remove(product);
    quantities.remove(product.id!);
    update();
  }

  int getQuantity(Product product) {
    return quantities[product.id!] ?? 0;
  }

  void nextStep() {
    if (paymentStep.value < 1) paymentStep.value++;
  }

  void previousStep() {
    if (paymentStep.value > 0) paymentStep.value--;
  }

  void calculateOngkir(String address) {
    // Hitung ongkir berdasarkan alamat
    ongkir.value = 55000; // Nilai contoh
  }
}
