import 'package:flutter/material.dart';

class LoadingEffect extends StatelessWidget {
  final double size;
  const LoadingEffect({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(),
    );
  }
}
