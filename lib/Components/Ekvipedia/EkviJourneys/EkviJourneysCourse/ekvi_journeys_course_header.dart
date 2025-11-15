import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_course_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EkviJourneysCourseHeader extends StatelessWidget {
  final int? completionPct;

  const EkviJourneysCourseHeader({
    super.key,
    this.completionPct,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = context.watch<EkviJourneysCourseProvider>().imageUrl;
    final safeTop = MediaQuery.of(context).padding.top;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            top: (safeTop > 0) ? safeTop + 8 : 40,
            left: 16,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: AppNavigation.goBack,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.neutralColor50.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  '${AppConstant.assetIcons}backIcon.svg',
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryColor400,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                (completionPct ?? 0) == 0 ? "Not started" : "$completionPct%",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.neutralColor600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
