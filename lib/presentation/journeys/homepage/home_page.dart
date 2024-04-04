import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/presentation/journeys/homepage/appbar_widget.dart';
import 'package:allnotes/presentation/journeys/homepage/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: const Stack(
          children: [
            AppBarWidget(),
          ],
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
