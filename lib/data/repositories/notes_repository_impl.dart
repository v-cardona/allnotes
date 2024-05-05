import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:allnotes/data/data_sources/notes_remote_data_source.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';

/// Repository which manages authentication
class NotesRepositoryImpl extends NotesRepository {
  NotesRepositoryImpl(
    this._notesRemoteDataSource,
    this._authenticationRepository,
  );

  final NotesRemoteDataSource _notesRemoteDataSource;
  final AuthenticationRepository _authenticationRepository;

  List<NoteEntity> _modelToEntityList(List<NoteModel> notesModel) {
    return notesModel.map((e) => NoteEntity.fromNoteModel(e)).toList();
  }

  @override
  Future<Either<AppError, bool>> createFirstNote() async {
    try {
      String userId = _authenticationRepository.getUserId();
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
  Future<Either<AppError, bool>> createNote(NoteEntity note) async {
    try {
      String userId = _authenticationRepository.getUserId();
      await _notesRemoteDataSource.createNote(
        userId,
        NoteModel.fromNoteEntity(note),
      );
      return const Right(true);
    } catch (_) {
      return const Left(AppError(AppErrorType.cannotCreateNote));
    }
  }

  @override
  Future<Either<AppError, bool>> editNote(NoteEntity note) async {
    try {
      String userId = _authenticationRepository.getUserId();
      await _notesRemoteDataSource.editNote(
        userId,
        NoteModel.fromNoteEntity(note),
      );
      return const Right(true);
    } catch (_) {
      return const Left(AppError(AppErrorType.cannotEditNote));
    }
  }

  @override
  Future<Either<AppError, bool>> removeNote(NoteEntity note) async {
    try {
      String userId = _authenticationRepository.getUserId();
      await _notesRemoteDataSource.removeNote(
        userId,
        NoteModel.fromNoteEntity(note),
      );
      return const Right(true);
    } catch (_) {
      return const Left(AppError(AppErrorType.cannotRemoveNote));
    }
  }

  @override
  Future<Either<AppError, List<NoteEntity>>> getAllNotes() async {
    try {
      String userId = _authenticationRepository.getUserId();
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
  Future<Either<AppError, List<NoteEntity>>> getUnspecifiedNotes() async {
    try {
      String userId = _authenticationRepository.getUserId();
      List<NoteModel> notes = await _notesRemoteDataSource.getUnspecifiedNotes(
        userId,
      );
      List<NoteEntity> notesEntities = _modelToEntityList(notes);
      return Right(notesEntities);
    } catch (_) {
      return const Left(AppError(AppErrorType.getAllNotes));
    }
  }

  @override
  Future<Either<AppError, List<NoteEntity>>> getArchivedNotes() async {
    try {
      String userId = _authenticationRepository.getUserId();
      List<NoteModel> notes = await _notesRemoteDataSource.getArchivedNotes(
        userId,
      );
      List<NoteEntity> notesEntities = _modelToEntityList(notes);
      return Right(notesEntities);
    } catch (_) {
      return const Left(AppError(AppErrorType.getAllNotes));
    }
  }

  @override
  Future<Either<AppError, List<NoteEntity>>> getDeletedNotes() async {
    try {
      String userId = _authenticationRepository.getUserId();
      List<NoteModel> notes = await _notesRemoteDataSource.getDeletedNotes(
        userId,
      );
      List<NoteEntity> notesEntities = _modelToEntityList(notes);
      return Right(notesEntities);
    } catch (_) {
      return const Left(AppError(AppErrorType.getAllNotes));
    }
  }

  @override
  Future<Either<AppError, List<NoteEntity>>> getPinnedNotes() async {
    try {
      String userId = _authenticationRepository.getUserId();
      List<NoteModel> notes = await _notesRemoteDataSource.getPinnedNotes(
        userId,
      );
      List<NoteEntity> notesEntities = _modelToEntityList(notes);
      return Right(notesEntities);
    } catch (_) {
      return const Left(AppError(AppErrorType.getAllNotes));
    }
  }
}
