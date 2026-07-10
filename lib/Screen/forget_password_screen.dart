import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/services/firebase_auth_services.dart';
import 'package:firebase_class/services/forget_password_services.dart' hide FirebaseAuthServices;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 58.0, left: 12),
            child: Text(
              "Forgot"
                  " \n password?",
              style: TextStyle(
                color:AllColors.secondaryColors,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),

          Padding(
            padding:  EdgeInsets.all(12.0),
            child: TextField(
              controller: emailController,
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
                hintText: "Enter your email address",

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
              padding:  EdgeInsets.only(left: 18.0),
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
                        TextSpan(text: "*",style: TextStyle(color:AllColors.primaryColors),),
                      TextSpan(text: " We will send you a message to set or reset "
                             "\n your new password"),


                      ],
                    ),
                  ),

                  SizedBox(height: 4),


                ],
              )
          ),
          SizedBox(height: 30),

          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 58.0),
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

                onPressed: () async {
                  if (emailController.text.trim().isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please enter your email",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  await authServices.resetPassword(
                    emailController.text.trim(),
                  );

                  Get.snackbar(
                    "Success",
                    "Password reset link has been sent to your email.",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
