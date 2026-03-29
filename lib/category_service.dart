import 'dart:convert';
import 'package:ecommerce_app/data/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService{
  final String baseUrl = 'https://dummyjson.com/products/';
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}categories'));
    if(response.statusCode == 200){
      final List categories = jsonDecode(response.body);
      return categories.map((c) => Category.fromJson(c)).toList();
    }
    else{
      throw Exception('Failed to load categories');
    }
  }
}
