import 'package:ecommerce_app/data/product_model.dart';
import 'package:ecommerce_app/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/product_service.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'cart_cubit/cart_cubit.dart';
import 'data/cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartAdapter());
  final cartBox = await Hive.openBox<Cart>('cartBox');
  runApp(MyApp(cartBox: cartBox,));
}

class MyApp extends StatelessWidget {
  final service = ProductService();
  final Box<Cart> cartBox;
  MyApp({super.key, required this.cartBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(
              create: (_) => ProductCubit(service)..fetchProducts()
          ),
          BlocProvider<CartCubit>(
            create: (_) => CartCubit(cartBox)..loadCart()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        )
    );
  }
}
