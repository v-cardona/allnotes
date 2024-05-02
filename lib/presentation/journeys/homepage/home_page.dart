import 'dart:async';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/presentation/blocs/notes_pinned/notes_pinned_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_unspecified/notes_unspecified_cubit.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/notes_pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:allnotes/presentation/journeys/homepage/notes/notes_default.dart';
import 'package:allnotes/presentation/journeys/homepage/appbar_widget.dart';
import 'package:allnotes/presentation/journeys/homepage/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<void> _authStateSubscription;

  late final NotesUnspecifiedCubit _notesUnspecifiedCubit;
  late final NotesPinnedCubit _notesPinnedCubit;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = BlocProvider.of<AuthenticationCubit>(context)
        .initSubscriptionAuth(context);
    _notesUnspecifiedCubit = getItInstance<NotesUnspecifiedCubit>();
    _notesPinnedCubit = getItInstance<NotesPinnedCubit>();
    _notesUnspecifiedCubit.getAllNotes();
    _notesPinnedCubit.getAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription.cancel();
    _notesUnspecifiedCubit.close();
    _notesPinnedCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _notesPinnedCubit,
        ),
        BlocProvider(
          create: (context) => _notesUnspecifiedCubit,
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          drawer: const DrawerWidget(),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                flexibleSpace: const AppBarWidget(),
                backgroundColor: Colors.transparent,
                collapsedHeight: Sizes.dimen_250.h,
              ),
              const NotesPinned(),
              const NotesDefault(),
            ],
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
