import 'package:ecommerce_app/screens/categories_screen.dart';
import 'package:ecommerce_app/screens/products_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 2;
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
          'Profile',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              builder: (context) => screens[index],
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
          'Profile Screen',
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
