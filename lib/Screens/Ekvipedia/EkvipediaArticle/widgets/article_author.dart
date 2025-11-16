import 'package:ekvi/Models/Ekvipedia/ekvi_events_author_model.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/assets.dart';

class ArticleAuthor extends StatelessWidget {
  final EntryItem? item;
  final Includes? assets;
  final Function() onTap;

  const ArticleAuthor({super.key, required this.item, required this.assets, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    String? name = item?.fields["authorName"];
    String? bio = item?.fields["authorBio"];
    String? profilePicture = EkvipediaContentEntries.getAssetById(
      item?.fields["profilePicture"]?["sys"]?["id"] ?? '',
      assets,
    )?.fields["file"]?["url"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: AppColors.primaryColor500,
          thickness: 1,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          "Meet the author",
          style: textTheme.displayMedium,
        ),
        const SizedBox(
          height: 32,
        ),
        AuthorItems(
          name: name,
          bio: bio,
          profilePicture: profilePicture,
          onTap: onTap,
          textTheme: textTheme,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class AuthorItems extends StatelessWidget {
  final String? name;
  final String? bio;
  final String? profilePicture;
  final Function() onTap;
  final TextTheme textTheme;

  const AuthorItems({
    super.key,
    this.name,
    this.bio,
    this.profilePicture,
    required this.onTap,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: profilePicture != null ? NetworkImage("https:$profilePicture") : null,
              radius: 50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "Unknown Author",
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    bio ?? "",
                    style: textTheme.bodySmall,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(
              Assets.customiconsArrowRight,
              color: AppColors.actionColor600,
              height: 16,
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class AuthorHelperSheet extends StatelessWidget {
  final TextTheme textTheme;
  final Map<String, dynamic>? fields;
  final Includes? assets;

  const AuthorHelperSheet({
    super.key,
    required this.textTheme,
    required this.fields,
    this.assets,
  });

  @override
  Widget build(BuildContext context) {
    final model = fields != null ? AuthorModel.fromJson(fields!, assets) : AuthorModel();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: model.profilePicture != null ? NetworkImage("https:${model.profilePicture}") : null,
                radius: 40,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name ?? "Unknown author",
                      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      model.bio ?? "",
                      style: textTheme.bodySmall,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Description(
            description: model.description ?? "",
            bodySmall: textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          SocialMediaLinks(model: model),
        ],
      ),
    );
  }
}

class SocialMediaLinks extends StatelessWidget {
  final AuthorModel model;

  const SocialMediaLinks({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final icons = [
      if (model.facebook != null)
        IconButton(
          onPressed: () => visitLink(model.facebook!),
          icon: SvgPicture.asset("${AppConstant.assetIcons}facebook.svg"),
        ),
      if (model.instagram != null)
        IconButton(
          onPressed: () => visitLink(model.instagram!),
          icon: SvgPicture.asset("${AppConstant.assetIcons}instagram.svg"),
        ),
      if (model.website != null)
        IconButton(
          onPressed: () => visitLink(model.website!),
          icon: SvgPicture.asset("${AppConstant.assetIcons}website.svg"),
        ),
      if (model.tiktok != null)
        IconButton(
          onPressed: () => visitLink(model.tiktok!),
          icon: SvgPicture.asset("${AppConstant.assetIcons}tiktok.svg"),
        ),
      if (model.youtube != null)
        IconButton(
          onPressed: () => visitLink(model.youtube!),
          icon: SvgPicture.asset("${AppConstant.assetIcons}youtube.svg"),
        ),
    ];

    return Row(
      children: icons,
    );
  }
}

Future<void> visitLink(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    HelperFunctions.showNotification(
      AppNavigation.currentContext!,
      'Could not launch $url',
    );
  }
}

class Description extends StatelessWidget {
  final String? description;
  final TextStyle? bodySmall;

  const Description({super.key, required this.description, this.bodySmall});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Text(
          description ?? "",
          style: bodySmall,
          softWrap: true,
        ),
      ),
    );
  }
}
