import 'package:hive/hive.dart';
part 'product_model_g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final double rating;

  @HiveField(6)
  final List images;

  @HiveField(7)
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.images,
    required this.thumbnail
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        price: json['price'].toDouble(),
        rating: json['rating'].toDouble(),
        images: json['images'],
        thumbnail: json['thumbnail']
    );
  }
}
