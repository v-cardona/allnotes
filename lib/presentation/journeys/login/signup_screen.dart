import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/presentation/blocs/signup_bloc/signup_bloc.dart';
import 'package:allnotes/presentation/journeys/login/authentication_background.dart';
import 'package:allnotes/presentation/journeys/login/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/screenutil/screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupBloc _signupBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = getItInstance<SignupBloc>();
    _authenticationBloc = getItInstance<AuthenticationBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _signupBloc.close();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _signupBloc),
        BlocProvider.value(value: _authenticationBloc),
      ],
      child: BlocListener(
        cubit: _signupBloc,
        child: BlocBuilder(
          cubit: _signupBloc,
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                AuthenticationBackground(),
                SignupForm(),
                Positioned(
                  left: Sizes.dimen_16.w,
                  top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: Sizes.dimen_14.h,
                    ),
                  ),
                )
              ],
            );
          },
        ),
        listener: (context, SignupState state) {
          // hide previous snackbars
          Scaffold.of(context).hideCurrentSnackBar();

          // if fail when signup show snackbar fail
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Sign Up failure.'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
          }

          // if sigup success emit Logged state to change to homeScreen
          if (state.status.isSubmissionSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            Navigator.of(context).pop();
          }
        },
      ),
    ));
  }
}