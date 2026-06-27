import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/const/all_sizes.dart';
import 'package:flutter/material.dart';

class AllStyles {
  static final titleTextStyles = TextStyle(
    fontSize: AllSizes.largeSizes,
    color: AllColors.whiteColors,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );
  static final subtitleTextStyles = TextStyle(
    fontSize: AllSizes.mediumSizes,
    color: AllColors.secondaryColors,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
  );
}
