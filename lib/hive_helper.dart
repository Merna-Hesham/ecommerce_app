import 'package:ecommerce_app/data/cart_model.dart';
import 'package:hive/hive.dart';

class HiveHelper{
  static const String _boxName = 'cartBox';
  static Box<Cart> get _box => Hive.box<Cart>(_boxName);

}
