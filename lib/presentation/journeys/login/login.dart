import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  String _errorMessage;
  bool _loggingIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: _sigInWithGoogle,
              child: Text('Continue with Google'),
            ),
            if (_errorMessage != null) 
              Text(_errorMessage)
            
          ],
        ),
      ),
    );
  }

  // sign in with google account
  void _sigInWithGoogle() async {
    // show progress indicator
    _setLoggingIn();
    String errMsg;

    try {
      // Trigger the authentication flow
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // sigin with credential
      await _auth.signInWithCredential(credential);
    } catch (e) {
      errMsg = 'Login failed, please try again later';
    } finally {
      // hide progress indicator and show error if any
      _setLoggingIn(false, errMsg);
    }
  }

  // update the logging indicator and show error if any
  void _setLoggingIn([bool login = true, String errMsg]) {
    if (mounted) {
      _loggingIn = login;
      _errorMessage = errMsg;
      setState(() {
      });
    }
  }

}