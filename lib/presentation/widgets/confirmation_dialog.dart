import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.onPressed,
    required this.noText,
    required this.yesText,
    this.content,
    this.widget,
  }) : assert(content == null || widget == null,
            'one of content or widget must be null');

  final String title;
  final String noText;
  final String yesText;
  final String? content;
  final Widget? widget;

  /// has to include navigato pop to close alert
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title.translate(context)),
      content: content != null
          ? Text(content!.translate(context))
          : widget ?? const SizedBox.shrink(),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(noText.translate(context)),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(yesText.translate(context)),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dimen_50.w),
      ),
    );
  }
}
