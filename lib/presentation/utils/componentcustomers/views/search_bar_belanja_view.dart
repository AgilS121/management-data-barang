import 'package:dekaybaro/presentation/customerpage/belanja/controllers/belanja.controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchBarBelanjaView extends GetView<BelanjaController> {
  const SearchBarBelanjaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: (query) =>
            controller.updateSearchQuery(query), // Update search query
        decoration: InputDecoration(
          hintText: 'Cari Barang',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
