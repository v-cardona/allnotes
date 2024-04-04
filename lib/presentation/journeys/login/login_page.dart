import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:allnotes/presentation/widgets/logo_widget.dart';
import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:allnotes/presentation/journeys/login/text_privacy_terms.dart';
import 'package:allnotes/presentation/themes/custom_icons.dart';
import 'package:allnotes/presentation/widgets/outlined_icon_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late final StreamSubscription<void> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = BlocProvider.of<AuthenticationCubit>(context)
        .initSubscriptionAuth(context);
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Sizes.dimen_30.w),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.all(Sizes.dimen_150.h),
                    child: const LogoWidget()),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, Sizes.dimen_80.h, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Sizes.dimen_30.h,
                      ),
                      OutlinedIconButton(
                        label: TranslationConstants.continueGoogle,
                        iconData: CustomIcons.google,
                        onPressed: () =>
                            BlocProvider.of<AuthenticationCubit>(context)
                                .loginWithGoogle(),
                      ),
                      SizedBox(
                        height: Sizes.dimen_12.h,
                      ),
                      OutlinedIconButton(
                        label: TranslationConstants.continueEmail,
                        iconData: Icons.email_rounded,
                        onPressed: () =>
                            context.pushNamed(RouteList.loginEmail),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_80.w,
                    vertical: Sizes.dimen_30.h,
                  ),
                  child: const TextPrivacyTerms(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
