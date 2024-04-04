import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/image_constants.dart';
import 'package:allnotes/common/constants/size_constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.height = Sizes.dimen_500});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagesConstants.logo,
      height: height.h,
    );
  }
}
