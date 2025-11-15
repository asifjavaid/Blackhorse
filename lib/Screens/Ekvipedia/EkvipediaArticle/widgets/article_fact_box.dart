import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ArticleFactBox extends StatelessWidget {
  final EntryItem? item;

  const ArticleFactBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String factTitle = item?.fields["factTitle"] ?? "";
    Map<String, dynamic> factText = item?.fields["factText"] ?? {"content": []};

    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      decoration: ShapeDecoration(
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            factTitle,
            style: textTheme.displaySmall,
          ),
          const SizedBox(
            height: 16,
          ),
          _buildRichTextContent(factText, textTheme),
        ],
      ),
    );
  }

  Widget _buildRichTextContent(Map<String, dynamic> richText, TextTheme textTheme) {
    List<dynamic> content = richText['content'] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.map((node) => _buildNode(node, textTheme)).toList(),
    );
  }

  Widget _buildNode(Map<String, dynamic> node, TextTheme textTheme) {
    String nodeType = node['nodeType'];

    switch (nodeType) {
      case 'paragraph':
        return _buildParagraph(node, textTheme);
      case 'text':
        return _buildTextNode(node, textTheme);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildParagraph(Map<String, dynamic> node, TextTheme textTheme) {
    List<dynamic> content = node['content'] ?? [];

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content.map((textNode) => _buildNode(textNode, textTheme)).toList(),
      ),
    );
  }

  Widget _buildTextNode(Map<String, dynamic> node, TextTheme textTheme) {
    String text = node['value'] ?? "";
    List<dynamic> marks = node['marks'] ?? [];

    TextStyle textStyle = textTheme.bodyMedium!;

    for (var mark in marks) {
      switch (mark['type']) {
        case 'bold':
          textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
          break;
        case 'italic':
          textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
          break;
      }
    }

    return Text(text, style: textStyle);
  }
}
