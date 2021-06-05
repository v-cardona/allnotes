import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/no_params.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetAllNotes
    extends UseCase<Either<AppError, List<NoteEntity>>, NoParams> {
  final NotesRepository repository;

  GetAllNotes(this.repository);

  @override
  Future<Either<AppError, List<NoteEntity>>> call(NoParams noParams) async {
    return await repository.getAllNotes();
  }
}
