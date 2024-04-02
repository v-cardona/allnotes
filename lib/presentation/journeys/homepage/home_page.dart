import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("logged"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed(RouteList.addNotePage);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
