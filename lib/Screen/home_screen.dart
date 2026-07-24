import 'package:firebase_class/Screen/product_details_screen.dart';
import 'package:firebase_class/Screen/profile_screen.dart';
import 'package:firebase_class/models/category_modelclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../const/all_colors.dart';
import '../const/all_styles.dart';
import '../models/User_modelclass.dart';

import '../models/homemodel/carousel_slidermodel.dart';
import '../services/cart_services.dart';
import '../services/category_services.dart';
import '../services/home_services/carousel_slider_Services.dart';
import '../services/products_services.dart';
import '../services/profile_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileService profileService = ProfileService();
  final ProductsServices productsServices = ProductsServices();
  final CartServices cartServices = CartServices();
  final TextEditingController searchController = TextEditingController();
  final CategoryServices categoryService = CategoryServices();
  final CarouselSliderServices carouselsliderService = CarouselSliderServices();



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
      body:Padding(
        padding:  EdgeInsets.only(top:10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height:2,),
              SizedBox(
                height:80,
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
              SizedBox(height:5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("All Category",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height:10,),
              SizedBox(
              height: 100,
              child: StreamBuilder<List<CategoryModel>>(
                stream: categoryService.getCategory(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return  Center(
                      child: Text("No Category"),
                    );
                  }

                  final categories = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius:25,
                              backgroundImage: NetworkImage(category.image),
                            ),
                             SizedBox(height: 5),
                            Text(category.name),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              ),
              SizedBox(
                height: 200,
                child: StreamBuilder<List<CarouselSliderModel>>(
                  stream: carouselsliderService.getCarouselslider(),
                  builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No Slider Found"),
                      );
                    }

                    final carouselslider = snapshot.data!;

                    return CarouselSlider.builder(
                      itemCount: carouselslider.length,
                      itemBuilder: (context, index, realIndex) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            carouselslider[index].image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.broken_image),
                              );
                            },
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                    );
                  },
                ),
              ),



            ]
          ),
        ),
      ),

    );
  }

}
