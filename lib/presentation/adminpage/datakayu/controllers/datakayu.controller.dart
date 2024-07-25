import 'dart:io';
import 'package:dekaybaro/domain/models/ProductModel.dart';
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

  DatakayuController({
    required this.addProduct,
    required this.getAllProducts,
    required this.updateProduct,
    required this.deleteProduct,
  });

  final RxBool isFavorite = false.obs;
  final RxList<Product> product = <Product>[].obs;

  // TextEditingController untuk input field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final products = <Product>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final RxList<XFile> imageFiles = <XFile>[].obs;
  final RxList<String> imageUrls = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    isLoading.value = true;
    final result = await getAllProducts();
    result.fold(
      (exception) {
        errorMessage.value = exception.toString();
      },
      (productList) {
        products.value = productList;
      },
    );
    isLoading.value = false;
  }

  Future<void> addNewProduct() async {
    print("Tombol simpan diklik");
    isLoading.value = true;

    List<String> imageUrls = [];
    try {
      for (var imageFile in imageFiles) {
        String imageUrl = await uploadImageToStorage(imageFile);
        print("URL gambar: $imageUrl");
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print("Gagal mengunggah gambar: $e");
      errorMessage.value = 'Gagal mengunggah gambar: $e';
      isLoading.value = false;
      return;
    }

    try {
      Product newProduct = Product(
        name: nameController.text,
        price: int.parse(priceController.text),
        image: imageUrls,
        deskripsi: descriptionController.text,
        stok: int.parse(stockController.text),
        kualitas: qualityController.text,
        // ID tidak perlu diatur di sini, Firestore akan menghasilkannya
      );

      print("Data produk yang akan disimpan: ${newProduct.toJson()}");

      final result = await addProduct(newProduct);
      result.fold(
        (exception) {
          errorMessage.value = exception.toString();
          print("Gagal menyimpan produk: ${errorMessage.value}");
        },
        (product) {
          products.add(product);
          print(
              "Produk berhasil disimpan: ${product.name} dengan ID: ${product.id}");

          resetForm();
          Get.back();
        },
      );
    } catch (e) {
      print("Terjadi kesalahan saat menyimpan produk: $e");
      errorMessage.value = 'Terjadi kesalahan saat menyimpan produk: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    nameController.clear();
    descriptionController.clear();
    stockController.clear();
    qualityController.clear();
    priceController.clear();
    imageFiles.clear();
  }

  Future<void> updateExistingProduct(Product product) async {
    isLoading.value = true;

    List<String> updatedImageUrls = [];

    print("cek image 2 $imageUrls");

    try {
      if (imageFiles.isNotEmpty) {
        for (var imageFile in imageFiles) {
          String imageUrl = await uploadImageToStorage(imageFile);
          updatedImageUrls.add(imageUrl);
        }
      } else {
        updatedImageUrls = imageUrls;
      }

      final updatedProduct = product.copyWith(
        name: nameController.text,
        deskripsi: descriptionController.text,
        stok: int.parse(stockController.text),
        kualitas: qualityController.text,
        price: int.parse(priceController.text),
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
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan saat mengupdate produk: $e';
    } finally {
      isLoading.value = false;
    }
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
