import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/models/AlamatModel.dart';
import 'package:dekaybaro/domain/models/PembelianModel.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/AlamatRepositories.dart';
import 'package:dekaybaro/domain/usecase/PembelianUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PembayaranController extends GetxController {
  final AddressRepository addressRepository;
  final AddPurchase createPurchaseUseCase;
  final GetPurchaseById getPurchaseByIdUseCase;
  final GetPurchases getAllPurchasesUseCase;
  final DeletePurchase deletePurchaseUseCase;

  final RxList<Product> cartItems = <Product>[].obs;
  final RxInt paymentStep = 0.obs;
  final RxDouble ongkir = 0.0.obs;
  final RxString localAddress = ''.obs;
  final RxString paymentMethod = ''.obs;
  final RxList<Address> addresses = <Address>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxBool isLoading = false.obs;

  double get subTotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * (item.stok ?? 1)));

  double get total => subTotal + ongkir.value;

  PembayaranController({
    required this.addressRepository,
    required this.createPurchaseUseCase,
    required this.getPurchaseByIdUseCase,
    required this.getAllPurchasesUseCase,
    required this.deletePurchaseUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null && args is List<Product>) {
      cartItems.assignAll(args);
    }
    fetchAddresses();
    loadUserData();
  }

  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.email ?? '';
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          user.value = UserEntity(
            id: userId,
            email: userData['email'] ?? 'No Email',
            name: userData['name'] ?? 'No Name',
            role: userData['role'] ?? 'customers',
          );
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String get userName => user.value?.name ?? 'User';
  String get userEmail => user.value?.email ?? 'example@gmail.com';

  void fetchAddresses() async {
    try {
      final fetchedAddresses = await addressRepository.getAddresses();
      addresses.assignAll(fetchedAddresses);
      if (fetchedAddresses.isNotEmpty) {
        localAddress.value = fetchedAddresses.first.street;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load addresses');
    }
  }

  void selectAddress(Address address) {
    localAddress.value = address.street;
  }

  void nextStep() {
    paymentStep.value = 1;
  }

  void selectPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  Future<void> makePayment() async {
    if (localAddress.isEmpty || paymentMethod.isEmpty) {
      Get.snackbar('Error', 'Please select an address and a payment method.');
      return;
    }

    try {
      final userId = userEmail; // Replace with actual method to get user ID
      final purchase = Purchase(
          userId: userId,
          products: cartItems.toList(),
          address: localAddress.value,
          paymentMethod: paymentMethod.value,
          subTotal: subTotal,
          ongkir: ongkir.value,
          total: total,
          date: DateTime.now().toString());

      await createPurchaseUseCase(purchase);
      Get.snackbar('Success', 'Payment successful!');
      cartItems.clear(); // Clear the cart after a successful purchase
      Get.toNamed("/konfirmasipembayaran");
      paymentStep.value = 0; // Reset the payment step
    } catch (e) {
      Get.snackbar('Error', 'Payment failed: $e');
    }
  }

  Future<Purchase?> getPurchase(String id) async {
    return await getPurchaseByIdUseCase(id);
  }

  Stream<List<Purchase>> getAllPurchases() {
    return getAllPurchasesUseCase();
  }

  Future<void> deletePurchase(String id) async {
    await deletePurchaseUseCase(id);
  }

  void setPaymentMethod(String method) {
    paymentMethod.value = method;
  }
}
