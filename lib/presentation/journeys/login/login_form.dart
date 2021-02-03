import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/screenutil/screenutil.dart';
import 'package:allnotes/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:allnotes/presentation/widgets/email_input.dart';
import 'package:allnotes/presentation/widgets/password_input.dart';
import 'package:allnotes/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'email_open_signup_button.dart';
import 'google_login_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: Sizes.dimen_80.h,
            ),
          ),
          Container(
            width: ScreenUtil.defaultWidth * 0.85,
            margin: EdgeInsets.only(
                top: Sizes.dimen_6.h,
                left: Sizes.dimen_12.w,
                bottom: Sizes.dimen_6.h,
                right: Sizes.dimen_12.w),
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.dimen_4.w),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: Sizes.dimen_5.w,
                    offset: Offset(Sizes.dimen_0.w, Sizes.dimen_5.w),
                    spreadRadius: Sizes.dimen_3.w)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  TranslationConstants.login_title.translate(context),
                  style: TextStyle(fontSize: Sizes.dimen_20.sp),
                ),
                SizedBox(height: Sizes.dimen_20.h),
                _EmailInput(),
                SizedBox(
                  height: Sizes.dimen_14.h,
                ),
                _PasswordInput(),
                SizedBox(
                  height: Sizes.dimen_20.h,
                ),
                _LoginButton(),
                SizedBox(
                  height: Sizes.dimen_20.h,
                ),
                Row(children: <Widget>[
                  Expanded(child: Divider()),
                  SizedBox(
                    width: Sizes.dimen_20.w,
                  ),
                  Text(TranslationConstants.continue_using.translate(context)),
                  SizedBox(
                    width: Sizes.dimen_20.w,
                  ),
                  Expanded(child: Divider()),
                ]),
                SizedBox(
                  height: Sizes.dimen_14.h,
                ),
                GoogleLoginButton(),
              ],
            ),
          ),
          EmailOpenSignupButton()
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return EmailInput(
            onChanged: (value) => BlocProvider.of<LoginBloc>(context)
                .add(EmailChanged(email: value)),
            errorText: state.email.invalid
                ? TranslationConstants.email_invalid_title.translate(context)
                : null);
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordInput(
            onChanged: (value) => BlocProvider.of<LoginBloc>(context)
                .add(PasswordChanged(password: value)),
            errorText: state.password.invalid
                ? TranslationConstants.password_invalid_length_title
                    .translate(context)
                : null,
            labelText: TranslationConstants.password_title.translate(context));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SubmitButton(
                text: TranslationConstants.login_title.translate(context),
                onPressed: state.status.isValid
                    ? () {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginWithCredentialsPressed(
                                email: state.email, password: state.password));
                      }
                    : null,
              );
      },
    );
  }
}
