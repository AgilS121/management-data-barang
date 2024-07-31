import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class ProductdetailController extends GetxController {
  final AddToCart addToCartUseCase;
  final GetCartItemsStream getCartItemsUseCase;
  final GetCartItemsStreamwhereuser getCartItemsStreamwhereuser;
  late var _splitScreenMode = false;

  StreamSubscription<List<Product>>? _cartSubscription;

  ProductdetailController(
      {required this.addToCartUseCase,
      required this.getCartItemsUseCase,
      required this.getCartItemsStreamwhereuser});

  final Rx<Product> product = Rx<Product>(Product(
    name: '',
    price: 0,
    image: [],
    adalahKayuGelondongan: false,
    jenisKayu: '',
    kualitas: '',
    deskripsi: '',
  ));
  final selectedImageIndex = 0.obs;
  final isFavorite = false.obs;
  final isAddingToCart = false.obs;
  final cartItemCount = 0.obs;
  final quantity = 1.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProductData();
    _subscribeToCartChanges();
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

  void _loadProductData() {
    var args = Get.arguments;
    if (args is Product) {
      product.value = args;
    } else {
      print('Error: Expected Product object as argument');
      product.value = Product(
        name: 'Unknown',
        price: 0,
        image: [],
        adalahKayuGelondongan: false,
        jenisKayu: 'Unknown',
        kualitas: 'Unknown',
        deskripsi: 'No description available',
      );
    }
  }

  void _subscribeToCartChanges() {
    final currentEmail = _auth.currentUser?.email ?? '';
    _cartSubscription =
        getCartItemsStreamwhereuser(currentEmail).listen((cartItems) {
      cartItemCount.value = cartItems.length;
    }, onError: (error) {
      print('Error listening to cart changes: $error');
    });
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // TODO: Implement logic to save favorite status
  }

  Future<void> addToCart() async {
    isAddingToCart.value = true;
    try {
      await addToCartUseCase(product.value, quantity.value, userEmail);
      Get.snackbar(
        'Sukses',
        'Produk ditambahkan ke keranjang',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menambahkan produk ke keranjang',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isAddingToCart.value = false;
    }
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }

  @override
  void onClose() {
    _cartSubscription?.cancel();
    super.onClose();
  }
}
