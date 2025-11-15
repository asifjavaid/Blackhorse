import 'dart:io';

import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Providers/WellnessWeekly/symptom_shifts_provider.dart';
import 'package:ekvi/Models/WellnessWeekly/symptom_shifts_model.dart';
import 'package:ekvi/Widgets/Buttons/underlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SymptomShifts extends StatefulWidget {
  const SymptomShifts({super.key});

  @override
  State<SymptomShifts> createState() => _SymptomShiftsState();
}

class _SymptomShiftsState extends State<SymptomShifts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SymptomShiftsProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Symptom shifts",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => HelperFunctions.openCustomBottomSheet(
                  context,
                  content: _buildSymptomShiftsInfo(),
                  height: Platform.isAndroid ? 350 : 430,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "${AppConstant.assetIcons}info.svg",
                    color: AppColors.actionColor600,
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 2.h),
          Consumer<SymptomShiftsProvider>(
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

              final symptomShifts = provider.symptomShifts;
              if (symptomShifts.isEmpty) {
                return _buildNoDataState(context);
              }

              return Column(
                children: [
                  Text(
                    "This week, your body responded beautifully to the care you gave it. Keep listening. It's always guiding you.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          height: 1.4,
                          color: AppColors.neutralColor600,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [AppThemes.shadowDown],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...symptomShifts.map((shift) => Column(
                              children: [
                                _buildProgressBar(
                                  context,
                                  shift: shift,
                                ),
                                if (shift != symptomShifts.last)
                                  SizedBox(height: 2.h),
                              ],
                            )),
                        SizedBox(height: 1.h),
                        const UnderlinedButton(text: "See more", onPressed: null),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "These shifts are compared to last week's average. Keep in mind that your symptoms may naturally shift with your cycle.",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          height: 1.4,
                          color: AppColors.neutralColor600,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context, {
    required SymptomShift shift,
  }) {
    final isPositive = shift.percentChange >= 0;
    final percentageText =
        isPositive ? "+${shift.percentChange}%" : "${shift.percentChange}%";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor400,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [AppThemes.shadowDown],
                  ),
                  child: SvgPicture.asset(
                    shift.iconPath,
                    width: 18,
                    height: 18,
                    color: AppColors.primaryColor600,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  shift.symptom.isNotEmpty
                      ? '${shift.symptom[0].toUpperCase()}${shift.symptom.substring(1)}'
                      : shift.symptom,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.neutralColor600,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Text(
              percentageText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: isPositive
                        ? AppColors.successColor500
                        : AppColors.errorColor400,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        CenterAnchoredProgressBar(
          value: shift.percentChange.abs() / 100,
          isPositive: isPositive,
        ),
      ],
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
            "Error loading symptom shifts",
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
      "Start tracking symptoms to see shifts.",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.blackColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildSymptomShiftsInfo() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("What am I comparing to?",
            textAlign: TextAlign.start,
            style: Theme.of(AppNavigation.currentContext!)
                .textTheme
                .headlineMedium!
                .copyWith(
                    color: AppColors.neutralColor600,
                    fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 24,
        ),
        RichText(
          text: TextSpan(
            style: Theme.of(AppNavigation.currentContext!).textTheme.bodySmall,
            children: [
              const TextSpan(
                text:
                    "We compare this week’s symptoms to your data from last week – not a fixed cycle – because many women with endo have irregular cycles or take hormones. This helps you see meaningful shifts as they happen.\n\n",
              ),
              const TextSpan(
                text:
                    "Most symptom-tracking apps compare your data to a “normal cycle”, but for many women with endometriosis, cycles are irregular or affected by treatment.\n\n",
              ),
              TextSpan(
                text: "Why we compare to last week\n",
                style: Theme.of(AppNavigation.currentContext!)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const TextSpan(
                text:
                    "That’s why Ekvi compares your symptoms to your previous week, helping you notice real changes in your body over time, no matter what your cycle looks like.\n\n",
              ),
              const TextSpan(
                text:
                    "This way, even small improvements can feel like progress and your hard weeks still get the compassion they deserve.\n\n",
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class CenterAnchoredProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color positiveColor;
  final Color negativeColor;
  final Color backgroundColor;
  final bool isPositive;

  const CenterAnchoredProgressBar({
    super.key,
    required this.value,
    required this.isPositive,
    this.positiveColor = AppColors.successColor500,
    this.negativeColor = AppColors.errorColor400,
    this.backgroundColor = AppColors.neutralColor200,
  });

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, 1.0);
    final barColor = isPositive ? positiveColor : negativeColor;

    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final centerPoint = width / 2;
          final barWidth = width * clampedValue / 2;

          return Stack(
            children: [
              // Progress bar
              Positioned(
                left: isPositive ? centerPoint : centerPoint - barWidth,
                top: 0,
                bottom: 0,
                width: barWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                left: centerPoint - 0.5,
                top: 0,
                bottom: 0,
                width: 1,
                child: Container(
                  color: backgroundColor.withOpacity(0.8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
