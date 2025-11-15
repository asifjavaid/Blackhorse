import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaArticle/widgets/thumbnail_widget.dart';
import 'package:ekvi/Screens/Ekvipedia/EkvipediaNewsEkvi/widgets/ekvipedia_news_ekvi_card.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkviNewsList extends StatefulWidget {
  const EkviNewsList({super.key});

  @override
  State<EkviNewsList> createState() => _EkviNewsListState();
}

class _EkviNewsListState extends State<EkviNewsList> {
  late EkvipediaProvider ekvipedia;

  @override
  void initState() {
    super.initState();
    ekvipedia = context.read<EkvipediaProvider>();
    ekvipedia.fetchNewsFromEkvi();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          top: false,
          child: Consumer<EkvipediaProvider>(builder: (co, provider, c) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ArticleThumbnail(imagePath: "${AppConstant.assetImages}ekvipedia_static_thumbnail.jpg"),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("News from Ekvi", style: textTheme.displaySmall),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.newsFromEkvi.items?.length ?? 0,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              EntryItem? item = provider.newsFromEkvi.items![index];
                              return EkvipediaNewsEkviCard(
                                imagePath: EkvipediaContentEntries.getFaturedImageURL(item, provider.newsFromEkvi.includes),
                                date: HelperFunctions.formatDateTime(item.fields["date"]),
                                title: item.fields["title"] ?? "",
                                readTime: "${item.fields["readTime"]} minutes",
                                onPressed: () => AppNavigation.navigateTo(AppRoutes.ekvipediaArticle,
                                    arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: provider.newsFromEkvi.includes))),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
