import 'package:allnotes/data/data_sources/notes_remote_data_source.dart';
import 'package:allnotes/data/models/note_model.dart';
import 'package:allnotes/domain/entities/app_error.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

/// {@template notes_repository}
/// Repository which manages crud of notes in cloud firestore
/// {@endtemplate}
class NotesRepositoryImpl extends NotesRepository {
  final NotesRemoteDataSource remoteDataSource;

  NotesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<NoteModel>>> getAllNotes() async {
    try {
      List<NoteModel> notes = await remoteDataSource.getAllNotes();
      return Right(notes);
    } on Exception {
      return Left(AppError(AppErrorType.firebaseConnection));
    }
  }

  @override
  Future<Either<AppError, bool>> addNote(NoteEntity note) async {
    try {
      NoteModel noteModel = NoteModel.fromNoteEntity(note);
      bool noteAdded = await remoteDataSource.addNote(noteModel);
      if (noteAdded) {
        return Right(noteAdded);
      } else {
        return Left(AppError(AppErrorType.addNoteFailed));
      }
    } on Exception {
      return Left(AppError(AppErrorType.general));
    }
  }

  @override
  Future<Either<AppError, bool>> updateNote(NoteEntity note) async {
    try {
      NoteModel noteModel = NoteModel.fromNoteEntity(note);
      bool noteUpdated = await remoteDataSource.updateNote(noteModel);
      if (noteUpdated) {
        return Right(noteUpdated);
      } else {
        return Left(AppError(AppErrorType.updateNoteFailed));
      }
    } on Exception {
      return Left(AppError(AppErrorType.general));
    }
  }
}
