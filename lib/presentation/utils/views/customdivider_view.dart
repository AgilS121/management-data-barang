import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomdividerView extends GetView {
  const CustomdividerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        Container(
          color: Colors.white, // or whatever color the background is
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Atau Gunakan'),
        ),
      ],
    );
  }
}
