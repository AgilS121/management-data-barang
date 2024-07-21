import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReusableButtonView extends StatelessWidget {
  final String text;
  final double sizetext;
  final Color colorbg;
  final Color colorfe;
  final Color textcolor;
  final VoidCallback? onPressed;
  final double widthbutton;

  const ReusableButtonView({
    required this.text,
    required this.sizetext,
    required this.colorbg,
    required this.colorfe,
    required this.textcolor,
    required this.onPressed,
    required this.widthbutton,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthbutton,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust border radius here
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 15.h,
          ),
          textStyle: TextStyle(fontSize: 18.sp),
          foregroundColor: colorfe,
          backgroundColor: colorbg,
          side: BorderSide(color: AppColors.brownColor),
        ),
        child: ReusableTextView(
          text: text,
          sizetext: sizetext,
          textcolor: textcolor,
        ),
      ),
    );
  }
}
