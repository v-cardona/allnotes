import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/screenutil/screenutil.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class AuthenticationBackground extends StatelessWidget {
  const AuthenticationBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final background = Container(
      height: ScreenUtil.defaultHeight * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          AppColor.gigas,
          AppColor.blueViolet
        ],
      )),
    );

    final circle = Container(
      width: Sizes.dimen_100.w,
      height: Sizes.dimen_48.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.dimen_100.w),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        background,
        Positioned(
          child: circle,
          top: Sizes.dimen_90,
          left: Sizes.dimen_30,
        ),
        Positioned(
          child: circle,
          top: -Sizes.dimen_40,
          right: -Sizes.dimen_30,
        ),
        Positioned(
          child: circle,
          bottom: -Sizes.dimen_50,
          right: -Sizes.dimen_10,
        ),
        Positioned(
          child: circle,
          bottom: Sizes.dimen_120,
          right: Sizes.dimen_20,
        ),
        Positioned(
          child: circle,
          bottom: -Sizes.dimen_50,
          left: -Sizes.dimen_20,
        ),
        Container(
          padding: EdgeInsets.only(top: Sizes.dimen_60.w),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: Sizes.dimen_50.h,
              ),
              SizedBox(
                height: Sizes.dimen_10.h,
                width: double.infinity,
              ),
            ],
          ),
        )
      ],
    );
  }
}