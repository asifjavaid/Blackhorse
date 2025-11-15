import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/content_widget.dart';
import 'package:flutter/material.dart';

class UnorderedListWidget extends StatelessWidget {
  final List content;

  const UnorderedListWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 12), child: Text("• ", style: TextStyle(fontSize: 16))),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item['content'].map<Widget>((subItem) {
                  return ContentWidget(jsonItem: subItem);
                }).toList(),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
