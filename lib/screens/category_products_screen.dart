import 'package:ecommerce_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../cart_cubit/cart_cubit.dart';
import '../cart_cubit/cart_state.dart';
import '../data/cart_model.dart';
import '../data/category_model.dart';
import '../product_cubit/product_cubit.dart';
import '../product_cubit/product_state.dart';
import 'cart_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final Category category;
  const CategoryProductsScreen({
    super.key,
    required this.category
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProductsByCategory(widget.category.slug,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.category.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.pink,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
            color: Colors.pink,
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
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state){
          if(state is ProductLoading){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          }

          if(state is ProductFailure){
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if(state is ProductSuccess){
            final products = state.products;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  final currentProduct = products[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(product: currentProduct),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shadowColor: Colors.pink[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        leading: Card(
                          elevation: 3,
                          shadowColor: Colors.pink[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                          color: Colors.white,
                          child: Image.network(
                            currentProduct.thumbnail,
                          ),
                        ),
                        title: Text(
                          currentProduct.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${currentProduct.price.toString()}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
