import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_class/Screen/cart_Screen.dart';
import 'package:firebase_class/Screen/home_screen.dart';
import 'package:firebase_class/Screen/product_Screen1.dart';
import 'package:firebase_class/Screen/products_screen.dart';
import 'package:firebase_class/Screen/profile_screen.dart';
import 'package:firebase_class/Screen/search_screen.dart';
import 'package:firebase_class/services/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/all_colors.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.favorite_border,
    Icons.search,
    Icons.person_outline];

  List<Widget> pages = [HomeScreen(),ProductScreen1(),SearchScreen(),ProfileScreen()];
  int activeIndex = 0;
  bool isCartSelected = false;
  final CartServices cartServices = CartServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StreamBuilder<int>(
        stream: cartServices.cartCount(),
        builder: (context, snapshot) {
          final count = snapshot.data ?? 0;

          return FloatingActionButton(
            backgroundColor: isCartSelected
                ? AllColors.primaryColors
                : AllColors.whiteColors,
            shape: const CircleBorder(),
            onPressed: () {
              setState(() {
                isCartSelected = true;
              });

              Get.to(() => CartScreen())?.then((_) {
                setState(() {
                  isCartSelected = false;
                });
              });
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: isCartSelected
                      ? AllColors.whiteColors
                      : AllColors.secondaryColors,
                ),

                if (count > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        "$count",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar:AnimatedBottomNavigationBar(
        icons: icons,
        iconSize:28,
        activeIndex: activeIndex,
        backgroundColor:AllColors.whiteColors,
        notchSmoothness:NotchSmoothness.softEdge,
        gapLocation:GapLocation.center,
        inactiveColor:AllColors.secondaryColors.withValues(alpha:0.8),
        activeColor:AllColors.primaryColors,
        onTap: (index){
          setState(() {
            activeIndex = index;
          }
          );
        },
      ),
      body: pages[activeIndex],
    );
  }
}
