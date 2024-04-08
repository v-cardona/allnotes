import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';

class LoadingEffect extends StatelessWidget {
  final double? size;

  const LoadingEffect({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? Sizes.dimen_100.w,
      height: size ?? Sizes.dimen_100.w,
      child: const CircularProgressIndicator(),
    );
  }
}
