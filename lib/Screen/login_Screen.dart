import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Screen/Signin_Screen.dart';
import 'package:firebase_class/Screen/bottom_nav_bar_screeb.dart';
import 'package:firebase_class/Screen/forget_password_screen.dart';
import 'package:firebase_class/Screen/products_screen.dart';
import 'package:firebase_class/Screen/profile_screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import'package:get/get.dart';
bool isPasswordHidden = true;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;


  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  Future login() async {
    setState(() {
      isloading = true;
    });

    try {
      await firebaseAuthServices.login(
        emailControler.text,
        passwordController.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));

      setState(() {
        isloading = false;
      });


     Get.to(() => BottomNavBarScreen()); //********************************

    } on FirebaseAuthException catch (exception) {
      String message;

      switch (exception.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;

        case 'wrong-password':
          message = 'Incorrect password.';
          break;

        case 'invalid-email':
          message = 'Invalid email address.';
          break;

        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;

        case 'user-disabled':
          message = 'This account has been disabled.';
          break;

        case 'too-many-requests':
          message = 'Too many login attempts. Try again later.';
          break;

        case 'network-request-failed':
          message = 'No internet connection.';
          break;

        default:
          message = exception.message ?? 'Login failed.';
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }

      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text("${exception.message}")));
    } finally {
      if (mounted) {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 58.0, left: 12),
              child: Text(
                "Welcome\nBack!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 40),

            Padding(
              padding:  EdgeInsets.all(12.0),
              child: TextField(
                controller: emailControler,
                decoration: InputDecoration(
                  prefixIcon:Padding(
                    padding:  EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/svg/User.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  fillColor:AllColors.filed_greyColors,
                  filled: true,
                  hintText: "Username or Email",

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color:AllColors.primaryColors,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color:AllColors.broderColors,
                      width: 1,
                    ),),
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding:  EdgeInsets.all(12.0),
              child: TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,

                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:  EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/svg/lack.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                  fillColor:AllColors.filed_greyColors,
                  filled: true,
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color:AllColors.primaryColors,
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                   color:AllColors.broderColors,
                      width: 1,
                    ),),
                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(() => ForgetPasswordScreen());
                      },


                      child: Text("Forgot password?",
                          style: TextStyle(color:AllColors.primaryColors))),
                ],
              ),
            ),

            SizedBox(height: 30),

            isloading
                ? Center(child: CircularProgressIndicator())
                : Center(
              child: Padding(
                padding:  EdgeInsets.only(bottom: 58.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      AllColors.primaryColors,
                    ),
                    minimumSize: WidgetStatePropertyAll(Size(317, 55)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Custom radius
                      ),
                    ),
                  ),

                  onPressed: () {
                    login();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: AllColors.whiteColors),
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            Padding(
              padding:  EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create An Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                    Get.to(() => SignUpScreen());
                    },
                    child: Text(
                      "Sign Up?",
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                      ),
                    ),
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