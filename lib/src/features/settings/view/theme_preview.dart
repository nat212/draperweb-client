import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThemePreview extends StatelessWidget {
  const ThemePreview({Key? key, required this.colorScheme, required this.title})
      : super(key: key);

  final ColorScheme colorScheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.outline,
          ),
          height: 64,
          width: 64,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: ClipOval(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Material(
                      color: colorScheme.primary,
                    ),
                  ),
                  Container(height: 0.5, color: colorScheme.outline),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: colorScheme.secondary,
                          ),
                        ),
                        Container(width: 0.5, color: colorScheme.outline),
                        Expanded(
                          child: Container(color: colorScheme.tertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(title),
      ],
    );
  }
}
