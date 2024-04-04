import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/presentation/themes/app_color.dart';

class ThemeApp {
  const ThemeApp._();

  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    // scaffoldBackgroundColor: AppColor.shark,
    colorScheme: const ColorScheme.light(
      // secondary: AppColor.brandyPunch,
      primary: AppColor.amber,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.iron,
      foregroundColor: AppColor.shark,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    iconTheme: const IconThemeData(color: AppColor.amber),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => AppColor.alabaster,
        ),
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(color: AppColor.amber),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_30.w)),
        ),
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => Size(Sizes.dimen_700.w, Sizes.dimen_100.h),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => AppColor.shark,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => AppColor.amber,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => AppColor.shark,
        ),
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => Size(Sizes.dimen_250.w, Sizes.dimen_110.h),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColor.shark),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColor.amber,
          width: Sizes.dimen_1,
        ),
        borderRadius: BorderRadius.circular(Sizes.dimen_8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColor.amber,
          width: Sizes.dimen_1,
        ),
        borderRadius: BorderRadius.circular(Sizes.dimen_8),
      ),
    ),
    scaffoldBackgroundColor: AppColor.alabaster,
  );
}
