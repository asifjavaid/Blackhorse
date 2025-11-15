import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_image_widget.dart';
import 'package:flutter/material.dart';

class EmbeddedAssetWidget extends StatelessWidget {
  final Map<String, dynamic> jsonItem;
  final Includes? assets;

  const EmbeddedAssetWidget({super.key, required this.jsonItem, required this.assets});

  @override
  Widget build(BuildContext context) {
    final String assetId = jsonItem['data']?['target']?['sys']?['id'] ?? '';
    
    final Asset? assetItem = EkvipediaContentEntries.getAssetById(assetId, assets);

    // If not found in assets, try to create from direct data
    String? imageURL;
    String? description;
    
    if (assetItem != null) {
      imageURL = assetItem.fields["file"]["url"];
      description = assetItem.fields["description"];
    } else {
      // Try to get from direct data
      final target = jsonItem['data']?['target'];
      if (target != null) {
        imageURL = target['fields']?['file']?['url'];
        description = target['fields']?['description'];
      }
    }


    return ArticleImage(
      imageURL: imageURL,
      description: description,
    );
  }
}
