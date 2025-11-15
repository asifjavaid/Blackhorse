import 'dart:io';

import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Providers/WellnessWeekly/wins_of_the_week_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WinsOfTheWeek extends StatefulWidget {
  const WinsOfTheWeek({super.key});

  @override
  State<WinsOfTheWeek> createState() => _WinsOfTheWeekState();
}

class _WinsOfTheWeekState extends State<WinsOfTheWeek> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WinsOfTheWeekProvider>().initialize();
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
                "Wins of the week",
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
                  content: _buildWinsOfTheWeekInfo(),
                  height: Platform.isAndroid ? 300 : 330,
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
          Consumer<WinsOfTheWeekProvider>(
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

              final winsData = provider.winsData;
              if (winsData == null) {
                return _buildNoDataState(context);
              }

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildWinCard(
                    context,
                    mainText: winsData.lowestPainDay ?? "N/A",
                    subText: "Lowest pain day",
                  ),
                  _buildWinCard(
                    context,
                    mainText: "${winsData.lowPainDaysCount ?? 0}/7",
                    subText: "Low-pain days",
                  ),
                  _buildWinCard(
                    context,
                    mainText: winsData.highestMoodDay ?? "N/A",
                    subText: "Highest mood day",
                  ),
                  _buildWinCard(
                    context,
                    mainText: "${winsData.highMoodDaysCount ?? 0}/7",
                    subText: "High-mood days",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWinCard(
    BuildContext context, {
    required String mainText,
    required String subText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppThemes.shadowDown],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontFamily: "Zitter",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              subText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    height: 1.3,
                    color: AppColors.neutralColor600,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
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
            "Error loading wins data",
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
      "Track your mood and pain to start seeing your wins next week!",
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.blackColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildWinsOfTheWeekInfo() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("These are your bright spots",
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
            children: const [
              TextSpan(
                text:
                    "We highlight the day you had the lowest pain and the day you felt the most uplifted, based on your mood tracking.\n\n",
              ),
              TextSpan(
                text:
                    "You’ll also see how many days this week felt a little better in terms of pain or mood.\n\n",
              ),
              TextSpan(
                text:
                    "Even on tough weeks, small shifts matter. These wins can help you spot patterns, build self-trust, and feel encouraged to keep going.\n\n",
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
