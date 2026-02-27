import 'package:ecommerce_app/data/product_model.dart';

class Cart{
  final Product product;
  int quantity;

  Cart({
    required this.product,
    required this.quantity,
  });
}
