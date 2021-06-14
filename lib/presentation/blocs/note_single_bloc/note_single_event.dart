part of 'note_single_bloc.dart';

abstract class NoteSingleEvent extends Equatable {
  const NoteSingleEvent();

  @override
  List<Object> get props => [];
}

class SaveNoteSingleEvent extends NoteSingleEvent {
  final String title;
  final String content;
  final String id;
  final Color color;
  final NoteState state;
  final DateTime createdAt;

  SaveNoteSingleEvent({
    @required this.createdAt,
    @required this.color,
    @required this.state,
    @required this.title,
    @required this.content,
    this.id,
  });

  @override
  List<Object> get props => [
        id,
        title,
        content,
        color,
        state,
      ];
}
