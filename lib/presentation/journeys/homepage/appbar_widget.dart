import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/themes/app_color.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.dimen_25.w),
      child: Card(
        elevation: 2,
        child: Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(Sizes.dimen_25.w),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: Sizes.dimen_50.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu),
                  color: Colors.grey,
                ),
                Text(
                  TranslationConstants.searchYourNotes.translate(context),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.view_agenda_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: Sizes.dimen_30.w,
                    ),
                    const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
