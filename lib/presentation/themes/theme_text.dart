import 'package:flutter/material.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeText {
  const ThemeText._();

  /// [TextStyle] for note title in a editor
  static TextStyle get noteEditorTitle => TextStyle(
        color: AppColor.shark,
        fontSize: Sizes.dimen_21.sp,
        height: Sizes.dimen_19 / Sizes.dimen_16,
        fontWeight: FontWeight.w500,
      );

  /// [TextStyle] for note in a editor
  static TextStyle get noteEditor => TextStyle(
        color: AppColor.sharkDark,
        fontSize: Sizes.dimen_16.sp,
      );
}
