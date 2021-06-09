import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/blocs/note_color_bloc/note_color_bloc.dart';
import 'package:allnotes/presentation/blocs/note_state_bloc/note_state_bloc.dart';
import 'package:allnotes/presentation/journeys/note_single/note_editor_bottom_bar.dart';
import 'package:allnotes/presentation/journeys/note_single/note_editor_form.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteEntity note;

  NoteEditorScreen({Key key, this.note}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  TextEditingController _noteContentController;
  TextEditingController _noteTitleController;
  NoteColorBloc _noteColorBloc;
  NoteStateBloc _noteStateBloc;
  bool _readOnly;
  String _strLastModified;

  @override
  void initState() {
    super.initState();
    _noteContentController = TextEditingController(text: widget.note?.content);
    _noteTitleController = TextEditingController(text: widget.note?.title);
    _noteColorBloc = getItInstance<NoteColorBloc>();
    _noteColorBloc.add(
      ChangeNoteColorEvent(
        color: widget.note?.color ?? AppColor.noteColorDefault,
      ),
    );
    _noteStateBloc = getItInstance<NoteStateBloc>();
    _noteStateBloc.add(
      ChangeNoteStateEvent(
        state: widget.note?.state ?? NoteState.unspecified,
      ),
    );

    _readOnly = !(widget.note?.canEdit ?? true);
    _strLastModified = widget.note?.strLastModified;
  }

  @override
  void dispose() {
    super.dispose();
    _noteContentController.dispose();
    _noteTitleController.dispose();
    _noteColorBloc.close();
    _noteStateBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _noteColorBloc),
        BlocProvider.value(value: _noteStateBloc),
      ],
      child: BlocBuilder<NoteColorBloc, NoteColorState>(
        builder: (_, state) {
          if (state is NoteColorChanged) {
            Color color = state.color;
            return Theme(
              data: Theme.of(context).copyWith(
                primaryColor: color,
                appBarTheme: Theme.of(context).appBarTheme.copyWith(
                      elevation: 0,
                    ),
                scaffoldBackgroundColor: color,
                bottomAppBarColor: color,
              ),
              child: Scaffold(
                  appBar: AppBar(
                    iconTheme: const IconThemeData(color: Colors.black54),
                    actions: [
                      BlocConsumer<NoteStateBloc, NoteStateState>(
                        listener: (context, state) {
                          if (state is NoteStateChanged) {
                            String message = '';
                            if (state.state == NoteState.pinned) {
                              message = 'Note pinned';
                            } else if (state.state == NoteState.archived) {
                              message = 'Note archived';
                            }
                            if (message != '') {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is NoteStateChanged) {
                            return IconButton(
                              icon: Icon(
                                state.state == NoteState.pinned
                                    ? Icons.push_pin_rounded
                                    : Icons.push_pin_outlined,
                              ),
                              onPressed: () => _noteStateBloc.add(
                                ChangeNoteStateEvent(
                                  state: state.state == NoteState.pinned
                                      ? NoteState.unspecified
                                      : NoteState.pinned,
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      BlocBuilder<NoteStateBloc, NoteStateState>(
                        builder: (context, state) {
                          if (state is NoteStateChanged) {
                            return IconButton(
                              icon: Icon(
                                state.state == NoteState.archived
                                    ? Icons.archive_rounded
                                    : Icons.archive_outlined,
                              ),
                              onPressed: () => _noteStateBloc.add(
                                ChangeNoteStateEvent(
                                  state: state.state == NoteState.archived
                                      ? NoteState.unspecified
                                      : NoteState.archived,
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                  body: NoteEditorForm(
                    noteContentController: _noteContentController,
                    noteTitleController: _noteTitleController,
                    readOnly: _readOnly,
                  ),
                  bottomNavigationBar: BlocProvider(
                    create: (context) => _noteColorBloc,
                    child: NoteEditorBottomBar(
                      strLastModified: _strLastModified,
                    ),
                  )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
