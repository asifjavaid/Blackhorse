import 'package:flutter/material.dart';

class ModuleCompletionHeading extends StatelessWidget {
  final List content;
  final int level;

  const ModuleCompletionHeading(
      {super.key, required this.content, required this.level});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final String textContent =
        content.map((e) => e['value'] as String? ?? '').join(' ');
    final TextStyle textStyle = level == 2
        ? textTheme.displayMedium!
        : const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        textContent,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
