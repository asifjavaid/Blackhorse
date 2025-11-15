import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/content_widget.dart';
import 'package:flutter/material.dart';

class ArticleContentManager extends StatelessWidget {
  final List<Map<String, dynamic>> content;
  final Includes? assets;

  const ArticleContentManager({super.key, required this.content, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content
          .map((jsonItem) => ContentWidget(
                jsonItem: jsonItem,
                assets: assets,
              ))
          .toList(),
    );
  }
}
