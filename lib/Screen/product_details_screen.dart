import 'package:firebase_class/Screen/cart_Screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  ProductDetailsScreen({super.key, required this.product});
  final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(),
        title: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset(
            'assets/images/svg/textimage.svg',
            height: 35,
          ),
        ),
        actions: [
          Icon(Icons.favorite_border, color: AllColors.primaryColors, size: 30),
          SizedBox(width: 15),

          StreamBuilder(
            stream: cartServices.cartCount(),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;

              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                    icon: Icon(Icons.shopping_cart_outlined, size: 30),
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

      bottomNavigationBar: Container(
        height: 75,
        padding: EdgeInsets.all(10),
        color: AllColors.whiteColors,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AllColors.primaryColors,
                    width: 2,
                  ),
                ),
                onPressed: () async {
                  await cartServices.addtoCard(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Product Cart Successfully"),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                  color: AllColors.primaryColors,
                ),
                label: Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: AllColors.primaryColors,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AllColors.primaryColors,
                ),
                onPressed: () {},
                child: Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 18, color: AllColors.whiteColors),
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.network(
                product.image,
                width: double.infinity,
                height: 320,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 10),

            Container(
              color: AllColors.whiteColors,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Text(
                        "৳ ${product.price}",
                        style: TextStyle(
                          color: AllColors.primaryColors,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "৳1200",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16,
                          color: AllColors.secondaryColors.withValues(
                            alpha: 8.0,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Divider(),

                  ListTile(
                    leading: Icon(
                      Icons.local_shipping,
                      color: AllColors.primaryColors,
                      size: 30,
                    ),
                    title: Text(
                      "Free Delivery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Inside Dhaka",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                   Divider(),

                   Text(
                    "Product Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.discription,
                    style: const TextStyle(fontSize: 16, height: 1.5,fontWeight:FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
