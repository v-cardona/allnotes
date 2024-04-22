import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorAppWidget extends StatelessWidget {
  const ErrorAppWidget({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outlined,
          color: AppColor.flamingo,
          size: Sizes.dimen_80.w,
        ),
        SizedBox(
          height: Sizes.dimen_20.h,
        ),
        Text(errorText),
      ],
    );
  }
}
