part of 'edit_note_bloc.dart';

class EditNoteState extends Equatable {
  const EditNoteState({
    required this.color,
    required this.status,
    this.modifiedAt,
    this.errorType,
  });

  final Color color;
  final NoteState status;
  final DateTime? modifiedAt;
  final AppErrorType? errorType;

  @override
  List<Object> get props => [
        color.value,
        status.name,
        modifiedAt.toString(),
        errorType ?? '',
      ];

  EditNoteState copyWith({
    String? id,
    String? title,
    String? content,
    Color? color,
    NoteState? status,
    AppErrorType? errorType,
  }) {
    return EditNoteState(
      color: color ?? this.color,
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      modifiedAt: DateTime.now(),
    );
  }
}
