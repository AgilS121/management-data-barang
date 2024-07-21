import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WelcomeHeaderView extends GetView {
  final String name;

  const WelcomeHeaderView({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableTextView(
            text: "Selamat Datang, \n$name",
            sizetext: 22,
            textcolor: AppColors.coklat7,
            fontWeight: FontWeight.bold,
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
