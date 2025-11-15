import 'package:ekvi/Components/Ekvipedia/flat_news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_amplitude_events.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:flutter/material.dart';

class ArticleTopics extends StatelessWidget {
  final EkvipediaContentEntries articleTopics;

  const ArticleTopics({super.key, required this.articleTopics});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Track. Learn. Thrive.", style: textTheme.displaySmall),
          const SizedBox(
            height: 8,
          ),
          Text(
            "From pain and fatigue to brain fog and bloating, dive into expert tips, lifestyle changes, and self-care routines for every symptom you’re tracking.",
            style: textTheme.bodySmall,
            textAlign: TextAlign.left,
          ),
          Column(
            children: articleTopics.items?.map((topic) {
                  return FlatNewsCard(
                      imagePath: EkvipediaContentEntries.getFaturedImageURL(topic, articleTopics.includes, isTopic: true),
                      title: topic.fields["name"] ?? "",
                      onPressed: () {
                        EkvipediaTopicViewedEvent(
                          topicTitle: topic.fields["name"] ?? "",
                        ).log();
                        AppNavigation.navigateTo(AppRoutes.ekvipediaTopics,
                            arguments: ScreenArguments(article: ArticleContent(article: topic, articleAssets: articleTopics.includes)));
                      });
                }).toList() ??
                [],
          )
        ],
      ),
    );
  }
}
