import 'package:flutter/material.dart';
import 'content_widget.dart';

class ListItemWidget extends StatelessWidget {
  final List content;

  const ListItemWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.map((item) {
        return ContentWidget(jsonItem: item);
      }).toList(),
    );
  }
}
