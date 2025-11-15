import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/article_content_manager.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';

class ArticleReferencesPreview extends StatelessWidget {
  final List<Map<String, dynamic>> articleReferences;
  final Includes? assets;

  const ArticleReferencesPreview(
      {super.key, required this.articleReferences, required this.assets});

  @override
  Widget build(BuildContext context) {
    List<String> references = extractFirstTwoBulletPoints(articleReferences);
    int total = countTotalBulletPoints(articleReferences);
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
              BulletPointList(
                references: references,
              ),
              total > 2
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () => AppNavigation.navigateTo(
                              AppRoutes.ekvipediaArticleReferences,
                              arguments: ScreenArguments(
                                  article: ArticleContent(
                                      articleReferences: articleReferences,
                                      articleAssets: assets))),
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
}

class ArticleReferencesScreen extends StatelessWidget {
  final ScreenArguments arguments;

  const ArticleReferencesScreen({
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
                    child: ArticleContentManager(
                        content: arguments.article?.articleReferences ?? [],
                        assets: arguments.article?.articleAssets)),
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

  const BulletPointList({super.key, required this.references});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        children: _buildOrderedList(references, context),
        style: textTheme.bodyMedium,
      ),
    );
  }

  List<TextSpan> _buildOrderedList(
      List<String> references, BuildContext context) {
    List<TextSpan> spans = [];
    TextTheme textTheme = Theme.of(context).textTheme;

    for (int i = 0; i < references.length; i++) {
      spans.add(
        TextSpan(
          text: '${i + 1}. ',
          style: textTheme.bodyMedium,
        ),
      );
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

List<String> extractFirstTwoBulletPoints(List<dynamic> articleReferences) {
  List<String> bulletPoints = [];

  var orderedList = articleReferences.firstWhere(
    (item) => item['nodeType'] == 'ordered-list',
    orElse: () => <String, dynamic>{'content': []},
  );

  if (orderedList['content'] is List) {
    (orderedList['content'] as List<dynamic>).take(2).forEach((listItem) {
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

int countTotalBulletPoints(List<Map<String, dynamic>> articleReferences) {
  var orderedList = articleReferences.firstWhere(
    (item) => item['nodeType'] == 'ordered-list',
    orElse: () => <String, dynamic>{'content': []},
  );

  if (orderedList['content'] is List) {
    return (orderedList['content'] as List).length;
  }

  return 0;
}
