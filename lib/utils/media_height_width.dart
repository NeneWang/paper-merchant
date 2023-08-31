import 'package:flutter/material.dart';

class Screen {
  static double? height;
  static double? width;

  static setScreen(context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
