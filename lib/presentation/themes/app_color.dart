import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static const Color gigas = Color(0xFF3F3F9C);
  static const Color blueViolet = Color(0xFF5a46b2);
  static const Color white = Colors.white;
  static const Color alabaster = Color(0xFFF7F7F7);
  static const Color iron = Color(0xFFDADCE0);
  static const Color shuttleGray = Color(0xFF63676C);
  static const Color shark = Color(0xFF202124);
  static const Color sharkDark = Color(0xC2000000);
  static const Color sharkSemi = Color(0x21000000);

  static const Color froly = Color(0xFFF28C82);
  static const Color flamingo = Color(0xFFF44743);
  static const Color amber = Color(0xFFFABD03);
  static const Color parisDaisy = Color(0xFFFFF476);
  static const Color reef = Color(0xFFCDFF90);
  static const Color anakiwa = Color(0xFFA7FEEB);
  static const Color hummingBird = Color(0xFFCBF0F8);
  static const Color sail = Color(0xFFAFCBFA);
  static const Color mauve = Color(0xFFD7AEFC);
  static const Color pigPink = Color(0xFFFDCFE9);
  static const Color cashmere = Color(0xFFE6C9A9);
  static const Color athensGray = Color(0xFFE9EAEE);

  /// Available note background colors
  static const Iterable<Color> noteColors = [
    white,
    froly,
    amber,
    parisDaisy,
    reef,
    anakiwa,
    hummingBird,
    sail,
    mauve,
    pigPink,
    cashmere,
    athensGray
  ];

  static Color noteColorDefault = noteColors.first;
}
