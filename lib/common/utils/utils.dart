import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static Color darken(Color color, double percentage) {
    int redDarken = color.red - (color.red * percentage).toInt();
    int greenDarken = color.green - (color.green * percentage).toInt();
    int blueDarken = color.blue - (color.blue * percentage).toInt();

    Color colorDarken = Color.fromARGB(255, redDarken, greenDarken, blueDarken);
    return colorDarken;
  }
}
