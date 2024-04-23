import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

import 'package:allnotes/data/data_sources/notes_remote_data_source.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';

/// Repository which manages authentication
class NotesRepositoryImpl extends NotesRepository {
  NotesRepositoryImpl(this._notesRemoteDataSource);

  final NotesRemoteDataSource _notesRemoteDataSource;

  List<NoteEntity> _modelToEntityList(List<NoteModel> notesModel) {
    return notesModel.map((e) => NoteEntity.fromNoteModel(e)).toList();
  }

  @override
  Future<Either<AppError, bool>> createFirstNote(String userId) async {
    try {
      await _notesRemoteDataSource.createNote(
        userId,
        NoteModel.firstNote(),
      );
      return const Right(true);
    } catch (_) {
      return const Left(AppError(AppErrorType.cannotCreateCollection));
    }
  }

  @override
  Future<Either<AppError, List<NoteEntity>>> getAllNotes(String userId) async {
    try {
      List<NoteModel> notes = await _notesRemoteDataSource.getAllNotes(
        userId,
      );
      List<NoteEntity> notesEntities = _modelToEntityList(notes);
      return Right(notesEntities);
    } catch (_) {
      return const Left(AppError(AppErrorType.getAllNotes));
    }
  }

  @override
  Future<Either<AppError, List<NoteEntity>>> getUnspecifiedNotes(
      String userId) async {
    try {
      List<NoteModel> notes = await _notesRemoteDataSource.getUnspecifiedNotes(
        userId,
      );
      List<NoteEntity> notesEntities = _modelToEntityList(notes);
      return Right(notesEntities);
    } catch (_) {
      return const Left(AppError(AppErrorType.getAllNotes));
    }
  }
}
