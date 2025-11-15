import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';

class LessonReferencePreview extends StatelessWidget {
  final dynamic lessonReferences;
  final LessonStructure? lesson;

  const LessonReferencePreview({
    super.key,
    required this.lessonReferences,
    this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    int total = countTotalBulletPoints(lessonReferences);
    TextTheme textTheme = Theme.of(context).textTheme;
    return total > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Divider(
                color: AppColors.primaryColor500,
                thickness: 1,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Links & References",
                style: textTheme.displayMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              _buildPreviewContent(lessonReferences, textTheme),
              const SizedBox(
                height: 32,
              ),
              total > 3
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () => AppNavigation.navigateTo(
                              AppRoutes.ekviJourneysLessonReferences,
                              arguments: ScreenArguments(lesson: lesson)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("See all References",
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.actionColor600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.actionColor600,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Divider(
                          color: AppColors.primaryColor500,
                          thickness: 1,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget _buildPreviewContent(dynamic lessonReferences, TextTheme textTheme) {
    List<dynamic> contentList = [];
    if (lessonReferences is Map<String, dynamic> && lessonReferences['content'] is List) {
      contentList = lessonReferences['content'];
    } else if (lessonReferences is List) {
      contentList = lessonReferences;
    }

    List<Widget> previewWidgets = [];
    int listItemCount = 0;
    const int maxListItems = 3;

    for (var item in contentList) {
      if (item['nodeType'] == 'paragraph') {
        // Show all paragraphs (headings)
        String text = _extractTextFromParagraph(item);
        if (text.trim().isNotEmpty) {
          previewWidgets.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                text,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: _hasBoldMarking(item) ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }
      } else if (item['nodeType'] == 'ordered-list' || item['nodeType'] == 'unordered-list') {
        // Show list items up to the limit
        if (item['content'] is List) {
          for (var listItem in item['content']) {
            if (listItemCount >= maxListItems) break;
            
            if (listItem['nodeType'] == 'list-item') {
              String listItemText = _extractTextFromListItem(listItem);
              if (listItemText.trim().isNotEmpty) {
                previewWidgets.add(
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['nodeType'] == 'unordered-list' ? '• ' : '${listItemCount + 1}. ',
                          style: textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: Text(
                            listItemText,
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                listItemCount++;
              }
            }
          }
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: previewWidgets,
    );
  }

  String _extractTextFromParagraph(Map<String, dynamic> paragraph) {
    if (paragraph['content'] is List) {
      return (paragraph['content'] as List<dynamic>)
          .map((textItem) => textItem['value'] ?? '')
          .join();
    }
    return '';
  }

  String _extractTextFromListItem(Map<String, dynamic> listItem) {
    if (listItem['content'] is List) {
      return (listItem['content'] as List<dynamic>)
          .expand((paragraph) => (paragraph['content'] as List<dynamic>? ?? []))
          .map((textItem) => textItem['value'] ?? '')
          .join();
    }
    return '';
  }

  bool _hasBoldMarking(Map<String, dynamic> paragraph) {
    if (paragraph['content'] is List) {
      for (var textItem in paragraph['content']) {
        if (textItem['marks'] is List) {
          for (var mark in textItem['marks']) {
            if (mark['type'] == 'bold') return true;
          }
        }
      }
    }
    return false;
  }
}

class LessonReferenceScreen extends StatelessWidget {
  final ScreenArguments arguments;

  const LessonReferenceScreen({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackNavigation(
                  title: "Links & References",
                  callback: () => AppNavigation.goBack(),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: LessonContentManager(
                        content: arguments.lesson?.lessonReferences)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BulletPointList extends StatelessWidget {
  final List<String> references;
  final String listType;

  const BulletPointList({
    super.key, 
    required this.references,
    this.listType = 'ordered-list',
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        children: _buildList(references, context),
        style: textTheme.bodyMedium,
      ),
    );
  }

  List<TextSpan> _buildList(
      List<String> references, BuildContext context) {
    List<TextSpan> spans = [];
    TextTheme textTheme = Theme.of(context).textTheme;

    for (int i = 0; i < references.length; i++) {
      if (listType == 'unordered-list') {
        spans.add(
          TextSpan(
            text: '• ',
            style: textTheme.bodyMedium,
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '${i + 1}. ',
            style: textTheme.bodyMedium,
          ),
        );
      }
      spans.add(
        TextSpan(
          text: '${references[i]}\n\n',
          style: textTheme.bodyMedium,
        ),
      );
    }
    return spans;
  }
}

class LessonContentManager extends StatelessWidget {
  final dynamic content;

  const LessonContentManager({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    if (content == null) {
      return const SizedBox.shrink();
    }

    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichContent(content, textTheme),
      ],
    );
  }

  Widget _buildRichContent(dynamic content, TextTheme textTheme) {
    if (content is Map<String, dynamic> && content['content'] is List) {
      final contentList = List<Map<String, dynamic>>.from(content['content']);
      return _buildContentItems(contentList, textTheme);
    }

    // Fallback to simple text extraction for backward compatibility
    List<String> references = extractLessonReferences(content);
    return BulletPointList(references: references);
  }

  Widget _buildContentItems(
      List<Map<String, dynamic>> contentList, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentList.asMap().entries.map((entry) {
        final index = entry.key;
        final isLast = index == contentList.length - 1;
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
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.neutralColor600)),
                          Expanded(
                            child: Text(
                              _extractText(item['content'] ?? []),
                              style: textTheme.bodyMedium
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
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.neutralColor600)),
                          Expanded(
                            child: Text(
                              _extractText(item['content'] ?? []),
                              style: textTheme.bodyMedium
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
        textTheme.bodyMedium?.copyWith(color: AppColors.neutralColor600);

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
    final String linkText = e['content']?.first['value'] ?? '';
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: AppColors.actionColor600,
      decoration: TextDecoration.underline,
    );

    return TextSpan(
      text: linkText,
      style: style,
      recognizer: null, // Remove URL launcher for now to match article references
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
}

List<String> extractFirstTwoBulletPoints(dynamic lessonReferences) {
  List<String> bulletPoints = [];

  // Handle document structure: lessonReferences -> content -> find ordered-list
  List<dynamic> contentList = [];
  if (lessonReferences is Map<String, dynamic> && lessonReferences['content'] is List) {
    contentList = lessonReferences['content'];
  } else if (lessonReferences is List) {
    contentList = lessonReferences;
  }

  var listNode = contentList.firstWhere(
    (item) => item['nodeType'] == 'ordered-list' || item['nodeType'] == 'unordered-list',
    orElse: () => <String, dynamic>{'content': []},
  );

  if (listNode['content'] is List) {
    (listNode['content'] as List<dynamic>).take(2).forEach((listItem) {
      if (listItem['content'] is List) {
        String bulletPoint = (listItem['content'] as List<dynamic>)
            .expand(
                (paragraph) => (paragraph['content'] as List<dynamic>? ?? []))
            .map((textItem) => textItem['value'] ?? '')
            .join();
        bulletPoints.add(bulletPoint);
      }
    });
  }

  return bulletPoints;
}

int countTotalBulletPoints(dynamic lessonReferences) {
  // Handle document structure: lessonReferences -> content -> count all list items
  List<dynamic> contentList = [];
  if (lessonReferences is Map<String, dynamic> && lessonReferences['content'] is List) {
    contentList = lessonReferences['content'];
  } else if (lessonReferences is List) {
    contentList = lessonReferences;
  }

  int totalListItems = 0;
  
  // Count list items across ALL lists
  for (var item in contentList) {
    if (item['nodeType'] == 'ordered-list' || item['nodeType'] == 'unordered-list') {
      if (item['content'] is List) {
        totalListItems += (item['content'] as List).length;
      }
    }
  }

  return totalListItems;
}

String getListType(dynamic lessonReferences) {
  // Handle document structure: lessonReferences -> content -> find list type
  List<dynamic> contentList = [];
  if (lessonReferences is Map<String, dynamic> && lessonReferences['content'] is List) {
    contentList = lessonReferences['content'];
  } else if (lessonReferences is List) {
    contentList = lessonReferences;
  }

  var listNode = contentList.firstWhere(
    (item) => item['nodeType'] == 'ordered-list' || item['nodeType'] == 'unordered-list',
    orElse: () => <String, dynamic>{'nodeType': 'ordered-list'},
  );

  return listNode['nodeType'] ?? 'ordered-list';
}

List<String> extractLessonReferences(dynamic lessonReferences) {
  List<String> references = [];

  if (lessonReferences == null) {
    return references;
  }

  // Handle the structure: document -> ordered-list -> list-item -> paragraph -> text
  if (lessonReferences is Map<String, dynamic>) {
    final content = lessonReferences['content'];
    if (content is List) {
      for (var item in content) {
        if (item is Map<String, dynamic> && item['nodeType'] == 'ordered-list') {
          final listContent = item['content'];
          if (listContent is List) {
            for (var listItem in listContent) {
              if (listItem is Map<String, dynamic> && listItem['nodeType'] == 'list-item') {
                final itemContent = listItem['content'];
                if (itemContent is List) {
                  for (var paragraph in itemContent) {
                    if (paragraph is Map<String, dynamic> && paragraph['nodeType'] == 'paragraph') {
                      final paragraphContent = paragraph['content'];
                      if (paragraphContent is List) {
                        String referenceText = '';
                        for (var textItem in paragraphContent) {
                          if (textItem is Map<String, dynamic> &&
                              textItem['nodeType'] == 'text' &&
                              textItem['value'] != null) {
                            referenceText += textItem['value'].toString();
                          }
                        }
                        if (referenceText.trim().isNotEmpty) {
                          references.add(referenceText.trim());
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        // Fallback: Handle paragraph structure for backward compatibility
        else if (item is Map<String, dynamic> && item['nodeType'] == 'paragraph') {
          final paragraphContent = item['content'];
          if (paragraphContent is List) {
            String referenceText = '';
            for (var textItem in paragraphContent) {
              if (textItem is Map<String, dynamic> &&
                  textItem['nodeType'] == 'text' &&
                  textItem['value'] != null) {
                referenceText += textItem['value'].toString();
              }
            }
            if (referenceText.trim().isNotEmpty) {
              references.add(referenceText.trim());
            }
          }
        }
      }
    }
  }

  return references;
}