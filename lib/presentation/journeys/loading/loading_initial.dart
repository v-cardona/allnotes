import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/image_constants.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/presentation/journeys/loading/loading_effect.dart';

class LoadingInitial extends StatelessWidget {
  const LoadingInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(Sizes.dimen_15.h),
            child: Image.asset(
              ImagesConstants.logo,
              scale: 2.5,
            ),
          ),
          SizedBox(height: Sizes.dimen_20.h),
          const Center(
            child: LoadingEffect(),
          ),
          SizedBox(height: Sizes.dimen_40.h),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_15.w),
              child: Text(
                TranslationConstants.writingDownBestIdeas.translate(context),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
