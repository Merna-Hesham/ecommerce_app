import '../data/cart_model.dart';

abstract class CartState{}

class CartInitial extends CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  final List<Cart> cartItems;
  CartLoaded({required this.cartItems});
}

class CartError extends CartState{
  final String error;
  CartError({required this.error});
}
