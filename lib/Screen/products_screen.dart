import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/services/products_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductsServices productsServices = ProductsServices();

 // final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),

       /* actions: [
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
        ],*/
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
                  child: ListTile(
                    title: Text("${product[index].name}"),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
        
                      children: [
                        Image.network("${product[index].image}"),
        
                        Text(
                          "${product[index].discription}",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          "${product[index].price}",
                          style: TextStyle(color: Colors.red),
                        ),
        
                        SizedBox(height: 10),
        
                        /*GestureDetector(
                          onTap: () async {
                            await cartServices.addtoCard(productModel);
        
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Product Cart Successfully"),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),*/
                      ],
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