import 'package:flutter/material.dart';

class LoadingEffect extends StatelessWidget {
  final double size;
  const LoadingEffect({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(),
    );
  }
}
