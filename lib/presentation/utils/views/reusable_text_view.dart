import 'package:flutter/material.dart';

class ReusableTextView extends StatelessWidget {
  final String text;
  final double sizetext;
  final Color textcolor;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const ReusableTextView({
    required this.text,
    required this.sizetext,
    required this.textcolor,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Sansation',
        fontSize: sizetext,
        fontWeight: fontWeight,
        color: textcolor,
      ),
    );
  }
}
