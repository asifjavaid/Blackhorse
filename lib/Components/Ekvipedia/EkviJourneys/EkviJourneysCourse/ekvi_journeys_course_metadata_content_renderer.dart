import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

/// Specialized content renderer for course metadata that uses bodySmall text style
class EkviJourneysCourseMetaDataContentRenderer extends StatelessWidget {
  final List<Map<String, dynamic>> content;
  final bool isExpanded;

  const EkviJourneysCourseMetaDataContentRenderer({
    super.key,
    required this.content,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: isExpanded
          ? _buildFullContent(textTheme)
          : _buildCollapsedContent(textTheme),
    );
  }

  Widget _buildFullContent(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content.asMap().entries.map((entry) {
        final index = entry.key;
        final isLast = index == content.length - 1;
        final jsonItem = entry.value;
        final String nodeType = jsonItem['nodeType'];
        final List itemContent = jsonItem['content'] ?? [];

        switch (nodeType) {
          case 'paragraph':
            return Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: isLast ? 0.0 : 8.0,
              ),
              child: Text.rich(
                TextSpan(
                  children: _parseContent(itemContent, textTheme),
                ),
              ),
            );
          case 'heading-2':
            return Padding(
              padding: EdgeInsets.only(
                top: 12.0,
                bottom: isLast ? 0.0 : 12.0,
              ),
              child: Text(
                _extractText(itemContent),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutralColor600,
                ),
              ),
            );
          case 'heading-3':
            return Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: isLast ? 0.0 : 10.0,
              ),
              child: Text(
                _extractText(itemContent),
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutralColor600,
                ),
              ),
            );
          case 'unordered-list':
            return Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: isLast ? 0.0 : 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: itemContent.map((item) {
                  if (item['nodeType'] == 'list-item') {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutralColor600)),
                          Expanded(
                            child: Text(
                              _extractText(item['content'] ?? []),
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutralColor600),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }).toList(),
              ),
            );
          case 'ordered-list':
            return Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: isLast ? 0.0 : 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: itemContent.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  if (item['nodeType'] == 'list-item') {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${index + 1}. ',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutralColor600)),
                          Expanded(
                            child: Text(
                              _extractText(item['content'] ?? []),
                              style: textTheme.bodySmall
                                  ?.copyWith(color: AppColors.neutralColor600),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }).toList(),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }

  Widget _buildCollapsedContent(TextTheme textTheme) {
    return Text.rich(
      TextSpan(
        children: _parseContentForCollapsed(content, textTheme),
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodySmall?.copyWith(
        color: AppColors.neutralColor600,
        height: 1.35,
      ),
    );
  }

  List<InlineSpan> _parseContent(List content, TextTheme textTheme) {
    return content.map<InlineSpan>((e) {
      final String nodeType = e['nodeType'];

      if (nodeType == 'text') {
        return _parseTextNode(e, textTheme);
      }

      if (nodeType == 'hyperlink') {
        return _parseHyperlinkNode(e, textTheme);
      }

      return const TextSpan(text: '');
    }).toList();
  }

  InlineSpan _parseTextNode(Map<String, dynamic> e, TextTheme textTheme) {
    final String text = e['value'] ?? '';
    final List marks = e['marks'] ?? [];

    TextStyle? style =
        textTheme.bodySmall?.copyWith(color: AppColors.neutralColor600);

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
      }
    }

    return TextSpan(text: text, style: style);
  }

  InlineSpan _parseHyperlinkNode(Map<String, dynamic> e, TextTheme textTheme) {
    final String url = e['data']['uri'] ?? '';
    final String linkText = e['content']?.first['value'] ?? '';
    TextStyle? style = textTheme.bodySmall?.copyWith(
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
          }
        },
    );
  }

  String _extractText(List content) {
    final buffer = StringBuffer();
    for (var item in content) {
      if (item['nodeType'] == 'text') {
        buffer.write(item['value'] ?? '');
      } else if (item['nodeType'] == 'paragraph' && item['content'] is List) {
        buffer.write(_extractText(item['content']));
      }
    }
    return buffer.toString();
  }

  List<InlineSpan> _parseContentForCollapsed(
      List<Map<String, dynamic>> content, TextTheme textTheme) {
    final List<InlineSpan> spans = [];

    for (var item in content) {
      final String nodeType = item['nodeType'];
      final List itemContent = item['content'] ?? [];

      if (nodeType == 'paragraph') {
        // Add paragraph content with proper spacing
        spans.addAll(_parseContent(itemContent, textTheme));
        spans.add(const TextSpan(text: ' '));
      } else if (nodeType == 'heading-2' || nodeType == 'heading-3') {
        // Add heading content with bold styling
        spans.add(TextSpan(
          text: _extractText(itemContent),
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            fontWeight: FontWeight.bold,
          ),
        ));
        spans.add(const TextSpan(text: ' '));
      }
    }

    return spans;
  }
}
