import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Providers/WellnessWeekly/wellbeing_practices_provider.dart';
import 'package:ekvi/Models/WellnessWeekly/wellbeing_practices_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class YourWellbeing extends StatefulWidget {
  const YourWellbeing({super.key});

  @override
  State<YourWellbeing> createState() => _YourWellbeingState();
}

class _YourWellbeingState extends State<YourWellbeing> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WellbeingPracticesProvider>().initialize();
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
            "Your wellbeing",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 1.h),
          Consumer<WellbeingPracticesProvider>(
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

              final practices = provider.practices;
              if (practices.isEmpty) {
                return _buildNoDataState(context);
              }

              return Column(
                children: [
                  Text(
                    "You did all of these practices to take care of your body and soul this week.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          height: 1.4,
                          color: AppColors.neutralColor600,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(height: 3.h),
                  Wrap(
                    spacing: 12,
                    runSpacing: 16,
                    children: practices
                        .map((practice) => _buildWellnessChip(
                              context,
                              practice: practice,
                            ))
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWellnessChip(
    BuildContext context, {
    required WellbeingPractice practice,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor400,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [AppThemes.shadowDown],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              practice.emoji,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                  ),
            ),
            SizedBox(width: 1.w),
            Text(
              practice.practiceName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.neutralColor600,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(width: 2.w),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  practice.count.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.neutralColor600,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
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
            "Error loading wellbeing practices",
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
      "Track your wellbeing practices to start seeing your data next week!",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.blackColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
      textAlign: TextAlign.start,
    );
  }
}
