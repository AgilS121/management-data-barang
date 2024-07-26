import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:get/get.dart';

class HomeadminController extends GetxController {
  final GetAllProducts getAllProducts;
  final GetAllCategories getAllCategories;

  HomeadminController({
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

enum StockFilter {
  all,
  zeroToMax,
  maxToZero,
  onlyZero,
}
