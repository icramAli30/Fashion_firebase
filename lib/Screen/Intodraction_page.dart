import 'package:firebase_class/Screen/login_Screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/const/all_styles.dart';
import 'package:flutter/material.dart';
import'package:get/get.dart';


class IntodractionPage extends StatefulWidget {
  const IntodractionPage({super.key});

  @override
  State<IntodractionPage> createState() => _IntodractionPageState();
}

class _IntodractionPageState extends State<IntodractionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/png/Intro.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: Center(
                    child: Text(
                      "You want \n Authentic, here \n you go!",
                      style: AllStyles.titleTextStyles.copyWith(fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: Text(
                    "Find it here, buy it now!",
                    style: TextStyle(
                      color: AllColors.whiteColors,
                      fontSize: 20,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 58.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        AllColors.primaryColors,
                      ),
                      minimumSize: WidgetStatePropertyAll(Size(300, 55)),
                    ),
                    onPressed: () {
                      Get.to(() =>LoginScreen());
                    },
                    child: Text(
                      'Get Started',
                      style: AllStyles.titleTextStyles.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
