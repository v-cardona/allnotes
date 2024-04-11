enum NoteState {
  unspecified, // por defecto
  pinned, // fijado en la parte superior
  archived, // menu de archivado
  deleted, // papelera
}

class NoteStateEntity {
  final NoteState status;
  Map<NoteState, int> enumToIndex;

  NoteStateEntity({
    this.status = NoteState.unspecified,
  }) : enumToIndex = {} {
    for (var i = 0; i < NoteState.values.length; i++) {
      NoteState status = NoteState.values[i];
      enumToIndex[status] = i;
    }
  }

  int getEnumValue(NoteState noteState) {
    return enumToIndex[noteState] ?? 0;
  }
}
