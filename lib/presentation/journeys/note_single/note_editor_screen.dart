import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/journeys/note_single/note_editor_bottom_bar.dart';
import 'package:allnotes/presentation/journeys/note_single/note_editor_form.dart';
import 'package:allnotes/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteEntity note;

  NoteEditorScreen({Key key, this.note}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  NoteEntity _note;
  TextEditingController _noteContentController;
  TextEditingController _noteTitleController;

  @override
  void initState() {
    super.initState();
    _noteContentController = TextEditingController(text: widget.note?.content);
    _noteTitleController = TextEditingController(text: widget.note?.title);

    _note = widget.note;
  }

  @override
  void dispose() {
    super.dispose();
    _noteContentController.dispose();
    _noteTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: _note?.color ?? AppColor.noteColorDefault,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 0,
            ),
        scaffoldBackgroundColor: _note?.color ?? AppColor.noteColorDefault,
        bottomAppBarColor: _note?.color ?? AppColor.noteColorDefault,
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: _note?.color,
          systemNavigationBarColor: _note?.color,
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
              readOnly: !(_note?.canEdit ?? true),
            ),
            bottomNavigationBar: NoteEditorBottomBar(
              color: _note?.color ?? AppColor.noteColorDefault,
              strLastModified: _note?.strLastModified,
            )),
      ),
    );
  }
}
