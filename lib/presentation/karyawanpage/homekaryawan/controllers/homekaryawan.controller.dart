import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/StockFilter.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/models/PembelianModel.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomekaryawanController extends GetxController {
  final GetAllProducts getAllProducts;
  final GetAllCategories getAllCategories;

  HomekaryawanController({
    required this.getAllProducts,
    required this.getAllCategories,
  });

  final RxList<String> categories = <String>[].obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<StockFilter> selectedStockFilter = StockFilter.all.obs;
  final RxInt maxStock = 0.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<Purchase> purchases = <Purchase>[].obs;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = ''.obs;

  RxInt currentTab = 0.obs;

  void changeTab(int index) {
    currentTab.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    _listenToCategories();
    _listenToProductChanges();
    loadUserData();
    _fetchPurchases();
  }

  Future<void> _fetchPurchases() async {
    isLoading.value = true;
    try {
      QuerySnapshot snapshot = await _firestore.collection('purchases').get();
      List<Purchase> purchaseList = snapshot.docs.map((doc) {
        return Purchase.fromSnapshot(doc);
      }).toList();

      // Fetch user names
      for (var purchase in purchaseList) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(purchase.userId).get();
        if (userSnapshot.exists) {
          purchase.userName = userSnapshot['name'];
          purchase.image = userSnapshot['imageUrl'];
        }
      }

      purchases.value = purchaseList;
    } catch (e) {
      print('Error fetching purchases: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 5) {
      return 'Selamat tengah malam';
    } else if (hour < 12) {
      return 'Selamat pagi';
    } else if (hour < 15) {
      return 'Selamat siang';
    } else if (hour < 18) {
      return 'Selamat sore';
    } else {
      return 'Selamat malam';
    }
  }

  Future<void> loadUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.email ?? '';
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          name.value = userData['name'] ?? 'No Name';
          email.value = userData['email'] ?? 'No Email';
          imageUrl.value = userData['imageUrl'] ?? '';
          user.value = UserEntity(
            id: userId,
            email: email.value,
            name: name.value,
            role: userData['role'] ?? 'customers',
          );
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  void _listenToCategories() {
    getAllCategories().listen((result) {
      result.fold(
        (exception) {
          print(exception.toString());
        },
        (categoryList) {
          categories.value = ['Semua', ...categoryList];
        },
      );
    });
  }

  void _listenToProductChanges() {
    getAllProducts().listen((result) {
      result.fold(
        (exception) {
          errorMessage.value = exception.toString();
          print("Error loading products: ${exception.toString()}");
        },
        (productList) {
          allProducts.value = productList;
          maxStock.value = _getMaxStock(productList);
          print("data maks stok ${maxStock.value}");
          filterProductsByCategoryAndStock();
        },
      );
    });
  }

  int _getMaxStock(List<Product> products) {
    return products.isNotEmpty
        ? products.map((p) => p.stok!).reduce((a, b) => a > b ? a : b)
        : 0;
  }

  void filterProductsByCategoryAndStock() {
    List<Product> filtered = [];

    if (selectedCategoryIndex.value == 0) {
      filtered = allProducts;
    } else {
      final selectedCategory = categories[selectedCategoryIndex.value];
      filtered = allProducts.where((product) {
        return product.category == selectedCategory;
      }).toList();
    }

    filteredProducts.value = filtered.where((product) {
      switch (selectedStockFilter.value) {
        case StockFilter.zeroToMax:
          return true; // Tidak ada penyaringan khusus, tampilkan semua
        case StockFilter.maxToZero:
          return true; // Tidak ada penyaringan khusus, tampilkan semua
        case StockFilter.onlyZero:
          return product.stok == 0;
        default:
          return true;
      }
    }).toList();

    if (selectedStockFilter.value == StockFilter.zeroToMax) {
      filteredProducts.sort((a, b) => a.stok!.compareTo(b.stok!));
    } else if (selectedStockFilter.value == StockFilter.maxToZero) {
      filteredProducts.sort((a, b) => b.stok!.compareTo(a.stok!));
    }

    print("Filtered products count: ${filteredProducts.length}");
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    filterProductsByCategoryAndStock();
  }

  void selectStockFilter(StockFilter filter) {
    selectedStockFilter.value = filter;
    filterProductsByCategoryAndStock();
  }
}
