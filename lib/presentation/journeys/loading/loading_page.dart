import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allnotes/presentation/blocs/loading/loading_cubit.dart';
import 'package:allnotes/presentation/journeys/loading/loading_effect.dart';
import 'package:allnotes/presentation/journeys/loading/loading_initial.dart';

class LoadingPage extends StatelessWidget {
  final Widget screen;
  const LoadingPage({
    super.key,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            screen,
            if (state is ShowLoadingState)
              state.isInitial
                  ? const LoadingInitial()
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                      ),
                      child: const Center(
                        child: LoadingEffect(),
                      ),
                    )
          ],
        );
      },
    );
  }
}
