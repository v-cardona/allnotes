import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/blocs/note_color_bloc/note_color_bloc.dart';
import 'package:allnotes/presentation/journeys/note_single/note_editor_bottom_bar.dart';
import 'package:allnotes/presentation/journeys/note_single/note_editor_form.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _readOnly;
  String _strLastModified;

  @override
  void initState() {
    super.initState();
    _noteContentController = TextEditingController(text: widget.note?.content);
    _noteTitleController = TextEditingController(text: widget.note?.title);
    _noteColorBloc = getItInstance<NoteColorBloc>();
    _noteColorBloc.add(ChangeNoteColorEvent(
        color: widget.note?.color ?? AppColor.noteColorDefault));

    _readOnly = !(widget.note?.canEdit ?? true);
    _strLastModified = widget.note?.strLastModified;
  }

  @override
  void dispose() {
    super.dispose();
    _noteContentController.dispose();
    _noteTitleController.dispose();
    _noteColorBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _noteColorBloc,
      builder: (context, state) {
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
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: color,
                systemNavigationBarColor: color,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black54),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.push_pin_outlined,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.archive_outlined,
                        ),
                        onPressed: () {},
                      ),
                    ],
                    bottom: const PreferredSize(
                      preferredSize: Size(0, 24),
                      child: SizedBox(),
                    ),
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
    );
  }
}
