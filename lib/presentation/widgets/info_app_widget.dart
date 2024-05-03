import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';

class InfoAppWidget extends StatelessWidget {
  const InfoAppWidget({
    super.key,
    required this.infoText,
  });

  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_rounded,
          size: Sizes.dimen_80.w,
        ),
        SizedBox(
          height: Sizes.dimen_20.h,
        ),
        Text(infoText.translate(context)),
      ],
    );
  }
}
