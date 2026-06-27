import 'package:firebase_class/const/all_colors.dart';
import 'package:flutter/material.dart';
class login_Screen extends StatefulWidget {
  const login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Container(
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [ 
              Padding(
                padding: EdgeInsets.only(top:58.0,left: 12),
                child: Text("Welcome\n Back!",
                style:TextStyle(
                  color:AllColors.secondaryColors,
                  fontSize:37,
                  fontWeight:FontWeight.bold,
                ),

                          ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
