import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/embedded_entry_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ParagraphWidget extends StatelessWidget {
  final List content;
  final Includes? assets;

  const ParagraphWidget({super.key, required this.content, required this.assets});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text.rich(
        TextSpan(
          children: _parseContent(content, textTheme, assets),
        ),
      ),
    );
  }

  List<InlineSpan> _parseContent(List content, TextTheme textTheme, Includes? assets) {
    return content.map<InlineSpan>((e) {
      final String nodeType = e['nodeType'];

      if (nodeType == 'text') {
        return _parseTextNode(e, textTheme);
      }

      if (nodeType == 'hyperlink') {
        return _parseHyperlinkNode(e, textTheme);
      }

      if (nodeType == 'embedded-entry-inline') {
        return WidgetSpan(
          child: EmbeddedEntryWidget(
            id: e['data']?['target']?['sys']?['id'] ?? '',
            assets: assets,
            directData: e['data'],
          ),
        );
      }

      // ✅ New: handle nested paragraph or unknown types
      if (nodeType == 'paragraph' && e['content'] is List) {
        return TextSpan(
          children: _parseNestedContent(e['content'], textTheme, assets),
        );
      }

      return const TextSpan(text: '');
    }).toList();
  }

  List<InlineSpan> _parseNestedContent(List content, TextTheme textTheme, Includes? assets) {
    return content.map<InlineSpan>((e) {
      final String nodeType = e['nodeType'];

      if (nodeType == 'text') {
        return _parseTextNode(e, textTheme);
      }

      if (nodeType == 'hyperlink') {
        return _parseHyperlinkNode(e, textTheme);
      }

      if (nodeType == 'embedded-entry-inline') {
        return WidgetSpan(
          child: EmbeddedEntryWidget(
            id: e['data']?['target']?['sys']?['id'] ?? '',
            assets: assets,
            directData: e['data'],
          ),
        );
      }

      // Recursively handle deeply nested paragraphs
      if (nodeType == 'paragraph' && e['content'] is List) {
        return TextSpan(
          children: _parseNestedContent(e['content'], textTheme, assets),
        );
      }

      return const TextSpan(text: '');
    }).toList();
  }

  InlineSpan _parseTextNode(Map<String, dynamic> e, TextTheme textTheme) {
    final String text = e['value'] ?? '';
    final List marks = e['marks'] ?? [];

    TextStyle? style = textTheme.bodyMedium;

    for (var mark in marks) {
      switch (mark['type']) {
        case 'bold':
          style = style?.copyWith(fontWeight: FontWeight.bold);
          break;
        case 'italic':
          style = style?.copyWith(fontStyle: FontStyle.italic);
          break;
        case 'underline':
          style = style?.copyWith(decoration: TextDecoration.underline);
          break;
        case 'superscript':
          return WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: Transform.translate(
              offset: const Offset(0, -8),
              child: Text(
                text,
                style: style?.copyWith(
                  fontSize: style.fontSize != null ? style.fontSize! * 0.7 : null,
                ),
              ),
            ),
          );
      }
    }

    return TextSpan(
      text: text,
      style: style,
    );
  }

  InlineSpan _parseHyperlinkNode(Map<String, dynamic> e, TextTheme textTheme) {
    final String url = e['data']['uri'] ?? '';
    final String linkText = e['content']?.first['value'] ?? '';
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: AppColors.actionColor600,
      decoration: TextDecoration.underline,
    );

    return TextSpan(
      text: linkText,
      style: style,
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
    );
  }
}
