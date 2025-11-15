import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/WellnessWeekly/affirmations_provider.dart';
import 'package:ekvi/Models/WellnessWeekly/affirmations_model.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Affirmations extends StatefulWidget {
  const Affirmations({super.key});

  @override
  State<Affirmations> createState() => _AffirmationsState();
}

class _AffirmationsState extends State<Affirmations> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AffirmationsProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Affirmations",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 2.h),
          Consumer<AffirmationsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.error != null) {
                return _buildErrorState(context, provider.error!);
              }

              if (provider.hasNoData) {
                return _buildNoDataState(context);
              }

              final affirmations = provider.affirmations;
              if (affirmations.isEmpty) {
                return _buildNoDataState(context);
              }

              return SizedBox(
                height: 26.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: affirmations.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: 3.w), // Controlled spacing between cards
                  itemBuilder: (context, index) {
                    return _buildAffirmationCard(context, affirmations[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAffirmationCard(BuildContext context, Affirmation affirmation) {
    final affirmationText = affirmation.text;

    return Container(
      width: 37.w,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppThemes.shadowDown],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              '${AppConstant.assetIcons}three_sparkle.svg',
              width: 32,
              height: 32,
            ),
            Text(
              affirmationText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    height: 1.2,
                    color: AppColors.neutralColor600,
                    fontFamily: 'Zitter',
                    fontWeight: FontWeight.w300,
                  ),
            ),
            SvgPicture.asset(
              '${AppConstant.assetIcons}two_sparkle.svg',
              width: 32,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.errorColor400,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.errorColor500,
            size: 24,
          ),
          SizedBox(height: 1.h),
          Text(
            "Error loading affirmations",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.errorColor500,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.errorColor500,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataState(BuildContext context) {
    return Text(
      "Track your symptoms to start seeing your affirmations next week!",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.blackColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
      textAlign: TextAlign.start,
    );
  }
}
