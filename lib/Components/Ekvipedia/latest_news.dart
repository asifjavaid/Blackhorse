import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestNews extends StatelessWidget {
  final EkvipediaContentEntries latestNews;
  const LatestNews({super.key, required this.latestNews});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<DashboardProvider>(context);

    return Column(
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
              Text("Latest news", style: textTheme.displaySmall),
              GestureDetector(
                onTap: () => provider.setBottomNavIndex(4),
                child: Text("all topics",
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
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "The latest articles added to Ekvipedia.",
            style: textTheme.bodySmall,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: latestNews.items?.length,
            itemBuilder: (context, index) {
              EntryItem? item = latestNews.items?[index];
              bool isPaid = item?.fields["accessType"] ?? false;
              bool isLocked = HelperFunctions.isArticleLocked(isPaid);
              return NewsCard(
                width: 200,
                height: 200,
                index: index,
                imagePath: EkvipediaContentEntries.getFaturedImageURL(item, latestNews.includes),
                date: HelperFunctions.formatDateTimetoMonthYear(item?.fields["date"]),
                readTime: item != null ? "${item.fields["readTime"]} minutes" : null,
                title: item?.fields["title"] ?? "",
                maxLines: 2,
                onPressed: () {
                  if (isLocked) {
                    PurchaseAccessedEvent(feature: "Ekvipedia", accessMethod: "Latest News").log();
                    AppNavigation.navigateTo(AppRoutes.subscribe);
                  } else {
                    AppNavigation.navigateTo(AppRoutes.ekvipediaArticle, arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: latestNews.includes)));
                  }
                },
                isPaid: isLocked,
              );
            },
          ),
        )
      ],
    );
  }
}
