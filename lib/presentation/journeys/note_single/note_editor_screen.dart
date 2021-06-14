import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/blocs/note_color_bloc/note_color_bloc.dart';
import 'package:allnotes/presentation/blocs/note_single_bloc/note_single_bloc.dart';
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
  NoteSingleBloc _noteSingleBloc;
  bool _readOnly;
  String _strLastModified;
  String _noteId;
  DateTime _createdAt;

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
    _noteSingleBloc = getItInstance<NoteSingleBloc>();

    _readOnly = !(widget.note?.canEdit ?? true);
    _strLastModified = widget.note?.strLastModified;
    _noteId = widget.note?.id;
    _createdAt = widget.note?.createdAt;
  }

  @override
  void dispose() {
    super.dispose();
    _noteContentController.dispose();
    _noteTitleController.dispose();
    _noteColorBloc.close();
    _noteStateBloc.close();
    _noteSingleBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _noteColorBloc),
        BlocProvider.value(value: _noteStateBloc),
        BlocProvider.value(value: _noteSingleBloc),
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
              child: WillPopScope(
                onWillPop: () {
                  if (_noteContentController.text != '' ||
                      _noteTitleController.text != '') {
                    NoteColorChanged noteColorChanged = _noteColorBloc.state;
                    NoteStateChanged noteStateChanged = _noteStateBloc.state;
                    _noteSingleBloc.add(
                      SaveNoteSingleEvent(
                        createdAt: _createdAt,
                        content: _noteContentController.text,
                        title: _noteTitleController.text != ''
                            ? _noteTitleController.text
                            : TranslationConstants.untitled.translate(context),
                        id: _noteId,
                        color: noteColorChanged.color,
                        state: noteStateChanged.state,
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                  return Future.value(false);
                },
                child: Scaffold(
                    appBar: AppBar(
                      iconTheme: const IconThemeData(color: Colors.black54),
                      actions: [
                        BlocConsumer<NoteStateBloc, NoteStateState>(
                          listener: (context, state) {
                            if (state is NoteStateChanged) {
                              String message = '';
                              if (state.state == NoteState.pinned) {
                                message = TranslationConstants.notePinned
                                    .translate(context);
                              } else if (state.state == NoteState.archived) {
                                message = TranslationConstants.noteArchived
                                    .translate(context);
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
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
