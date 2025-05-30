import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_list/model/productsmodel.dart';

class Productscreencontroller with ChangeNotifier {
  List<ProductModel>? resobj;
  bool isLoadingProducts = false;

  Future<void> getFacts() async {
    final url = Uri.parse("https://dummyjson.com/products");
    isLoadingProducts = true;
    notifyListeners();

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final productsResponse = productsResponseFromJson(response.body);
        resobj = productsResponse.products;
      } else {
        print("Failed to load products: ${response.statusCode}");
        resobj = null;
      }
    } catch (e) {
      print("Error fetching products: $e");
      resobj = null;
    }

    isLoadingProducts = false;
    notifyListeners();
  }
}
