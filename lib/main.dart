import 'package:ecommerce_app/category_cubit/category_cubit.dart';
import 'package:ecommerce_app/category_service.dart';
import 'package:ecommerce_app/data/category_model.dart';
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
  Hive.registerAdapter(CategoryAdapter());
  final cartBox = await Hive.openBox<Cart>('cartBox');
  runApp(MyApp(cartBox: cartBox,));
}

class MyApp extends StatelessWidget {
  final productService = ProductService();
  final Box<Cart> cartBox;
  final categoryService = CategoryService();
  MyApp({super.key, required this.cartBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(
              create: (_) => ProductCubit(productService)..fetchProducts()
          ),
          BlocProvider<CartCubit>(
            create: (_) => CartCubit(cartBox)..loadCart()
          ),
          BlocProvider<CategoryCubit>(
              create: (_) => CategoryCubit(categoryService)..fetchCategories()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        )
    );
  }
}
