part of 'note_color_bloc.dart';

abstract class NoteColorState extends Equatable {
  const NoteColorState();

  @override
  List<Object> get props => [];
}

class NoteColorInitial extends NoteColorState {}

class NoteColorChanging extends NoteColorState {}

class NoteColorChanged extends NoteColorState {
  final Color color;

  NoteColorChanged({
    @required this.color,
  });

  @override
  List<Object> get props => [color];
}
