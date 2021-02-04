import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: Sizes.dimen_3.w,
                offset: Offset(Sizes.dimen_1.w, Sizes.dimen_1.w),
                spreadRadius: Sizes.dimen_2.w)
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
        height: Sizes.dimen_20.h,
        child: FlatButton.icon(
          onPressed: () =>
              BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed()),
          icon: Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          label: Text(
            TranslationConstants.google.translate(context),
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
