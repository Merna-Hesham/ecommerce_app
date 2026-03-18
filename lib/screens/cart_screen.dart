import 'package:ecommerce_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart_cubit/cart_cubit.dart';
import '../cart_cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state){
                  if(state is CartLoading){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink,
                      ),
                    );
                  }

                  if(state is CartError){
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

                  if(state is CartLoaded){
                    int totalProducts = context.read<CartCubit>().getTotalProducts(state.cartItems);
                    double totalPrice = context.read<CartCubit>().getTotalPrice(state.cartItems);

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.cartItems.length,
                              itemBuilder: (context, index){
                                final currentItem = state.cartItems[index];
                                final currentProduct = currentItem.product;
                                final currentProductPrice = currentProduct.price * currentItem.quantity;

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
                                                            if(currentItem.quantity > 1){
                                                              context.read<CartCubit>().decreaseQuantity(index);
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.minimize,
                                                            color: Colors.pink,
                                                            size: 18,
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 6,
                                                      ),

                                                      Text(
                                                        currentItem.quantity.toString(),
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
                                                            context.read<CartCubit>().increaseQuantity(index);
                                                          },
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.pink,
                                                            size: 18,
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
                                            'Total Price: \$${currentProductPrice.toStringAsFixed(2)}',
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
                                          context.read<CartCubit>().removeFromCart(index);
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
                              },
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
                                ),
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
                                'Total Price: ${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
