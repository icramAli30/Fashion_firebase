import 'package:firebase_class/Screen/cart_Screen.dart';
import 'package:firebase_class/Screen/product_details_screen.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/services/cart_services.dart';
import 'package:firebase_class/services/products_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductsServices productsServices= ProductsServices();

 final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),

        actions: [
          StreamBuilder(
            stream: cartServices.cartCount(),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;

              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartScreen()),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  Positioned(
                    child: Text(
                      "${count}",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<ProductModel>>(
          stream: productsServices.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
        
            final product = snapshot.data ?? [];
        
            print(" Length ${product.length }");
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: product.length,
              itemBuilder: (_, index) {
                var productModel = product[index];

                return Card(
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ProductDetailsScreen(product: productModel));
                    },
                    child: ListTile(
                      title: Text(productModel.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(productModel.image),

                          Text(
                            productModel.discription,
                            style:  TextStyle(color: Colors.red),
                          ),

                          Text(
                            "${productModel.price}",
                            style: const TextStyle(color: Colors.red),
                          ),

                          const SizedBox(height: 10),

                          GestureDetector(
                            onTap: () async {
                              await cartServices.addtoCard(productModel);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Product Cart Successfully"),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}