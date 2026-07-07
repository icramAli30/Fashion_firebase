
import 'package:firebase_class/Screen/order_screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/models/cart_modelclass.dart';
import 'package:firebase_class/services/cart_services.dart';
import 'package:firebase_class/services/oder_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartServices cartServices = CartServices();
  final OrderServioce orderServioce = OrderServioce();

  List<CartModel> cartItems = [];
  var subtotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              await cartServices.clearCart();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<CartModel>>(
        stream: cartServices.getCartList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          cartItems = snapshot.data ?? [];
          if (cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Your Cart is Empty",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }

          // for (var item in cartItems) {
          //   subtotal += int.parse(item.price) * item.quantity;
          //
          // }


          subtotal = cartItems.fold(
            0,
                (total, item) => total + (int.parse(item.price) * item.quantity),
          );




          print("Cart Items Length : ${cartItems.length}");

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: cartItems.length,
                  itemBuilder: (_, index) {
                    var cartModel = cartItems[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                cartModel.image,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartModel.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    "৳ ${cartModel.price}",
                                    style:  TextStyle(
                                      color: AllColors.primaryColors,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          if (cartModel.quantity == 1) {
                                            await cartServices.removeCartItem(cartModel.id);
                                          } else {
                                            await cartServices.decrementQuanity(cartModel);
                                          }
                                        },
                                        icon: const Icon(Icons.remove_circle,color:Colors.black26),
                                      ),

                                      Text(
                                        "${cartModel.quantity}",
                                        style:  TextStyle(fontSize: 18),
                                      ),

                                      IconButton(
                                        onPressed: () async {
                                          await cartServices.incrementQuanity(cartModel);
                                        },
                                        icon: Icon(Icons.add_circle,color:Colors.black26),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              icon:Icon(
                                Icons.delete,
                                color:AllColors.primaryColors,
                              ),
                              onPressed: () async {
                                await cartServices.removeCartItem(cartModel.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Subtotal"),
                          Text(
                            "৳ $subtotal",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AllColors.primaryColors,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () async {
                        await orderServioce.checkoutFunction(cartItems);
                        await cartServices.clearCart();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderScreens(),
                          ),
                        );
                      },
                      child:Text(
                        "Order Now",
                        style: TextStyle(color:AllColors.whiteColors),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}