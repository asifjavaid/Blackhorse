import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysModuleCompletion/module_completion_content_widget.dart';
import 'package:flutter/material.dart';

class ModuleCompletionContentRenderer extends StatelessWidget {
  final List<Map<String, dynamic>> content;
  final Includes? assets;

  const ModuleCompletionContentRenderer(
      {super.key, required this.content, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:
          content.map((jsonItem) => _buildCenteredContent(jsonItem)).toList(),
    );
  }

  Widget _buildCenteredContent(Map<String, dynamic> jsonItem) {
    final String nodeType = jsonItem['nodeType'];

    // For certain content types, we want to center them differently
    switch (nodeType) {
      case 'heading-2':
      case 'heading-3':
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ModuleCompletionContentWidget(
              jsonItem: jsonItem,
              assets: assets,
            ),
          ),
        );
      case 'paragraph':
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ModuleCompletionContentWidget(
              jsonItem: jsonItem,
              assets: assets,
            ),
          ),
        );
      case 'embedded-asset-block':
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ModuleCompletionContentWidget(
              jsonItem: jsonItem,
              assets: assets,
            ),
          ),
        );
      case 'unordered-list':
      case 'ordered-list':
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ModuleCompletionContentWidget(
              jsonItem: jsonItem,
              assets: assets,
            ),
          ),
        );
      default:
        return Center(
          child: ModuleCompletionContentWidget(
            jsonItem: jsonItem,
            assets: assets,
          ),
        );
    }
  }
}
