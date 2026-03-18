import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../cart_cubit/cart_cubit.dart';
import '../cart_cubit/cart_state.dart';
import '../data/cart_model.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({
    super.key,
    required this.product
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int productQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    bool isInCart = context.read<CartCubit>().checkIfInCart(product);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          product.title,
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
        child: Column(
          children: [
            Card(
              elevation: 5,
              shadowColor: Colors.pink[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              color: Colors.white,
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  items: product.images.map(
                        (url){
                      return Image.network(url);
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                  ),
                ),
              ),
            ),

            Card(
              elevation: 5,
              shadowColor: Colors.pink[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              color: Colors.white,
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        color: Colors.pink[800],
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 6,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.pink[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      product.description,
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontSize: 22,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                color: Colors.pink[600],
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              height: 4,
                            ),

                            Text(
                              '\$${product.price}',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rating',
                              style: TextStyle(
                                color: Colors.pink[600],
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              height: 4,
                            ),

                            RatingStars(
                              value: product.rating,
                              valueLabelColor: Colors.orangeAccent,
                              valueLabelTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              starColor: Colors.yellow,
                              starSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                            color: Colors.pink[600],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Card(
                          elevation: 3,
                          shadowColor: Colors.pink[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                          color: Colors.white,
                          child:
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.pink[50],
                                  child: IconButton(
                                    onPressed: (){
                                      if(productQuantity > 1){
                                        productQuantity -= 1;
                                        setState(() {});
                                      }
                                    },
                                    icon: Icon(
                                      Icons.minimize,
                                      color: Colors.pink,
                                      size: 24,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 4,
                                ),

                                Text(
                                  productQuantity.toString(),
                                  style: TextStyle(
                                    color: Colors.pink[600],
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(
                                  width: 4,
                                ),

                                CircleAvatar(
                                  backgroundColor: Colors.pink[50],
                                  child: IconButton(
                                    onPressed: (){
                                      productQuantity += 1;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.pink,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              elevation: 5,
              shadowColor: Colors.pink[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              color: Colors.white,
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(
                  onPressed: (){
                    if(!isInCart){
                      context.read<CartCubit>().addToCart(Cart(product: product,quantity: productQuantity));
                      setState(() {
                        isInCart = true ;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInCart? Colors.pink[300] : Colors.pink,
                    animationDuration: Duration(
                      seconds: 3
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isInCart? Icons.shopping_basket : Icons.add_shopping_cart_rounded,
                          size: 26,
                          color: Colors.white,
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Text(
                          isInCart? 'In Cart' : 'Add To Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
