import 'dart:convert';
import 'package:ecommerce_app/data/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService{
  final String baseUrl = 'https://dummyjson.com/';
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('${baseUrl}products'));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      List products = data['products'];
      return products.map((p) => Product.fromJson(p)).toList();
    }
    else {
      throw Exception('Failed to load products');
    }
  }
}
