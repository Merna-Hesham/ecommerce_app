import 'package:ecommerce_app/cart_product.dart';
import 'package:ecommerce_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int totalProducts = cartProducts.fold(
    0,
    (sum, item) => sum + item.quantity,
  );

  late double totalPrice = cartProducts.fold(
    0.0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: 32,
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
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index){
                  final currentProduct = cartProducts[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(product: currentProduct.product),
                        )
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
                            currentProduct.product.thumbnail,
                          ),
                        ),
                        title: Text(
                          currentProduct.product.title,
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
                                  'Quantity:',
                                  style: TextStyle(
                                    color: Colors.pink[400],
                                    fontSize: 18,
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
                                          radius: 16,
                                          backgroundColor: Colors.pink[50],
                                          child: IconButton(
                                            onPressed: (){
                                              if(currentProduct.quantity > 1){
                                                currentProduct.quantity -= 1;
                                                setState(() {
                                                  totalProducts= cartProducts.fold(
                                                    0,
                                                        (sum, item) => sum + item.quantity,
                                                  );

                                                  totalPrice = cartProducts.fold(
                                                    0.0,
                                                        (sum, item) => sum + (item.product.price * item.quantity),
                                                  );
                                                });
                                              }
                                            },
                                            icon: Icon(
                                                Icons.minimize,
                                                color: Colors.pink,
                                                size: 18
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 6,
                                        ),

                                        Text(
                                          currentProduct.quantity.toString(),
                                          style: TextStyle(
                                            color: Colors.pink[600],
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(
                                          width: 6,
                                        ),

                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.pink[50],
                                          child: IconButton(
                                            onPressed: (){
                                              currentProduct.quantity += 1;
                                              setState(() {
                                                totalProducts= cartProducts.fold(
                                                  0,
                                                      (sum, item) => sum + item.quantity,
                                                );

                                                totalPrice = cartProducts.fold(
                                                  0.0,
                                                      (sum, item) => sum + (item.product.price * item.quantity),
                                                );
                                              });
                                            },
                                            icon: Icon(
                                                Icons.add,
                                                color: Colors.pink,
                                                size: 18
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              'Total Price: \$${currentProduct.product.price * currentProduct.quantity}',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            cartProducts.remove(currentProduct);
                            setState(() {
                              totalProducts= cartProducts.fold(
                                0,
                                    (sum, item) => sum + item.quantity,
                              );

                              totalPrice = cartProducts.fold(
                                0.0,
                                    (sum, item) => sum + (item.product.price * item.quantity),
                              );
                            });
                          },
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            size: 26,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),

            Card(
              elevation: 3,
              shadowColor: Colors.pink[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total no. of products: $totalProducts',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ),

            Card(
              elevation: 3,
              shadowColor: Colors.pink[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Total Price: $totalPrice',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
