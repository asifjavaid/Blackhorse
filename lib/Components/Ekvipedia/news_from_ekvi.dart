import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class NewsFromEkvi extends StatefulWidget {
  final EkvipediaContentEntries newsFromEkvi;

  const NewsFromEkvi({super.key, required this.newsFromEkvi});

  @override
  State<NewsFromEkvi> createState() => _NewsFromEkviState();
}

class _NewsFromEkviState extends State<NewsFromEkvi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return widget.newsFromEkvi.items != null && widget.newsFromEkvi.items!.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("News from the Ekvi Team", style: textTheme.displaySmall),
                    GestureDetector(
                      onTap: () => AppNavigation.navigateTo(AppRoutes.newsFromEkvi),
                      child: Text("all news",
                          style: textTheme.headlineSmall!.copyWith(
                            color: AppColors.actionColor600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.actionColor600,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.newsFromEkvi.items?.length,
                  itemBuilder: (context, index) {
                    EntryItem? item = widget.newsFromEkvi.items?[index];
                    bool isPaid = item?.fields["accessType"] ?? false;
                    bool isLocked = HelperFunctions.isArticleLocked(isPaid);
                    return NewsCard(
                      width: 200,
                      height: 200,
                      index: index,
                      imagePath: EkvipediaContentEntries.getFaturedImageURL(item, widget.newsFromEkvi.includes),
                      date: HelperFunctions.formatDateTimetoMonthYear(item?.fields["date"]),
                      readTime: item?.fields["readTime"] != null ? "${item?.fields["readTime"]} minutes" : "",
                      title: item?.fields["title"] ?? "",
                      maxLines: 2,
                      onPressed: () {
                        if (isLocked) {
                          PurchaseAccessedEvent(feature: "Ekvipedia", accessMethod: "News from the Ekvi Team").log();
                          AppNavigation.navigateTo(AppRoutes.subscribe);
                        } else {
                          AppNavigation.navigateTo(AppRoutes.ekvipediaArticle, arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: widget.newsFromEkvi.includes)));
                        }
                      },
                      isPaid: isLocked,
                    );
                  },
                ),
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
