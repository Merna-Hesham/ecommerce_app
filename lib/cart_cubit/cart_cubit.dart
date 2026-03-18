import 'package:ecommerce_app/cart_cubit/cart_state.dart';
import 'package:ecommerce_app/data/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../data/cart_model.dart';

class CartCubit extends Cubit<CartState>{
  final Box<Cart> cartBox;
  CartCubit(this.cartBox) : super(CartInitial());

  Future<void> loadCart() async{
    try{
      emit(CartLoading());
      final items = cartBox.values.toList();
      emit(CartLoaded(cartItems: items));
    }
    catch(e){
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> addToCart(Cart item) async{
    try{
      emit(CartLoading());
      await cartBox.add(item);
      final items = cartBox.values.toList();
      emit(CartLoaded(cartItems: items));
    }
    catch(e){
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> removeFromCart(int index) async{
    try{
      emit(CartLoading());
      await cartBox.deleteAt(index);
      final items = cartBox.values.toList();
      emit(CartLoaded(cartItems: items));
    }
    catch(e){
      emit(CartError(error: e.toString()));
    }
  }

  bool checkIfInCart(Product product) {
    return cartBox.values.any((cartItem) => cartItem.product.id == product.id);
  }

  Future<void> decreaseQuantity(int index) async{
    try {
      emit(CartLoading());
      final item = cartBox.getAt(index);
      if (item != null && item.quantity > 1) {
        item.quantity -= 1;
        await item.save();
      }
      final items = cartBox.values.toList();
      emit(CartLoaded(cartItems: items));
    }
    catch (e){
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> increaseQuantity(int index) async{
    try{
      emit(CartLoading());
      final item = cartBox.getAt(index);
      if (item != null) {
        item.quantity += 1;
        await item.save();
      }
      final items = cartBox.values.toList();
      emit(CartLoaded(cartItems: items));
    }
    catch (e){
      emit(CartError(error: e.toString()));
    }
  }

  int getTotalProducts(List<Cart> cartItems) {
    return cartItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  double getTotalPrice(List<Cart> cartItems) {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }
}
