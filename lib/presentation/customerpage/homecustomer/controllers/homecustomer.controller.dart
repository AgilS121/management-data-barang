import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/StockFilter.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomecustomerController extends GetxController {
  final GetAllProducts getAllProducts;
  final GetAllCategories getAllCategories;

  HomecustomerController({
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

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToCategories();
    _listenToProductChanges();
    loadUserData();
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

  void filterCategories() {
    final Set<String> categoriesWithProducts = allProducts
        .map((product) => product.category)
        .where((category) => category != null && category.isNotEmpty)
        .cast<String>()
        .toSet();

    categories.value = ['Semua', ...categoriesWithProducts];
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
          filterCategories(); // Tambahkan ini
          filterProductsByCategoryStockAndSearch();
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

    // Filter produk berdasarkan kategori
    if (selectedCategoryIndex.value == 0) {
      filtered = allProducts;
    } else {
      final selectedCategory = categories[selectedCategoryIndex.value];
      filtered = allProducts.where((product) {
        return product.category == selectedCategory;
      }).toList();
    }

    // Filter produk berdasarkan stok
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

    // Urutkan produk berdasarkan stok jika diperlukan
    if (selectedStockFilter.value == StockFilter.zeroToMax) {
      filteredProducts.sort((a, b) => a.stok!.compareTo(b.stok!));
    } else if (selectedStockFilter.value == StockFilter.maxToZero) {
      filteredProducts.sort((a, b) => b.stok!.compareTo(a.stok!));
    }

    // Perbarui kategori berdasarkan produk yang ada
    updateVisibleCategories();

    print("Filtered products count: ${filteredProducts.length}");
  }

  void updateVisibleCategories() {
    final Set<String> categoriesWithProducts = allProducts
        .map((product) => product.category)
        .where((category) => category != null && category.isNotEmpty)
        .cast<String>()
        .toSet();

    // Include 'Semua' and only categories that have products
    categories.value = ['Semua', ...categoriesWithProducts];

    // If the selected category is not visible anymore, select 'Semua'
    if (selectedCategoryIndex.value > 0 &&
        !categoriesWithProducts
            .contains(categories[selectedCategoryIndex.value])) {
      selectedCategoryIndex.value = 0;
    }

    filterProductsByCategoryStockAndSearch();
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    filterProductsByCategoryStockAndSearch();
  }

  void selectStockFilter(StockFilter filter) {
    selectedStockFilter.value = filter;
    filterProductsByCategoryAndStock();
  }

  void filterProductsByCategoryStockAndSearch() {
    List<Product> filtered = [];

    if (selectedCategoryIndex.value == 0) {
      filtered = allProducts;
    } else {
      final selectedCategory = categories[selectedCategoryIndex.value];
      filtered = allProducts.where((product) {
        return product.category == selectedCategory;
      }).toList();
    }

    filtered = filtered.where((product) {
      final matchesSearchQuery = searchQuery.value.isEmpty ||
          product.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesStockFilter = _applyStockFilter(product);

      return matchesSearchQuery && matchesStockFilter;
    }).toList();

    filteredProducts.value = filtered;

    if (selectedStockFilter.value == StockFilter.zeroToMax) {
      filteredProducts.sort((a, b) => a.stok!.compareTo(b.stok!));
    } else if (selectedStockFilter.value == StockFilter.maxToZero) {
      filteredProducts.sort((a, b) => b.stok!.compareTo(a.stok!));
    }

    filterCategories(); // Tambahkan ini untuk memastikan kategori selalu diperbarui

    print("Filtered products count: ${filteredProducts.length}");
  }

  bool _applyStockFilter(Product product) {
    switch (selectedStockFilter.value) {
      case StockFilter.zeroToMax:
        return true;
      case StockFilter.maxToZero:
        return true;
      case StockFilter.onlyZero:
        return product.stok == 0;
      default:
        return true;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProductsByCategoryStockAndSearch();
  }
}
