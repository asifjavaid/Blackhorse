import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LatestEvents extends StatelessWidget {
  final EkvipediaContentEntries latestEvents;
  const LatestEvents({super.key, required this.latestEvents});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return latestEvents.items?.isNotEmpty ?? false
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
                    Text("Latest happenings", style: textTheme.displaySmall),
                    GestureDetector(
                      onTap: () => AppNavigation.navigateTo(AppRoutes.ekvipediaAllEvents),
                      child: Text("all events",
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
                  "The latest events in the Ekvi tribe.",
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
                  itemCount: latestEvents.items?.length,
                  itemBuilder: (context, index) {
                    EntryItem? item = latestEvents.items?[index];
                    bool isPaid = item?.fields["accessType"] ?? false;
                    bool isLocked = HelperFunctions.isArticleLocked(isPaid);
                    return NewsCard(
                      width: 200,
                      height: 200,
                      index: index,
                      imagePath: EkvipediaContentEntries.getFaturedImageURL(item, latestEvents.includes),
                      date: HelperFunctions.formatDateTimetoMonthYear(item?.fields["date"]),
                      readTime: null,
                      location: item != null ? "${item.fields["location"]}" : null,
                      title: item?.fields["eventTitle"] ?? "",
                      maxLines: 2,
                      onPressed: isLocked
                          ? () {
                              PurchaseAccessedEvent(feature: "Ekvipedia", accessMethod: "Latest Events").log();
                              AppNavigation.navigateTo(AppRoutes.subscribe);
                            }
                          : () => AppNavigation.navigateTo(AppRoutes.ekvipediaEvents, arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: latestEvents.includes))),
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
