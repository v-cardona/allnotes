import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/presentation/journeys/loading/loading_effect.dart';

class LoadingPage extends StatelessWidget {
  final Widget screen;
  const LoadingPage({
    super.key,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        screen,
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
          ),
          child: Center(
            child: LoadingEffect(
              size: Sizes.dimen_20.w,
            ),
          ),
        )
      ],
    );
  }
}
