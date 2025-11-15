import 'package:ekvi/Components/Ekvipedia/article_topics.dart';
import 'package:ekvi/Components/Ekvipedia/ekvi_stories.dart';
import 'package:ekvi/Components/Ekvipedia/top_picks_for_you.dart';
import 'package:ekvi/Components/Insights/example_data_banner.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkvipediaArticlesTab extends StatefulWidget {
  const EkvipediaArticlesTab({super.key});

  @override
  State<EkvipediaArticlesTab> createState() => _EkvipediaArticlesTabState();
}

class _EkvipediaArticlesTabState extends State<EkvipediaArticlesTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<EkvipediaProvider>();
      provider.fetchTopSymptomsFromServer();
      provider.fetchArticleTopics();
      provider.fetchAuthorStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EkvipediaProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              if (!UserManager().isPremium)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ExampleDataBanner(
                    title: "Example Stories",
                    description: "Some of the stories below are locked because you’re on the free plan. Upgrade to Ekvi Empower to get access to all articles and stories.",
                  ),
                ),
              const TopPicksForYou(),
              ArticleTopics(articleTopics: provider.articleTopics),
              const SizedBox(height: 64),
              EkviStories(ekviStories: provider.ekviStories),
              const SizedBox(height: 64),
            ],
          ),
        );
      },
    );
  }
}
