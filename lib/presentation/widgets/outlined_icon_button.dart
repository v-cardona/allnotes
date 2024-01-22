import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlinedIconButton extends StatelessWidget {
  const OutlinedIconButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.iconData,
  });

  final String label;
  final Function() onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: AppColor.amber,
      ),
      label: Padding(
        padding: EdgeInsets.fromLTRB(Sizes.dimen_50.w, 0, 0, 0),
        child: Text(label.translate(context)),
      ),
    );
  }
}
