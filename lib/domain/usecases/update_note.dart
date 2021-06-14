import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/note_params.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateNote extends UseCase<Either<AppError, bool>, NoteParams> {
  final NotesRepository repository;

  UpdateNote(this.repository);

  @override
  Future<Either<AppError, bool>> call(NoteParams noteParams) async {
    return await repository.updateNote(noteParams.note);
  }
}
