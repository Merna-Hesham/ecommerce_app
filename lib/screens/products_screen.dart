import 'package:ecommerce_app/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_app/product_cubit/product_cubit.dart';
import 'package:ecommerce_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../cart_cubit/cart_state.dart';
import '../data/cart_model.dart';
import '../product_cubit/product_state.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Shopify',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Products',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
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
                      return BlocBuilder<CartCubit, CartState>(
                        builder: (context, cartState) {
                          if (cartState is CartLoaded) {
                            return GridView.builder(
                              itemCount: products.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 0.72,
                              ),
                              itemBuilder: (context, index){
                                final currentProduct = products[index];
                                bool isInCart = context.read<CartCubit>().checkIfInCart(currentProduct);
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailsScreen(product: currentProduct,),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shadowColor: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(6),
                                    ),
                                    child: Column(
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusGeometry.circular(6),
                                          ),
                                          child: Image.network(
                                            currentProduct.thumbnail,
                                            height: 120,
                                            width: 200,
                                          ),
                                        ),

                                        Card(
                                          elevation: 3,
                                          shadowColor: Colors.pink[700],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusGeometry.circular(6),
                                          ),
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  currentProduct.title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 2,
                                                ),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '\$${currentProduct.price.toString()}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.green[800],
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),

                                                    RatingStars(
                                                      value: currentProduct.rating,
                                                      valueLabelVisibility: false,
                                                      starColor: Colors.yellow,
                                                      starSize: 16,
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 10,
                                                ),

                                                ElevatedButton(
                                                  onPressed: (){
                                                    if(!isInCart){
                                                      context.read<CartCubit>().addToCart(Cart(product: currentProduct, quantity: 1));
                                                      setState(() {
                                                        isInCart = true;
                                                      });
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: isInCart? Colors.pink[300] : Colors.pink,
                                                    animationDuration: Duration(
                                                      seconds: 3,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadiusGeometry.circular(10),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        isInCart? Icons.shopping_basket : Icons.add_shopping_cart_rounded,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),

                                                      SizedBox(
                                                        width: 4,
                                                      ),

                                                      Text(
                                                        isInCart? 'In Cart' : 'Add To Cart',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return SizedBox();
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
