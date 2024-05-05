import 'dart:async';

import 'package:allnotes/common/constants/routes_constants.dart';
import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/context._extension.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/navigation_drawer/navigation_drawer_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_archived/notes_archived_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_deleted/notes_deleted_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_pinned/notes_pinned_cubit.dart';
import 'package:allnotes/presentation/blocs/notes_unspecified/notes_unspecified_cubit.dart';
import 'package:allnotes/presentation/journeys/archive/archive_page.dart';
import 'package:allnotes/presentation/journeys/deleted/deleted_page.dart';
import 'package:allnotes/presentation/journeys/homepage/home_page.dart';
import 'package:allnotes/presentation/journeys/root_page/appbar_widget.dart';
import 'package:allnotes/presentation/journeys/root_page/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:allnotes/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late final StreamSubscription<void> _authStateSubscription;
  late final NavigationDrawerCubit _navigationDrawerCubit;
  late final NotesUnspecifiedCubit _notesUnspecifiedCubit;
  late final NotesPinnedCubit _notesPinnedCubit;
  late final NotesArchivedCubit _notesArchivedCubit;
  late final NotesDeletedCubit _notesDeletedCubit;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = BlocProvider.of<AuthenticationCubit>(context)
        .initSubscriptionAuth(context);
    _navigationDrawerCubit = getItInstance<NavigationDrawerCubit>();
    _notesUnspecifiedCubit = getItInstance<NotesUnspecifiedCubit>();
    _notesPinnedCubit = getItInstance<NotesPinnedCubit>();
    _notesArchivedCubit = getItInstance<NotesArchivedCubit>();
    _notesDeletedCubit = getItInstance<NotesDeletedCubit>();
    _notesPinnedCubit.getAllNotes();
    _notesUnspecifiedCubit.getAllNotes();
    _notesArchivedCubit.getAllNotes();
    _notesDeletedCubit.getAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription.cancel();
    _navigationDrawerCubit.close();
    _notesUnspecifiedCubit.close();
    _notesPinnedCubit.close();
    _notesArchivedCubit.close();
    _notesDeletedCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _navigationDrawerCubit,
        ),
        BlocProvider(
          create: (context) => _notesPinnedCubit,
        ),
        BlocProvider(
          create: (context) => _notesUnspecifiedCubit,
        ),
        BlocProvider(
          create: (context) => _notesArchivedCubit,
        ),
        BlocProvider(
          create: (context) => _notesDeletedCubit,
        ),
      ],
      child: BlocBuilder<NavigationDrawerCubit, NavigationDrawerState>(
        bloc: _navigationDrawerCubit,
        builder: (context, state) {
          Widget screen;
          switch (state.navbarItem) {
            case NavbarItem.notes:
              screen = const HomePage();
              break;
            case NavbarItem.archive:
              screen = const ArchivePage();
              break;
            case NavbarItem.deleted:
              screen = const DeletedPage();
              break;
            default:
              screen = Container();
          }
          return BlocListener<NotesDeletedCubit, NotesDeletedState>(
            listener: (context, state) {
              if (state is NotesDeletedPermanently) {
                context.showInfoSnackBar(
                    message: TranslationConstants.removedSuccessfully);
              }
            },
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
                    screen,
                  ],
                ),
                floatingActionButton: _createFAB(state.navbarItem),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget? _createFAB(NavbarItem navbarItem) {
    if (navbarItem == NavbarItem.notes) {
      return FloatingActionButton(
        onPressed: () {
          context.goNamed(RouteList.addNotePage);
        },
        child: const Icon(Icons.add),
      );
    } else if (navbarItem == NavbarItem.deleted) {
      return FloatingActionButton(
        onPressed: () => removePermantlyNotes(),
        child: const Icon(Icons.delete_forever_outlined),
      );
    } else {
      return null;
    }
  }

  void removePermantlyNotes() {
    context.showDeleteDialog(
      title: TranslationConstants.deleteAllNotesConfirmation,
      onPressed: () {
        _notesDeletedCubit.removeAllNotes();
        Navigator.of(context).pop();
      },
    );
  }
}
