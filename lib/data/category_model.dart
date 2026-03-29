import 'package:hive_flutter/adapters.dart';
part 'category_model_g.dart';

@HiveType(typeId: 2)
class Category{
  @HiveField(0)
  final String slug;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  Category({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
        slug: json['slug'],
        name: json['name'],
        url: json['url'],
    );
  }
}
