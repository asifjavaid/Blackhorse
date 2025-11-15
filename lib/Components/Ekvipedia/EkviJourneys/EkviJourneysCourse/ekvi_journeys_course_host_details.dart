import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/url_launcher_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EkviJourneysCourseHostDetails extends StatelessWidget {
  final String? name;
  final String? bio;
  final String? description;
  final String? profilePicture;
  final Map<String, String> socials;

  const EkviJourneysCourseHostDetails({
    super.key,
    required this.name,
    required this.bio,
    required this.description,
    required this.profilePicture,
    required this.socials,
  });

  static void show(
    BuildContext context, {
    required String? name,
    required String? bio,
    required String? description,
    required String? profilePicture,
    required Map<String, String> socials,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [AppThemes.shadowUp],
          ),
          child: EkviJourneysCourseHostDetails(
            name: name,
            bio: bio,
            description: description,
            profilePicture: profilePicture,
            socials: socials,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  profilePicture ?? '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.neutralColor200,
                    child: const Icon(Icons.person,
                        size: 40, color: AppColors.neutralColor500),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? 'Unknown',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bio ?? '',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description ?? '',
              style: textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: socials.entries.map((entry) {
              final iconPath =
                  "${AppConstant.assetIcons}${entry.key.toLowerCase()}.svg";
              return IconButton(
                onPressed: () => UrlLauncherService.openUrl(entry.value),
                icon: SvgPicture.asset(iconPath),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
