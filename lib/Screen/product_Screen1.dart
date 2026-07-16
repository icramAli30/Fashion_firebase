import 'package:firebase_class/Screen/product_details_screen.dart';
import 'package:firebase_class/Screen/profile_screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/const/all_sizes.dart';
import 'package:firebase_class/const/all_styles.dart';
import 'package:firebase_class/models/Products_modelclass.dart';
import 'package:firebase_class/models/User_modelclass.dart';
import 'package:firebase_class/services/cart_services.dart';
import 'package:firebase_class/services/products_services.dart';
import 'package:firebase_class/services/profile_services.dart';
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
  final TextEditingController searchController = TextEditingController();
  final ProfileService profileService = ProfileService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.whiteColors,
      appBar: AppBar(
        backgroundColor: AllColors.whiteColors,
        centerTitle: true,
        leading: Icon(Icons.menu),
        title: Padding(
          padding:  EdgeInsets.only(top: 8.0),
          child: SvgPicture.asset(
            'assets/images/svg/textimage.svg',
            height: 35,
          ),
        ),
        actions: [
          StreamBuilder<UserModel>(
            stream: profileService.getProfileStream(),
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return  Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                );
              }

              final user = snapshot.data!;

              return Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() =>  ProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: user.image.isNotEmpty
                        ? NetworkImage(user.image)
                        : null,
                    child: user.image.isEmpty
                        ? Icon(Icons.person)
                        : null,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(
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
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding:  EdgeInsets.only(top: 10),
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/images/svg/search.svg',
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchController.clear();
                              setState(() {});
                            },
                            icon:  Icon(Icons.mic, color: Colors.grey),
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
                    return  Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  final allProducts = snapshot.data ?? [];

                  final product = allProducts.where((item) {
                    return item.name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();

                  if (product.isEmpty) {
                    return  Center(child: Text("No Products Found"));
                  }

                  return MasonryGridView.builder(
                    gridDelegate:
                    SliverSimpleGridDelegateWithFixedCrossAxisCount(
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
              borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                product.image,
                height: index.isEven ? 180 : 260,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>  SizedBox(
                  height: 180,
                  child: Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),

            /// Product Name
            Padding(
              padding:  EdgeInsets.all(8),
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
              padding:  EdgeInsets.symmetric(horizontal: 8),
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
              padding:  EdgeInsets.all(8),
              child: Text(
                "৳ ${product.price}",
                style: TextStyle(
                  color: AllColors.primaryColors,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

             SizedBox(height: 8),

            /// Add to Cart Button
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () async {
                  await cartServices.addtoCard(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Product Cart Successfully")),
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
                       SizedBox(width: 8),
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

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
