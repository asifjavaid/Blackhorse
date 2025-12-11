import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journeys_course_host_details.dart';
import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysCourse/ekvi_journeys_course_metadata_content_renderer.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/assets.dart';

class EkviJourneysCourseMetadata extends StatefulWidget {
  const EkviJourneysCourseMetadata({super.key});

  @override
  State<EkviJourneysCourseMetadata> createState() =>
      _EkviJourneysCourseMetadataState();
}

class _EkviJourneysCourseMetadataState extends State<EkviJourneysCourseMetadata>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysCourseProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              '${AppConstant.assetIcons}moduleIcon.svg',
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                  AppColors.neutralColor500, BlendMode.srcIn),
            ),
            const SizedBox(width: 4),
            Text(
              "${provider.totalModules ?? 0} modules",
              style: textTheme.labelMedium
                  ?.copyWith(color: AppColors.neutralColor500),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              '${AppConstant.assetIcons}clock.svg',
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                  AppColors.neutralColor500, BlendMode.srcIn),
            ),
            const SizedBox(width: 4),
            Text(
              "${provider.totalDuration ?? 0} mins",
              style: textTheme.labelMedium
                  ?.copyWith(color: AppColors.neutralColor500),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: provider.tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: textTheme.labelSmall
                    ?.copyWith(color: AppColors.neutralColor600),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        Text(
          provider.title ?? '',
          style: textTheme.displayLarge,
        ),
        const SizedBox(height: 32),
        if (provider.description.isNotEmpty) ...[
          EkviJourneysCourseMetaDataContentRenderer(
            content: provider.description,
            isExpanded: _isExpanded,
          ),
        ],
        if (_isExpanded && provider.hostName != null) ...[
          Text('Meet the host',
              style: textTheme.displayLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 20)),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              EkviJourneysCourseHostDetails.show(
                context,
                name: provider.hostName,
                bio: provider.hostBio,
                description: provider.hostDescription,
                profilePicture: provider.hostProfilePicture,
                socials: provider.hostSocials,
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.network(
                    provider.hostProfilePicture ?? '',
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 85,
                      height: 85,
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
                      Text(provider.hostName ?? '',
                          style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Poppins')),
                      const SizedBox(height: 4),
                      Text(
                        provider.hostBio ?? '',
                        style: textTheme.bodySmall
                            ?.copyWith(color: AppColors.neutralColor600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                    Assets.customiconsArrowRight,
                    height: 16,
                    width: 16,
                    color: AppColors.actionColor600
                ),
              ],
            ),
          ),
        ],
        if (provider.description.isNotEmpty) ...[
          const SizedBox(height: 24),
          Center(
            child: InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _isExpanded ? 'Read less' : 'Read more',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.actionColor600,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.actionColor600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
