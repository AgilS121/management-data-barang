import 'package:dekaybaro/domain/entities/StockFilter.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:get/get.dart';

class BelanjaController extends GetxController {
  final GetAllProducts getAllProducts;
  final GetAllCategories getAllCategories;

  BelanjaController({
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

  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToCategories();
    _listenToProductChanges();
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
    filterProductsByCategoryAndStock();
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
