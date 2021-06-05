import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NotesRepository {
  /// Returns all notes of current user [User]
  Future<Either<AppError, List<NoteEntity>>> getAllNotes();
}
