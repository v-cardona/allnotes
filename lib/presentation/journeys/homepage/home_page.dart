import 'dart:async';

import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/notes/notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:allnotes/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/presentation/journeys/homepage/appbar_widget.dart';
import 'package:allnotes/presentation/journeys/homepage/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<void> _authStateSubscription;

  late final NotesCubit _notesCubit;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = BlocProvider.of<AuthenticationCubit>(context)
        .initSubscriptionAuth(context);
    _notesCubit = getItInstance<NotesCubit>();
    _notesCubit.getAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription.cancel();
    _notesCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _notesCubit,
      child: SafeArea(
        child: Scaffold(
          drawer: const DrawerWidget(),
          body: BlocBuilder<NotesCubit, NotesState>(
            builder: (context, state) {
              return const Stack(
                children: [
                  AppBarWidget(),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.goNamed(RouteList.addNotePage);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
