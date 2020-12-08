import 'package:allnotes/presentation/journeys/home/home_screen.dart';
import 'package:allnotes/presentation/journeys/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllNotesApp extends StatefulWidget {
  // This widget is the root of the application.

  @override
  _AllNotesAppState createState() => _AllNotesAppState();
}

class _AllNotesAppState extends State<AllNotesApp> {

  @override
  Widget build(BuildContext context) {
    
    // load firebase contents

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AllNotes',
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print('error');
          }

          // Once firebase is completed, get user and check if show login or home screen
          if (snapshot.connectionState == ConnectionState.done) {
            
            return StreamProvider.value(
              value: FirebaseAuth.instance.authStateChanges(),
              child: Consumer<User>(
                builder: (context, value, child) {
                  return value == null ? LogInScreen() : HomeScreen();
                },
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: Text('Loading...'));
        },
      ),
    );
  }
}
