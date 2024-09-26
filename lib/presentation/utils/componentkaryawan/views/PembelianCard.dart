import 'package:dekaybaro/domain/models/PembelianModel.dart';
import 'package:flutter/material.dart';

class PurchaseCard extends StatelessWidget {
  final Purchase purchase;
  final String userName;
  final String image;
  final VoidCallback onTap;

  const PurchaseCard(
      {required this.purchase,
      required this.userName,
      required this.image,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, // Use userName instead of purchase.userId
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    'Rp. ${purchase.total.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    (purchase.sudahtransfer == true) ? "Sudah" : "Belum",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
