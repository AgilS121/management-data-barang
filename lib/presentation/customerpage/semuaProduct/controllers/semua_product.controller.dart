import 'package:dekaybaro/domain/entities/StockFilter.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:get/get.dart';

class SemuaProductController extends GetxController {
  final GetAllProducts getAllProducts;
  final GetAllCategories getAllCategories;

  SemuaProductController({
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

          // Set filteredProducts to allProducts to show all products
          filteredProducts.value = allProducts;
        },
      );
    });
  }

  int _getMaxStock(List<Product> products) {
    return products.isNotEmpty
        ? products.map((p) => p.stok!).reduce((a, b) => a > b ? a : b)
        : 0;
  }

  void selectCategory(int index) {
    // Update the selected category index
    selectedCategoryIndex.value = index;

    // Set filteredProducts to allProducts to show all products
    filteredProducts.value = allProducts;
  }

  void selectStockFilter(StockFilter filter) {
    // Update the selected stock filter
    selectedStockFilter.value = filter;

    // Set filteredProducts to allProducts to show all products
    filteredProducts.value = allProducts;
  }
}
