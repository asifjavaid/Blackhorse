import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPicksForYou extends StatelessWidget {
  const TopPicksForYou({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var dashboardProvider = Provider.of<DashboardProvider>(context, listen: true);

    return Consumer<EkvipediaProvider>(
        builder: (context, value, child) => value.isTopSymptomsLoading
            ? const SizedBox.shrink()
            : value.topSymptomTags.keys.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Your Top Symptoms, Explained",
                          style: textTheme.displaySmall,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "You’ve been tracking. We’ve been listening. Here’s what your body might be telling you and ways to take charge of your journey.",
                          style: textTheme.bodySmall,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 24, left: 16, right: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            direction: Axis.horizontal,
                            children: value.topSymptomTags.keys
                                .map((option) => TagWidget(
                                      option: option,
                                      callback: () {},
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 278,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.topPicksForYou.items?.length,
                          itemBuilder: (context, index) {
                            EntryItem? item = value.topPicksForYou.items?[index];
                            int itemCount = value.topPicksForYou.items?.length ?? 0;
                            double cardWidth = itemCount == 1 ? MediaQuery.of(context).size.width - 32 : 300;
                            bool isPaid = item?.fields["accessType"] ?? false;
                            bool isLocked = HelperFunctions.isArticleLocked(isPaid);
                            return NewsCard(
                              index: index,
                              width: cardWidth,
                              height: 278,
                              thumbnailFlex: 72,
                              textFlex: 30,
                              imagePath: EkvipediaContentEntries.getFaturedImageURL(item, value.topPicksForYou.includes),
                              date: HelperFunctions.formatDateTimetoMonthYear(item?.fields["date"]),
                              readTime: item != null ? "${item.fields["readTime"]} minutes" : null,
                              title: item?.fields["title"] ?? "",
                              onPressed: () {
                                if (isLocked) {
                                  PurchaseAccessedEvent(feature: "Ekvipedia", accessMethod: "Your Top Symptoms, Explained").log();
                                  AppNavigation.navigateTo(AppRoutes.subscribe);
                                } else {
                                  AppNavigation.navigateTo(AppRoutes.ekvipediaArticle,
                                      arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: value.topPicksForYou.includes)));
                                }
                              },
                              isPaid: isLocked,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Top Symptoms, Explained",
                          style: textTheme.displaySmall,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "We noticed you haven’t tracked any symptoms recently. By logging how you’re feeling, we can provide you with personalized articles to support your health journey.\n\nRemember, your body’s story is important – and we’re here to help you understand it.",
                          style: textTheme.bodySmall,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButton(
                            title: "Start Tracking",
                            onPressed: () {
                              dashboardProvider.setBottomNavIndex(2);
                            }),
                        const SizedBox(
                          height: 64,
                        ),
                      ],
                    ),
                  ));
  }
}

class TagWidget extends StatelessWidget {
  final String option;
  final VoidCallback callback;

  const TagWidget({super.key, required this.option, required this.callback});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 5),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColors.whiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  option,
                  style: textTheme.titleSmall!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
