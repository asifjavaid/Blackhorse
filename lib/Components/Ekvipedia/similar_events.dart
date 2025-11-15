import 'package:ekvi/Components/Ekvipedia/news_card.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SimilarEvents extends StatelessWidget {
  final EkvipediaContentEntries similarEvents;
  const SimilarEvents({super.key, required this.similarEvents});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("You might also like", style: textTheme.displaySmall),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarEvents.items?.length,
            itemBuilder: (context, index) {
              EntryItem? item = similarEvents.items?[index];
              bool isPaid = item?.fields["accessType"] ?? false;
              bool isLocked = HelperFunctions.isArticleLocked(isPaid);
              return NewsCard(
                width: 200,
                height: 200,
                index: index,
                imagePath: EkvipediaContentEntries.getFaturedImageURL(item, similarEvents.includes),
                date: HelperFunctions.formatDateTimetoMonthYear(item?.fields["date"]),
                readTime: null,
                location: item != null ? "${item.fields["location"]}" : null,
                title: item?.fields["eventTitle"] ?? "",
                maxLines: 2,
                onPressed: isLocked
                    ? () => AppNavigation.navigateTo(AppRoutes.subscribe)
                    : () => AppNavigation.navigateTo(AppRoutes.ekvipediaEvents, arguments: ScreenArguments(article: ArticleContent(article: item, articleAssets: similarEvents.includes))),
                isPaid: isLocked,
              );
            },
          ),
        )
      ],
    );
  }
}
