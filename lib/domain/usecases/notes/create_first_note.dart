import 'package:dartz/dartz.dart';

import 'package:allnotes/domain/entities/params/user_id_param.dart';
import 'package:allnotes/domain/repositories/notes_repository.dart';
import 'package:allnotes/domain/entities/app_error_entity.dart';
import 'package:allnotes/domain/usecases/usecase.dart';

class CreateFirstNote
    extends UseCase<Future<Either<AppError, bool>>, UserIdParams> {
  final NotesRepository notesRepository;

  CreateFirstNote(this.notesRepository);

  @override
  Future<Either<AppError, bool>> call(UserIdParams params) async {
    return notesRepository.createFirstNote(params.userId);
  }
}
