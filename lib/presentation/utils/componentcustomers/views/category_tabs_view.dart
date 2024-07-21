import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CategoryTabsView extends GetView {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTabsView({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : AppColors.tabsinactive,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.tabsinactive : AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
