import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/constants/translations_constants.dart';
import 'package:allnotes/common/extensions/context._extension.dart';
import 'package:allnotes/common/extensions/error_extension.dart';
import 'package:allnotes/common/extensions/string_extensions.dart';
import 'package:allnotes/common/utils/utils.dart';
import 'package:allnotes/di/get_it.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/blocs/edit_note/edit_note_bloc.dart';
import 'package:allnotes/presentation/journeys/add_note/add_note_appbar.dart';
import 'package:allnotes/presentation/journeys/add_note/add_note_arguments.dart';
import 'package:allnotes/presentation/widgets/text_input_note_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  late NoteEntity? _notePrevious;

  @override
  void initState() {
    super.initState();
    _editNoteBloc = getItInstance<EditNoteBloc>();
    // get note if available, and set parameters to edit mode
    _notePrevious = widget.arguments?.note;
    _titleController = TextEditingController(text: _notePrevious?.title);
    _contentController = TextEditingController(text: _notePrevious?.content);
    _editNoteBloc.add(
      InitEditNoteEvent(
        color: _notePrevious?.color,
        status: _notePrevious?.status,
        modifiedAt: _notePrevious?.modifiedAt,
        id: _notePrevious?.id,
        createdAt: _notePrevious?.createdAt,
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
        child: BlocConsumer<EditNoteBloc, EditNoteState>(
          bloc: _editNoteBloc,
          listener: (context, state) {
            if (state.isSaved) {
              // si se ha guardado cerrar la pagina de notas
              context.pop();
              if (state.status == NoteState.deleted) {
                // si se ha borrado, estara en el bottom sheet, por eso tiene que hacer 2 pop, el del bottom y la pagina
                context.pop();
              }
            } else if (state.errorType != null) {
              context.showErrorSnackBar(
                message: AppError(state.errorType!).getMessage(context),
              );
            }
          },
          builder: (context, state) {
            return PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) async {
                if (didPop) {
                  return;
                }
                // check if has edit or change something and not save
                if (_hasChangeData(state)) {
                  context.showDiscardDialog(
                    title: TranslationConstants.discardEditConfirmation,
                    onPressed: () {
                      // close alert, and edit page
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Scaffold(
                backgroundColor: state.color,
                appBar: AddNoteAppbar(
                  content: _contentController.text,
                  title: _titleController.text,
                  readOnly: isNoteArchived(),
                ),
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          Sizes.dimen_60.w,
                          Sizes.dimen_20.h,
                          Sizes.dimen_60.w,
                          Sizes.dimen_200.h,
                        ),
                        child: Column(
                          children: [
                            TextInputNoteWidget(
                              controller: _titleController,
                              hint:
                                  TranslationConstants.title.translate(context),
                              maxLength: 50,
                              textStyle:
                                  Theme.of(context).textTheme.headlineLarge,
                              textInputType: TextInputType.text,
                              readOnly: isNoteArchived(),
                            ),
                            TextInputNoteWidget(
                              controller: _contentController,
                              hint: TranslationConstants.writeYourNote
                                  .translate(context),
                              maxLines: null,
                              textInputType: TextInputType.multiline,
                              readOnly: isNoteArchived(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _bottomBar(state.color, _notePrevious == null),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isNoteArchived() {
    return _notePrevious?.status == NoteState.archived;
  }

  Widget _bottomBar(Color color, bool isNewNote) {
    Widget button = ElevatedButton.icon(
      onPressed: () => _editNoteBloc.add(
        SaveEditNoteEvent(
          title: _titleController.text,
          content: _contentController.text,
        ),
      ),
      icon: const Icon(Icons.save_outlined),
      label: Text(TranslationConstants.save.translate(context)),
    );
    if (isNewNote) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_60.w,
          vertical: Sizes.dimen_10.h,
        ),
        child: button,
      );
    }
    if (isNoteArchived()) {
      button = Text(
        TranslationConstants.readOnly.translate(context),
        style: Theme.of(context).textTheme.headlineSmall,
      );
    }
    return Container(
      color: Utils.darken(color, 0.2),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_60.w,
          vertical: Sizes.dimen_10.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                style: const TextStyle(fontStyle: FontStyle.italic),
                children: [
                  TextSpan(
                      text:
                          TranslationConstants.lastUpdated.translate(context)),
                  TextSpan(text: TranslationConstants.colon.translate(context)),
                  TextSpan(text: TranslationConstants.space.translate(context)),
                  TextSpan(text: _notePrevious?.strLastModified),
                ],
              ),
            ),
            button
          ],
        ),
      ),
    );
  }

  bool _hasChangeData(EditNoteState state) {
    return !(_notePrevious != null &&
        _notePrevious!.color.value == state.color.value &&
        _notePrevious!.status == state.status &&
        _notePrevious!.title == _titleController.text &&
        _notePrevious!.content == _contentController.text);
  }
}
