import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/embedded_asset_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/embedded_entry_widget.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomSheetVideoContentRenderer extends StatelessWidget {
  final List<Map<String, dynamic>> content;
  final Includes? assets;

  const BottomSheetVideoContentRenderer({
    super.key,
    required this.content,
    this.assets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content
          .map((jsonItem) => _BottomSheetContentWidget(
                jsonItem: jsonItem,
                assets: assets,
              ))
          .toList(),
    );
  }
}

class _BottomSheetContentWidget extends StatelessWidget {
  final Map<String, dynamic> jsonItem;
  final Includes? assets;

  const _BottomSheetContentWidget({
    required this.jsonItem,
    this.assets,
  });

  @override
  Widget build(BuildContext context) {
    final String nodeType = jsonItem['nodeType'];
    final List content = jsonItem['content'] ?? [];

    final widgetMapping = {
      'paragraph': _BottomSheetParagraphWidget(
        content: content,
        assets: assets,
      ),
      'heading-2': _BottomSheetHeadingWidget(content: content, level: 2),
      'heading-3': _BottomSheetHeadingWidget(content: content, level: 3),
      'unordered-list': _BottomSheetUnorderedListWidget(content: content, assets: assets),
      'ordered-list': _BottomSheetOrderedListWidget(content: content, assets: assets),
      'list-item': _BottomSheetListItemWidget(content: content, assets: assets),
      'embedded-entry-inline': EmbeddedEntryWidget(
        id: jsonItem['data']?['target']?['sys']?['id'] ?? '',
        assets: assets,
      ),
      'embedded-entry-block': EmbeddedEntryWidget(
        id: jsonItem['data']?['target']?['sys']?['id'] ?? '',
        assets: assets,
      ),
      'embedded-asset-block': EmbeddedAssetWidget(
        jsonItem: jsonItem,
        assets: assets,
      ),
    };

    return widgetMapping[nodeType] ?? const SizedBox.shrink();
  }
}

class _BottomSheetParagraphWidget extends StatelessWidget {
  final List content;
  final Includes? assets;

  const _BottomSheetParagraphWidget({
    required this.content,
    required this.assets,
  });

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

      // Handle nested paragraph or unknown types
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

    // Use 14px font size as specified
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    );

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
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    );

    return TextSpan(
      text: linkText,
      style: style,
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        },
    );
  }
}

class _BottomSheetHeadingWidget extends StatelessWidget {
  final List content;
  final int level;

  const _BottomSheetHeadingWidget({
    required this.content,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final String textContent = content.map((e) => e['value'] as String? ?? '').join(' ');
    
    // Use 14px base font size with appropriate scaling for headings
    final TextStyle textStyle = level == 2 
        ? textTheme.displayMedium?.copyWith(
            fontSize: 18, // Slightly larger than 14px for H2
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ) ?? const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          )
        : const TextStyle(
            fontSize: 16, // Slightly larger than 14px for H3
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        textContent,
        style: textStyle,
      ),
    );
  }
}

class _BottomSheetUnorderedListWidget extends StatelessWidget {
  final List content;
  final Includes? assets;

  const _BottomSheetUnorderedListWidget({
    required this.content,
    this.assets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text(
                "• ",
                style: TextStyle(fontSize: 14), // Use 14px for bullet
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item['content'].map<Widget>((subItem) {
                  return _BottomSheetContentWidget(
                    jsonItem: subItem,
                    assets: assets,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _BottomSheetOrderedListWidget extends StatelessWidget {
  final List content;
  final Includes? assets;

  const _BottomSheetOrderedListWidget({
    required this.content,
    this.assets,
  });

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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '$index. ',
                style: const TextStyle(fontSize: 14), // Use 14px for numbers
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: item['content'].map<Widget>((subItem) {
                  return _BottomSheetContentWidget(
                    jsonItem: subItem,
                    assets: assets,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _BottomSheetListItemWidget extends StatelessWidget {
  final List content;
  final Includes? assets;

  const _BottomSheetListItemWidget({
    required this.content,
    this.assets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.map<Widget>((subItem) {
        return _BottomSheetContentWidget(
          jsonItem: subItem,
          assets: assets,
        );
      }).toList(),
    );
  }
}