import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/content_widget.dart';
import 'package:flutter/material.dart';

class OrderedListWidget extends StatelessWidget {
  final List content;

  const OrderedListWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.asMap().entries.map((entry) {
        final int index = entry.key + 1;
        final Map item = entry.value;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(top: 10), child: Text('$index. ', style: const TextStyle(fontSize: 14))),
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
