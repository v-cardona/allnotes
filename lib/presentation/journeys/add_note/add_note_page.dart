import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/blocs/edit_note/edit_note_bloc.dart';
import 'package:allnotes/presentation/journeys/add_note/add_note_appbar.dart';
import 'package:allnotes/presentation/journeys/add_note/add_note_arguments.dart';
import 'package:allnotes/presentation/widgets/text_input_note_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    super.key,
    this.arguments,
  });

  final AddNoteArguments? arguments;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late final EditNoteBloc _editNoteBloc;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String? _noteId;

  @override
  void initState() {
    super.initState();
    _editNoteBloc = getItInstance<EditNoteBloc>();
    // get note if available, and set parameters to edit mode
    NoteEntity? note = widget.arguments?.note;
    _titleController = TextEditingController(text: note?.title);
    _contentController = TextEditingController(text: note?.content);
    _noteId = note?.id;
    _editNoteBloc.add(
      InitEditNoteEvent(
        color: note?.color,
        status: note?.status,
        modifiedAt: note?.modifiedAt,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _editNoteBloc.close();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _editNoteBloc,
      child: SafeArea(
        child: BlocBuilder<EditNoteBloc, EditNoteState>(
          bloc: _editNoteBloc,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: state.color,
              appBar: const AddNoteAppbar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.dimen_20.h,
                    horizontal: Sizes.dimen_60.w,
                  ),
                  child: Column(
                    children: [
                      TextInputNoteWidget(
                        controller: _titleController,
                        hint: TranslationConstants.title.translate(context),
                        // onChanged: onChange,
                        maxLength: 50,
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                        textInputType: TextInputType.text,
                      ),
                      TextInputNoteWidget(
                        controller: _contentController,
                        hint: TranslationConstants.writeYourNote
                            .translate(context),
                        // onChanged: onChange,
                        maxLines: null,
                        textInputType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
