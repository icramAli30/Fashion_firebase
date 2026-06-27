import 'package:firebase_class/Screen/Intodraction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed( Duration(seconds: 3), () {
      Get.off(() => IntodractionPage());
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
