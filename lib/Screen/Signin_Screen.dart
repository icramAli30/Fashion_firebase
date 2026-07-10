import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/Screen/bottom_nav_bar_screeb.dart';
import 'package:firebase_class/Screen/login_Screen.dart';
import 'package:firebase_class/Screen/products_screen.dart';
import 'package:firebase_class/Screen/profile_screen.dart';
import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import'package:get/get.dart';
bool isPasswordHidden = true;
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final TextEditingController confirmpasswordController =
  TextEditingController();

  bool isLoading = false;

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();


  Future register() async {
    setState(() {
      isLoading = true;
    });
    String email = emailcontroler.text;
    String password = passwordControler.text;
    String confirmpassword = confirmpasswordController.text;

    if (password != confirmpassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password do not match")));

      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      await firebaseAuthServices.register(email, password);

      // signup er por uid FirebaseAuth.currentUser theke neya safe
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        throw Exception('User ID not found after registration');
      }


      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration Successfully")));

     Get.to(() => BottomNavBarScreen());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
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
                "Create an\naccount!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 40),

            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: emailcontroler,
                decoration: InputDecoration(
                  prefixIcon:Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "assets/images/svg/User.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  fillColor: AllColors.filed_greyColors,
                  filled: true,
                  hintText: "Username or Email",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AllColors.primaryColors,
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
                controller: passwordControler,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12),
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
                      color: AllColors.primaryColors,
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

            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: confirmpasswordController,
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
                  hintText: "Confirm Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AllColors.primaryColors,
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
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: AllColors.TextsColors,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: "By clicking the "),
                        TextSpan(
                          text: "Register",
                          style: TextStyle(color: AllColors.primaryColors),
                        ),
                        TextSpan(text: " button, you agree",
                          style: TextStyle(color:AllColors.TextsColors),),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                   Text(
                    "to the public offer",
                    style: TextStyle(color:AllColors.TextsColors),
                    textAlign: TextAlign.left,
                  ),
                ],
              )
            ),

            SizedBox(height: 30),

            isLoading
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
                    register();
                  },
                  child: Text(
                    "Create Account",

                    style: TextStyle(color: Colors.white),
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
                    "I Already Have an Account?",
                    style: TextStyle(color:AllColors.secondaryColors),
                  ),
                  GestureDetector(
                    onTap: () {
                     Get.to(() => LoginScreen());
                    },
                    child: Text(
                      "Login?",
                      style: TextStyle(
                        color: AllColors.primaryColors,
                        decoration: TextDecoration.underline,
                        decorationColor:AllColors.primaryColors,
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