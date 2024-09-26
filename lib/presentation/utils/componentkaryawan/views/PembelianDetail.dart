import 'package:dekaybaro/domain/models/PembelianModel.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';

class PurchaseDetailScreen extends StatelessWidget {
  final Purchase purchase;

  const PurchaseDetailScreen({required this.purchase, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Detail Penjualan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ReusableTextView(
                    text: purchase.userId,
                    sizetext: 16,
                    textcolor: AppColors.blacktext),
                ReusableTextView(
                    text: purchase.address,
                    sizetext: 16,
                    textcolor: AppColors.blacktext),
                SizedBox(height: 16),
                ...purchase.products.map((product) => Card(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: product.image.isNotEmpty
                            ? Image.network(product.image.first,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : null,
                        title: Text(product.name),
                        subtitle: Text('Rp ${product.price}'),
                        // trailing: Text('x${product.quantity}'),
                      ),
                    )),
                SizedBox(height: 16),
                if (purchase.sudahtransfer ?? true)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Pembeli belum mentransfer',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (purchase.sudahtransfer ?? true)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextButton(
                      onPressed: () {
                        // Show transfer proof
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: ReusableTextView(
                              text: "Bukti Transfer",
                              sizetext: 16,
                              textcolor: AppColors.blacktext,
                              fontWeight: FontWeight.bold,
                            ),
                            content: Image.network(
                                purchase.sudahtransfer.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Tutup'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: ReusableTextView(
                          text: "Lihat Bukti Transfer",
                          sizetext: 16,
                          textcolor: AppColors.blacktext),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableTextView(
                        text: "Total",
                        sizetext: 16,
                        textcolor: AppColors.blacktext),
                    ReusableTextView(
                        text: "Rp. ${purchase.total}",
                        sizetext: 16,
                        textcolor: AppColors.blacktext),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: purchase.sudahtransfer ?? true
                        ? () {
                            // Handle confirmation
                          }
                        : null,
                    child: ReusableTextView(
                        text: "Konfirmasi",
                        sizetext: 16,
                        textcolor: AppColors.whiteColor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
