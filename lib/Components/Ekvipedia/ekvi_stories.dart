import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvipedia_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/CustomWidgets/premium_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';

class EkviStories extends StatelessWidget {
  final EkvipediaContentEntries ekviStories;
  const EkviStories({super.key, required this.ekviStories});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<EkvipediaProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Ekvi Stories", style: textTheme.displaySmall),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Hear from women who’ve walked in your shoes. Their stories of resilience, healing, and hope are here to remind you that this journey doesn’t have to be lonely.",
              style: textTheme.bodySmall,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(right: 16),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: (ekviStories.items?.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final story = entry.value;

                    final String? entryId = story.fields["author"]?["sys"]?["id"];
                    if (entryId == null) {
                      return const SizedBox.shrink();
                    }
                    String readTime = "${story.fields["readTime"] ?? 'Unknown'} minutes";
                    final EntryItem? author = EkvipediaContentEntries.getIncludesEntryById(entryId, ekviStories.includes);
                    final String? profilePictureId = author?.fields["profilePicture"]?["sys"]?["id"];
                    final Asset? asset = profilePictureId != null ? EkvipediaContentEntries.getAssetById(profilePictureId, ekviStories.includes) : null;
                    final String? url = asset?.fields["file"]?["url"];
                    bool isPaid = story.fields["accessType"] ?? false;
                    bool isLocked = HelperFunctions.isArticleLocked(isPaid);

                    final EdgeInsets padding = index == 0
                        ? const EdgeInsets.only(left: 16, right: 16)
                        : (index == ekviStories.items!.length - 1 ? const EdgeInsets.only(right: 16, left: 16) : const EdgeInsets.only(right: 16));

                    return GestureDetector(
                      onTap: () {
                        if (isLocked) {
                          AppNavigation.navigateTo(AppRoutes.subscribe);
                        } else {
                          AppNavigation.navigateTo(
                            AppRoutes.ekvipediaArticle,
                            arguments: ScreenArguments(
                              article: ArticleContent(article: story, articleAssets: ekviStories.includes),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: padding,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 68,
                                  backgroundImage: url != null ? NetworkImage("https:$url") : null,
                                  backgroundColor: AppColors.primaryColor600,
                                ),
                                if (isLocked)
                                  const Positioned(
                                    top: 0,
                                    right: 0,
                                    child: PremiumIconWidget(),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(author?.fields["authorName"] ?? ""),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.customiconsTime,
                                  height: 16.0,
                                  width: 16.0,
                                  color: AppColors.neutralColor500,
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  readTime,
                                  style: textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.neutralColor500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList() ??
                  []),
            ),
          )
        ],
      ),
    );
  }
}
