import 'package:allnotes/common/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    super.key,
    required this.color,
    this.selected = false,
  });

  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.dimen_120.h,
      width: Sizes.dimen_120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: selected
          ? const Icon(
              Icons.check,
              color: Colors.black,
            )
          : null,
    );
  }
}
