import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/DailyTracker/Headache/headache_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_grid_options.dart';
import 'package:ekvi/Widgets/CustomWidgets/custom_list_grid_options.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InsightsHeadacheTags extends StatelessWidget {
  const InsightsHeadacheTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheProvider>(builder: (context, provider, child) {
      // Check if user is subscribed
      final isSubscribed = UserManager().isPremium;

      return (provider.insightsHeadacheTagsData.isDataLoaded)
          ? Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                ListGridOptions(
                  title: "Your headaches felt like",
                  elevated: true,
                  options: isSubscribed
                      ? (provider.insightsHeadacheTagsData.graphData?.feltLike
                              ?.map((data) => OptionModel(
                                  text: data.tag ?? "Unknown",
                                  value: data.count))
                              .toList() ??
                          [])
                      : _getDummyFeltLikeData(),
                  width: 100.w,
                  height: 100.h,
                  margin: EdgeInsets.zero,
                  backgroundColor: AppColors.whiteColor,
                  callback: () {},
                  subCategoryOptions: [
                    GridOptions(
                      title: "Location",
                      elevated: false,
                      options: isSubscribed
                          ? (provider
                                  .insightsHeadacheTagsData.graphData?.location
                                  ?.map((data) => OptionModel(
                                      text: data.tag ?? "Unknown",
                                      value: data.count))
                                  .toList() ??
                              [])
                          : _getDummyLocationData(),
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Type",
                      elevated: false,
                      options: isSubscribed
                          ? (provider.insightsHeadacheTagsData.graphData?.type
                                  ?.map((data) => OptionModel(
                                      text: data.tag ?? "Unknown",
                                      value: data.count))
                                  .toList() ??
                              [])
                          : _getDummyTypeData(),
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                    GridOptions(
                      title: "Onset",
                      elevated: false,
                      options: isSubscribed
                          ? (provider.insightsHeadacheTagsData.graphData?.onset
                                  ?.map((data) => OptionModel(
                                      text: data.tag ?? "Unknown",
                                      value: data.count))
                                  .toList() ??
                              [])
                          : _getDummyOnsetData(),
                      width: 100.w,
                      height: 100.h,
                      backgroundColor: AppColors.whiteColor,
                      callback: () {},
                      padding: const EdgeInsets.only(top: 16),
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox.shrink();
    });
  }


  // Dummy data methods for non-subscribed users
  List<OptionModel> _getDummyFeltLikeData() {
    return [
      OptionModel(text: "Throbbing", value: 12),
      OptionModel(text: "Piercing", value: 7),
      OptionModel(text: "Sharp", value: 5),
      OptionModel(text: "Pounding", value: 2),
    ];
  }

  List<OptionModel> _getDummyLocationData() {
    return [
      OptionModel(text: "Forehead", value: 5),
      OptionModel(text: "Around the eyes", value: 2),
    ];
  }

  List<OptionModel> _getDummyTypeData() {
    return [
      OptionModel(text: "Migraine", value: 5),
      OptionModel(text: "Aura", value: 2),
    ];
  }

  List<OptionModel> _getDummyOnsetData() {
    return [
      OptionModel(text: "Gradual", value: 5),
      OptionModel(text: "Sudden", value: 2),
    ];
  }
}
