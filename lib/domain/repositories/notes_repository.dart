import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/app_error_entity.dart';

abstract class NotesRepository {
  /// create first note
  Future<Either<AppError, bool>> createFirstNote();

  /// create note
  Future<Either<AppError, bool>> createNote(NoteEntity note);

  /// edit note
  Future<Either<AppError, bool>> editNote(NoteEntity note);

  /// get all notes
  Future<Either<AppError, List<NoteEntity>>> getAllNotes();

  /// get getUnspecifiedNotes notes
  Future<Either<AppError, List<NoteEntity>>> getUnspecifiedNotes();
}
