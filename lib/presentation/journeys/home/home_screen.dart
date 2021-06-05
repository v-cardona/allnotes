import 'dart:ui';

import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/presentation/blocs/notes_bloc/notes_bloc.dart';
import 'package:allnotes/presentation/journeys/home/home_screen_notes_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';

import 'home_screen_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotesBloc _notesBloc;

  @override
  void initState() {
    super.initState();
    _notesBloc = getItInstance<NotesBloc>();
    _notesBloc.add(NotesLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _notesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        cubit: _notesBloc,
        builder: (context, state) {
          if (state is NotesError) {
            print(state.appErrorType);
          } else if (state is NotesLoaded) {
            return CustomScrollView(
              slivers: <Widget>[
                HomeScreenAppBar(),
                state.notes.isEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: Sizes.dimen_20.h,
                          ),
                          child: Center(
                            child: Text(
                              TranslationConstants.addFirstNote
                                  .translate(context),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : HomeScreenNotesGrid(notes: state.notes),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

// BlocBuilder<NotesBloc, NotesState>(
//           cubit: _notesBloc,
//           builder: (context, state) {
//             if (state is NotesError) {
//               print(state.appErrorType);
//             } else if (state is NotesLoaded) {
//               NoteEntity note = state.notes[0];
//               print(note);
//             }
//             return const SizedBox.shrink();
//           },
//         ));
