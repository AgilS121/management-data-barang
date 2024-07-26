import 'dart:io';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DatakayuController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<int, int> quantities = <int, int>{}.obs;

  final AddProduct addProduct;
  final GetAllProducts getAllProducts;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final AddCategory addCategoryUseCase;
  final GetAllCategories getAllCategoriesUseCase;

  DatakayuController({
    required this.addProduct,
    required this.getAllProducts,
    required this.updateProduct,
    required this.deleteProduct,
    required this.addCategoryUseCase,
    required this.getAllCategoriesUseCase,
  });

  final RxBool isFavorite = false.obs;
  final RxList<Product> products = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isAddingNewCategory = false.obs;
  final RxString selectedCategory = ''.obs;

  // TextEditingController untuk input field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final RxList<XFile> imageFiles = <XFile>[].obs;
  final RxList<String> imageUrls = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchCategories();
  }

  void fetchAllProducts() {
    isLoading.value = true;
    errorMessage.value = '';

    getAllProducts().listen((result) {
      result.fold(
        (exception) {
          errorMessage.value = exception.toString();
          isLoading.value = false;
        },
        (productList) {
          products.value = productList;
          isLoading.value = false;
        },
      );
    }, onError: (error) {
      errorMessage.value = error.toString();
      isLoading.value = false;
    });
  }

  Future<void> addNewProduct() async {
    if (selectedCategory.value.isEmpty) {
      errorMessage.value = 'Kategori harus dipilih atau ditambahkan';
      return;
    }

    String category = selectedCategory.value;
    if (isAddingNewCategory.value) {
      category = newCategoryController.text;
      await addCategory(category);
    }

    List<String> imageUrls = await _uploadImages();
    Product newProduct = Product(
      name: nameController.text,
      price: int.parse(priceController.text),
      image: imageUrls,
      deskripsi: descriptionController.text,
      stok: int.parse(stockController.text),
      kualitas: qualityController.text,
      category: category,
    );

    final result = await addProduct(newProduct);
    result.fold(
      (exception) {
        errorMessage.value = exception.toString();
      },
      (product) {
        products.add(product);
        resetForm();
        Get.back();
      },
    );
  }

  void resetForm() {
    nameController.clear();
    descriptionController.clear();
    stockController.clear();
    qualityController.clear();
    priceController.clear();
    imageFiles.clear();
    selectedCategory.value = '';
    isAddingNewCategory.value = false;
  }

  Future<void> updateExistingProduct(Product product) async {
    isLoading.value = true;

    try {
      List<String> updatedImageUrls = [];
      if (imageFiles.isNotEmpty) {
        updatedImageUrls = await _uploadImages();
      } else {
        updatedImageUrls = product.image;
      }

      final updatedProduct = product.copyWith(
        name: nameController.text,
        deskripsi: descriptionController.text,
        stok: int.parse(stockController.text),
        kualitas: qualityController.text,
        price: int.parse(priceController.text),
        image: updatedImageUrls,
      );

      final result = await updateProduct(updatedProduct);
      result.fold(
        (exception) {
          errorMessage.value = exception.toString();
        },
        (updatedProduct) {
          int index = products.indexWhere((p) => p.id == updatedProduct.id);
          if (index != -1) {
            products[index] = updatedProduct;
            resetForm();
          }
          resetForm();
          Get.back();
        },
      );
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan saat mengupdate produk: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void fetchCategories() {
    getAllCategoriesUseCase().listen(
      (result) {
        result.fold(
          (exception) => errorMessage.value = exception.toString(),
          (fetchedCategories) {
            categories.value = fetchedCategories;
            if (!categories.contains('Tambah Kategori Baru')) {
              categories.add('Tambah Kategori Baru');
            }
          },
        );
      },
      onError: (error) {
        errorMessage.value = error.toString();
      },
    );
  }

  Future<void> addCategory(String category) async {
    final result = await addCategoryUseCase(category);
    result.fold(
      (exception) => errorMessage.value = exception.toString(),
      (_) => fetchCategories(),
    );
  }

  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];
    for (var imageFile in imageFiles) {
      String imageUrl = await uploadImageToStorage(imageFile);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<String> uploadImageToStorage(XFile imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('products/$fileName');
    final UploadTask uploadTask = storageRef.putFile(File(imageFile.path));
    final TaskSnapshot downloadUrl = await uploadTask;
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future<void> deleteProductById(String id) async {
    isLoading.value = true;

    final result = await deleteProduct(id);
    result.fold(
      (exception) {
        errorMessage.value = exception.toString();
      },
      (_) {
        products.removeWhere((product) => product.id == id);
        print("Produk dengan ID $id berhasil dihapus.");
      },
    );

    isLoading.value = false;
  }

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? selectedImages = await picker.pickMultiImage();

    if (selectedImages != null) {
      imageFiles.assignAll(selectedImages);
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}
