import 'package:allnotes/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    readNote();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () =>
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Center(child: Text(user.uid))],
      ),
    );
  }

  void readNote() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot collection =
        await _firestore.collection('notes-${user.uid}').get();
    List<QueryDocumentSnapshot> documents = collection.docs;
    List<String> documentsList = documents.map((e) => e.id).toList();
    print(documentsList);
  }
}
