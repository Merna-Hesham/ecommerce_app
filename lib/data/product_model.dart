class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final List images;
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
