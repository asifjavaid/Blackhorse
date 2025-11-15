import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/thumbnail_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaTopic/widgets/share_your_journey.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaTopic/widgets/topic_title_and_description.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkvipediaTopic extends StatefulWidget {
  final ScreenArguments? arguments;
  const EkvipediaTopic({super.key, this.arguments});

  @override
  State<EkvipediaTopic> createState() => _EkvipediaTopicState();
}

class _EkvipediaTopicState extends State<EkvipediaTopic> {
  @override
  void initState() {
    context.read<EkvipediaProvider>().fetchArticleSubTopics(
        widget.arguments?.article?.article?.sys.properties["id"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EntryItem? item = widget.arguments?.article?.article;
    Includes? assets = widget.arguments?.article?.articleAssets;
    String? title = widget.arguments?.article?.article?.fields["name"];
    String? description =
        widget.arguments?.article?.article?.fields["description"];
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: GradientBackground(
      child: Consumer<EkvipediaProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ArticleThumbnail(
                imageURL: EkvipediaContentEntries.getFaturedImageURL(
                    item, assets,
                    isTopic: true),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopicTitleAndDescription(
                      title: title,
                      preview: description,
                    )
                  ],
                ),
              ),
              Column(
                children: provider.articleSubtopics.entries.map((entry) {
                  final subtopicName = entry.key;
                  final SubtopicGroup subtopicGroup = entry.value;
                  final articles = subtopicGroup.articles;
                  final includes = subtopicGroup.includes;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 16, left: 16, right: 16),
                        child: Text(
                          subtopicName,
                          style: textTheme.displaySmall,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            bool isPaid = article.fields["accessType"] ?? false;
                            bool isLocked =
                                HelperFunctions.isArticleLocked(isPaid);

                            return NewsCard(
                              index: index,
                              width: 200,
                              height: 200,
                              imagePath:
                                  EkvipediaContentEntries.getFaturedImageURL(
                                      article, includes),
                              date: HelperFunctions.formatDateTimetoMonthYear(
                                  article.fields["date"]),
                              readTime: article.fields["readTime"] != null
                                  ? "${article.fields["readTime"]} minutes"
                                  : null,
                              title: article.fields["title"] as String? ?? "",
                              maxLines: 2,
                              onPressed: () {
                                if (isLocked) {
                                  PurchaseAccessedEvent(
                                          feature: "Ekvipedia",
                                          accessMethod: "Track, Learn, Thrive")
                                      .log();

                                  AppNavigation.navigateTo(AppRoutes.subscribe);
                                } else {
                                  AppNavigation.navigateTo(
                                    AppRoutes.ekvipediaArticle,
                                    arguments: ScreenArguments(
                                      article: ArticleContent(
                                        article: article,
                                        articleAssets: includes,
                                      ),
                                    ),
                                  );
                                }
                              },
                              isPaid: isLocked,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 64,
              ),
              const ShareYourJourney()
            ],
          ),
        ),
      ),
    ));
  }
}
