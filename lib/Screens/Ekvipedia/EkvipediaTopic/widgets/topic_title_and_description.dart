import 'package:flutter/material.dart';

class TopicTitleAndDescription extends StatelessWidget {
  final String? title;
  final String? preview;
  const TopicTitleAndDescription({super.key, required this.title, required this.preview});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        title != null
            ? Text(
                title!,
                style: textTheme.displaySmall,
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 8,
        ),
        preview != null
            ? Text(
                preview!,
                style: textTheme.bodySmall,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
