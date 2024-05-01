import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:allnotes/presentation/widgets/confirmation_dialog.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = AppColor.flamingo,
    IconData icon = Icons.info_rounded,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(Sizes.dimen_30.w),
              height: Sizes.dimen_250.h,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Sizes.dimen_50.w)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Sizes.dimen_48.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message.translate(this),
                          style: Theme.of(this).textTheme.titleMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: AppColor.froly,
      icon: Icons.error_rounded,
    );
  }

  void showInfoSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: AppColor.reef,
      icon: Icons.info_rounded,
    );
  }

  void showDeleteDialog({
    required String title,

    /// has to include navigato pop to close alert
    required Function() onPressed,
    String? content,
  }) {
    showConfirmationDialog(
      content: content,
      title: title,
      noText: TranslationConstants.cancel,
      yesText: TranslationConstants.delete,
      onPressed: onPressed,
    );
  }

  void showDiscardDialog({
    required String title,

    /// has to include navigato pop to close alert
    required Function() onPressed,
    String? content,
  }) {
    showConfirmationDialog(
      content: content,
      title: title,
      noText: TranslationConstants.no,
      yesText: TranslationConstants.discard,
      onPressed: onPressed,
    );
  }

  void showCloseAppDialog() {
    showConfirmationDialog(
      title: TranslationConstants.closeAppConfirmation,
      noText: TranslationConstants.no,
      yesText: TranslationConstants.close,
      onPressed: () => SystemNavigator.pop(),
    );
  }

  void showLogoutDialog({
    required Function() onPressed,
  }) {
    showConfirmationDialog(
      title: TranslationConstants.logoutConfirmation,
      noText: TranslationConstants.no,
      yesText: TranslationConstants.logout,
      onPressed: onPressed,
    );
  }

  // show general confiramtion dialog
  void showConfirmationDialog({
    required String title,

    /// has to include navigato pop to close alert
    required Function() onPressed,
    required String noText,
    required String yesText,
    String? content,
    Widget? widget,
    bool dismiss = true,
  }) {
    showDialog(
      context: this,
      barrierDismissible: dismiss,
      builder: (_) => ConfirmationDialog(
        content: content,
        title: title,
        noText: noText,
        yesText: yesText,
        onPressed: onPressed,
        widget: widget,
      ),
    );
  }
}
