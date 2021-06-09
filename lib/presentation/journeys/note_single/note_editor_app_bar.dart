import 'package:allnotes/common/constants/size_constants.dart';
import 'package:allnotes/common/extensions/size_extensions.dart';
import 'package:allnotes/domain/entities/note_entity.dart';
import 'package:allnotes/presentation/blocs/note_state_bloc/note_state_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteEditorAppBar extends StatelessWidget {
  const NoteEditorAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: Sizes.dimen_12.h,
          ),
        ),
        BlocBuilder<NoteStateBloc, NoteStateState>(
          builder: (context, state) {
            if (state is NoteStateChanged) {
              return Icon(
                state.state == NoteState.pinned
                    ? Icons.push_pin_rounded
                    : Icons.push_pin_outlined,
                size: Sizes.dimen_12.h,
              );
            } else {
              return Icon(
                Icons.push_pin_outlined,
                size: Sizes.dimen_12.h,
              );
            }
          },
        )
      ],
    );
  }
}
