import 'package:ekvi/Components/Ekvipedia/flat_news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ArticleLinkedArticle extends StatelessWidget {
  final EntryItem? item;
  final Includes? assets;
  const ArticleLinkedArticle({required this.item, required this.assets, super.key});

  @override
  Widget build(BuildContext context) {
    final String? title = item?.fields["title"];
    final String? date = HelperFunctions.formatDateTimetoMonthYear(
      item?.fields["date"],
    );
    final String? imageURL = EkvipediaContentEntries.getFaturedImageURL(item, assets);
    return FlatNewsCard(
      imagePath: imageURL,
      date: date,
      title: title ?? "",
      onPressed: () => AppNavigation.navigateTo(AppRoutes.ekvipediaArticle, arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: assets))),
    );
  }
}
