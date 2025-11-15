import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/embedded_asset_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/embedded_entry_widget.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/module_completion_heading.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/module_completion_centered_paragraph.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/list_item_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/ordered_list_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/unordered_list_widget.dart';
import 'package:flutter/material.dart';

class ModuleCompletionContentWidget extends StatelessWidget {
  final Map<String, dynamic> jsonItem;
  final Includes? assets;

  const ModuleCompletionContentWidget({super.key, required this.jsonItem, this.assets});

  @override
  Widget build(BuildContext context) {
    final String nodeType = jsonItem['nodeType'];
    final List content = jsonItem['content'] ?? [];

    final widgetMapping = {
      'paragraph': ModuleCompletionParagraph(
        content: content,
        assets: assets,
      ),
      'heading-2': ModuleCompletionHeading(content: content, level: 2),
      'heading-3': ModuleCompletionHeading(content: content, level: 3),
      'unordered-list': UnorderedListWidget(content: content),
      'ordered-list': OrderedListWidget(content: content),
      'list-item': ListItemWidget(content: content),
      'embedded-entry-inline': EmbeddedEntryWidget(
          id: jsonItem['data']?['target']?['sys']?['id'] ?? '', assets: assets),
      'embedded-entry-block': EmbeddedEntryWidget(
          id: jsonItem['data']?['target']?['sys']?['id'] ?? '', assets: assets),
      'embedded-asset-block':
          EmbeddedAssetWidget(jsonItem: jsonItem, assets: assets),
    };

    return widgetMapping[nodeType] ?? const SizedBox.shrink();
  }
}
