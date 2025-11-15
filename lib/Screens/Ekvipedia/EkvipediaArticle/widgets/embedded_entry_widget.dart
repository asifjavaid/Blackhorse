import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_author.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_fact_box.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_linked_article.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_quote.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_workbook.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/redirect_button.dart';
import 'package:flutter/material.dart';

class EmbeddedEntryWidget extends StatelessWidget {
  final String id;
  final Includes? assets;
  final Map<String, dynamic>? directData;

  const EmbeddedEntryWidget({
    super.key, 
    required this.id, 
    required this.assets,
    this.directData,
  });

  @override
  Widget build(BuildContext context) {
    final String entryAssetId = id;
    EntryItem? entryAssetItem;
    String? entryType;

    // First try to get from assets
    entryAssetItem = EkvipediaContentEntries.getIncludesEntryById(entryAssetId, assets);
    entryType = EkvipediaContentEntries.getEntryCategory(entryAssetItem);

    // If not found in assets and we have direct data, create entry from direct data
    if (entryAssetItem == null && directData != null) {
      entryAssetItem = _createEntryFromDirectData(directData!);
      entryType = _getEntryTypeFromDirectData(directData!);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: getEmbeddedAssetEntryWidget(entryType, entryAssetItem, assets: assets),
    );
  }

  EntryItem? _createEntryFromDirectData(Map<String, dynamic> data) {
    final target = data['target'];
    if (target == null) return null;

    final entryItem = EntryItem(
      sys: Sys(properties: target['sys'] ?? {}),
      fields: target['fields'] ?? {},
      metadata: Metadata(properties: target['metadata'] ?? {}),
    );
    return entryItem;
  }

  String? _getEntryTypeFromDirectData(Map<String, dynamic> data) {
    final target = data['target'];
    if (target == null) return null;
    
    // Try different paths for content type
    var contentType = target['sys']?['contentType'];
    
    // If it's a nested structure, try the nested path
    if (contentType is Map && contentType['sys'] != null) {
      contentType = contentType['sys'];
    }
    
    if (contentType is Map && contentType['id'] != null) {
      return contentType['id'];
    }
    return null;
  }
}

Widget getEmbeddedAssetEntryWidget(String? entryType, EntryItem? item, {Includes? assets}) {
  switch (entryType) {
    case "factBox":
      return ArticleFactBox(item: item);
    case "quote":
      return ArticleQuote(item: item);
    case "author":
      return ArticleAuthor(
        item: item,
        assets: assets,
        onTap: () {},
      );
    case "appContent":
      return ArticleLinkedArticle(
        item: item,
        assets: assets,
      );
    case "redirectButton":
      return RedirectButton(
        item: item,
        assets: assets,
      );
    case "downloadFile":
      return ArticleWorkbook(
        item: item,
        assets: assets,
      );
    default:
      return const SizedBox.shrink();
  }
}
