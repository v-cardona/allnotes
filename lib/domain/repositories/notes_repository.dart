import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';

abstract class NotesRepository {
  /// create the collection
  Future<Either<AppError, bool>> createFirstNote();

  /// get all notes
  Future<Either<AppError, List<NoteEntity>>> getAllNotes();

  /// get getUnspecifiedNotes notes
  Future<Either<AppError, List<NoteEntity>>> getUnspecifiedNotes();
}
