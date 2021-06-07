import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translation_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
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

  @override
  void initState() {
    super.initState();
    _note = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: _note?.color ?? AppColor.white,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 0,
            ),
        scaffoldBackgroundColor: _note?.color ?? AppColor.white,
        bottomAppBarColor: _note?.color ?? AppColor.white,
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
              note: _note,
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.only(left: Sizes.dimen_10.w),
                child: Row(
                  children: [
                    Text(_note != null
                        ? TranslationConstants.edited.translate(context) +
                            ' ${_note?.strLastModified}'
                        : ''),
                    Expanded(
                      child: Row(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: Colors.black54,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
