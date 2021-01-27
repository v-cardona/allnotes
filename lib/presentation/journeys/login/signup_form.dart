import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/screenutil/screenutil.dart';
import 'package:allnotes/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:allnotes/presentation/journeys/login/email_open_login_button.dart';
import 'package:allnotes/presentation/journeys/login/widgets/submit_button.dart';
import 'package:allnotes/presentation/widgets/email_input.dart';
import 'package:allnotes/presentation/widgets/password_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key key}) : super(key: key);

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
                  'Sign Up',
                  style: TextStyle(fontSize: Sizes.dimen_20.sp),
                ),
                SizedBox(height: Sizes.dimen_20.h),
                _EmailInput(),
                SizedBox(
                  height: Sizes.dimen_14.h,
                ),
                _PasswordInput(),
                SizedBox(
                  height: Sizes.dimen_14.h,
                ),
                _PasswordConfirmInput(),
                SizedBox(
                  height: Sizes.dimen_20.h,
                ),
                _SignUpButton()
              ],
            ),
          ),
          EmailOpenLoginButton()
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return EmailInput(
            onChanged: (value) => BlocProvider.of<SignupBloc>(context)
                .add(EmailChanged(email: value)),
            errorText: state.email.invalid ? 'Correo inválido' : null);
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return PasswordInput(
          onChanged: (value) => BlocProvider.of<SignupBloc>(context)
              .add(PasswordChanged(password: value)),
          errorText: state.password.invalid
              ? 'Debe tener una longitud entre 8 y 50 carácteres'
              : null,
          labelText: 'Contraseña',
        );
      },
    );
  }
}

class _PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.passwordConfirm != current.passwordConfirm,
      builder: (context, state) {
        return PasswordInput(
          onChanged: (value) => BlocProvider.of<SignupBloc>(context)
              .add(PasswordConfirmChanged(password: value)),
          errorText: state.passwordConfirm.invalid
              ? 'Las contraseñas no coinciden'
              : null,
          labelText: 'Confirma tu contraseña',
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SubmitButton(
                text: 'Registrarse',
                onPressed: state.status.isValid
                    ? () {
                        BlocProvider.of<SignupBloc>(context).add(
                            SignupWithCredentialsPressed(
                                email: state.email,
                                password: state.password,
                                passwordConfirm: state.passwordConfirm));
                      }
                    : null,
              );
      },
    );
  }
}
