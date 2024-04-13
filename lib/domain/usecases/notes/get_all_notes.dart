import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/entities/params/user_id_param.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/usecases/usecase.dart';

class GetAllNotes
    extends UseCase<Future<Either<AppError, List<NoteEntity>>>, UserIdParams> {
  final NotesRepository notesRepository;

  GetAllNotes(this.notesRepository);

  @override
  Future<Either<AppError, List<NoteEntity>>> call(UserIdParams params) async {
    return notesRepository.getAllNotes(params.userId);
  }
}
