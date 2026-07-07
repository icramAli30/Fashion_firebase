import 'package:firebase_class/Screen/product_details_screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/const/all_sizes.dart';
import 'package:firebase_class/const/all_styles.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/services/cart_services.dart';
import 'package:firebase_class/services/products_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ProductScreen1 extends StatefulWidget {
  const ProductScreen1({super.key});

  @override
  State<ProductScreen1> createState() => _ProductScreen1State();
}

class _ProductScreen1State extends State<ProductScreen1> {
  final ProductsServices productsServices = ProductsServices();
  final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.whiteColors,
      appBar: AppBar(
        backgroundColor: AllColors.whiteColors,
        centerTitle: true,
        leading: Icon(Icons.menu),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset(
            'assets/images/svg/textimage.svg',
            height: 35,
          ),
        ),
        actions: [
          StreamBuilder(
            stream: cartServices.cartCount(),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;

              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      // Get.toNamed("/cart");
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
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
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 0.0,
          bottom: 8,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AllColors.whiteColors,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/images/svg/search.svg',
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Filter button action
                            },
                            icon: const Icon(Icons.mic, color: Colors.grey),
                          ),
                          hintText: 'Search',
                          hintStyle: AllStyles.titleTextStyles.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AllColors.secondaryColors,
                          ),
                          focusColor: AllColors.secondaryColors,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.0),

            // Ensure this is inside your Column
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: productsServices.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  final product = snapshot.data ?? [];

                  if (product.isEmpty) {
                    return const Center(child: Text("No Products Found"));
                  }

                  return MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return productItemView(product[index], index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Gidviewbuilder for fooditemview
  Widget productItemView(ProductModel product, int index) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.to(() => ProductDetailsScreen(product: product));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                product.image,
                height: index.isEven ? 180 : 260,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  height: 180,
                  child: Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),

            /// Product Name
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AllSizes.largeSizes,
                  color: AllColors.secondaryColors,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.discription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AllSizes.mediumSizes,
                  color: AllColors.secondaryColors,
                ),
              ),
            ),

            /// Price
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "৳ ${product.price}",
                style: TextStyle(
                  color: AllColors.primaryColors,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () async {
                  await cartServices.addtoCard(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product Cart Successfully")),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AllColors.primaryColors,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: AllColors.primaryColors,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: AllColors.primaryColors,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
