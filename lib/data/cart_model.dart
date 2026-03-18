import 'package:hive/hive.dart';
import 'product_model.dart';
part 'cart_model_g.dart';

@HiveType(typeId: 1)
class Cart extends HiveObject {
  @HiveField(0)
  final Product product;

  @HiveField(1)
  int quantity;

  Cart({
    required this.product,
    required this.quantity,
  });
}
