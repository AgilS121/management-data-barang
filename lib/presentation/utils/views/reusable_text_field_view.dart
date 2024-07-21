import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableTextFieldView<T extends GetxController> extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final RxBool obscureText;
  final VoidCallback? onSuffixIconTap;

  ReusableTextFieldView({
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
    required this.isPassword,
    required this.obscureText,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        GetBuilder<T>(
          builder: (_) {
            return TextFormField(
              controller: controller,
              validator: validator,
              obscureText: isPassword ? obscureText.value : false,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(icon),
                suffixIcon: isPassword
                    ? GestureDetector(
                        onTap: onSuffixIconTap,
                        child: Icon(
                          obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
