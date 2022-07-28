import 'dart:math';

import 'package:flutter/material.dart';

class AdaptivePadding extends StatelessWidget {
  const AdaptivePadding({Key? key, required this.child, this.maxWidth = 600}) : super(key: key);

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: min(constraints.maxWidth, maxWidth),
          ),
          child: child,
        ),
      ),
    );
  }
}
