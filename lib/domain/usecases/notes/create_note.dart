import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/entities/params/note_params.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';

class CreateNote extends UseCase<Future<Either<AppError, bool>>, NoteParams> {
  final NotesRepository notesRepository;

  CreateNote(this.notesRepository);

  @override
  Future<Either<AppError, bool>> call(NoteParams params) async {
    return notesRepository.createNote(params.note);
  }
}
