import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/entities/params/no_params.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/usecases/usecase.dart';

class GetUnspecifiedNotes
    extends UseCase<Future<Either<AppError, List<NoteEntity>>>, NoParams> {
  final NotesRepository notesRepository;

  GetUnspecifiedNotes(this.notesRepository);

  @override
  Future<Either<AppError, List<NoteEntity>>> call(NoParams params) async {
    return notesRepository.getUnspecifiedNotes();
  }
}
