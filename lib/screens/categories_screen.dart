import 'package:ecommerce_app/screens/products_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart_cubit/cart_cubit.dart';
import '../cart_cubit/cart_state.dart';
import 'cart_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int currentIndex = 1;
  final List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state){
                if(state is CartLoaded){
                  int totalProducts = context.read<CartCubit>().getTotalProducts(state.cartItems);

                  return IconButton(
                    onPressed: ()=>{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ),
                      )
                    },
                    icon: Badge.count(
                      backgroundColor: Colors.pinkAccent,
                      textColor: Colors.white,
                      isLabelVisible: (totalProducts == 0)? false : true,
                      count: totalProducts,
                      child: Icon(
                        Icons.shopping_basket,
                        size: 32,
                        color: Colors.pink,
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.pinkAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        onTap: (index){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => screens[currentIndex],
            ),
          );
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.pink,
              size: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
              color: Colors.pink,
              size: 28,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.pink,
              size: 28,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Categories Screen',
          style: TextStyle(
            fontSize: 30,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
