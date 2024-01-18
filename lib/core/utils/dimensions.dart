import 'package:flutter/material.dart';

class ScreenDimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  static double heightPercentage(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static double widthPercentage(BuildContext context, double percentage) =>
      screenWidth(context) * percentage / 100;

  static double fontSize(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;

  static double radius(BuildContext context, double percentage) =>
      screenHeight(context) * percentage / 100;
}


