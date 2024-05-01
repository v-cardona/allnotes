part of 'edit_note_bloc.dart';

class EditNoteState extends Equatable {
  const EditNoteState({
    required this.color,
    required this.status,
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.errorType,
    this.isSaved = false,
  });

  final String? id;
  final Color color;
  final NoteState status;
  final DateTime? createdAt;
  final DateTime? modifiedAt;
  final AppErrorType? errorType;
  final bool isSaved;

  @override
  List<Object> get props => [
        id ?? '',
        color.value,
        status.name,
        modifiedAt.toString(),
        createdAt.toString(),
        errorType ?? '',
        isSaved,
      ];

  EditNoteState copyWith({
    String? id,
    Color? color,
    NoteState? status,
    DateTime? createdAt,
    AppErrorType? errorType,
    bool? isSaved,
  }) {
    return EditNoteState(
      id: id ?? this.id,
      color: color ?? this.color,
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      createdAt: createdAt ?? this.createdAt,
      isSaved: isSaved ?? this.isSaved,
      modifiedAt: DateTime.now(),
    );
  }
}
