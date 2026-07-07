import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Screen/Intodraction_page.dart';
import 'package:firebase_class/Screen/bottom_nav_bar_screeb.dart';
import 'package:firebase_class/Screen/products_screen.dart';
import 'package:firebase_class/Screen/profile_screen.dart';
import 'package:firebase_class/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  @override
  void initState() {
    super.initState();

    Future.delayed( Duration(seconds: 3), () {
      final user = firebaseAuthServices.currentUser;

      print("Current User: $user");
      print("UID: ${user?.uid}");
      print("Email: ${user?.email}");

      if (user != null) {
        Get.off(() =>BottomNavBarScreen());///Nabigation Screen *******************************************
      } else {
        Get.off(() => IntodractionPage());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Center(
        child: SvgPicture.asset(
          'assets/images/svg/splash.svg',
          fit: BoxFit.contain,
          width: 275,
          height:90,
        )
      ),

    );
  }
}
