import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:allnotes/presentation/blocs/signup_bloc/signup_bloc.dart';
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
                _crearFondo(context),
                _loginForm(context, state),
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

          // if submitting when signup show snackbar loading
          if (state.status.isSubmissionInProgress) {
            Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(hours: 1),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Loading...'), CircularProgressIndicator()],
                )));
          }

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
          }
        },
      ),
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1)
        ],
      )),
    );

    final circulo = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(
          child: circulo,
          top: 90,
          left: 30,
        ),
        Positioned(
          child: circulo,
          top: -40,
          right: -30,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          right: -10,
        ),
        Positioned(
          child: circulo,
          bottom: 120,
          right: 20,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          left: -20,
        ),
        Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context, SignupState state) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 130,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.only(top: 30, left: 30, bottom: 10, right: 30),
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                    spreadRadius: 3)
              ],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                _crearEmail(context, state),
                SizedBox(
                  height: 30,
                ),
                _crearPassword(context, state),
                SizedBox(
                  height: 30,
                ),
                _crearPasswordConfirm(context, state),
                SizedBox(
                  height: 60,
                ),
                _crearBoton(context, state),
              ],
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Already have an account? Login here'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          )
        ],
      ),
    );
  }

  Widget _crearEmail(BuildContext context, SignupState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) => BlocProvider.of<SignupBloc>(context)
            .add(EmailChanged(email: value)),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(
              Icons.alternate_email,
              color: Colors.deepPurple,
            ),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo Electrónico',
            errorText: state.email.invalid ? 'Correo inválido' : null),
      ),
    );
  }

  Widget _crearPassword(BuildContext context, SignupState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) => BlocProvider.of<SignupBloc>(context)
            .add(PasswordChanged(password: value)),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.deepPurple,
            ),
            labelText: 'Contraseña',
            errorText: state.password.invalid
                ? 'Debe tener una longitud entre 8 y 50 carácteres'
                : null),
      ),
    );
  }

  Widget _crearPasswordConfirm(BuildContext context, SignupState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) => BlocProvider.of<SignupBloc>(context)
            .add(PasswordConfirmChanged(password: value)),
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.deepPurple,
            ),
            labelText: 'Confirma tu contraseña',
            errorText: state.passwordConfirm.invalid
                ? 'Las contraseñas no coinciden'
                : null),
      ),
    );
  }

  Widget _crearBoton(BuildContext context, SignupState state) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text('Registrarse'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      color: Colors.deepPurple,
      textColor: Colors.white,
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
  }
}
