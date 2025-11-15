import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Providers/Dashboard/dashboard_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeelToday extends StatelessWidget {
  const FeelToday({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<DashboardProvider>(context);
    List<OptionModel> options =
        provider.moodData.moodOptions.where((mood) => mood.isSelected).toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 64,
          ),
          Text(
            "How are you feeling?",
            style: textTheme.displaySmall,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 16,
          ),
          options.isNotEmpty
              ? Column(
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: options
                              .map((option) => TagWidget(
                                    option: option,
                                  ))
                              .toList(),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          options.isEmpty
              ? CustomButton(
                  title: "Track Your Mood",
                  onPressed: () => provider.handleFeelToday(context))
              : CustomButton(
                  title: "Track More Symptoms",
                  onPressed: () {
                    provider.setBottomNavIndex(2);
                  })
        ],
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final OptionModel option;

  const TagWidget({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                option.text,
                style: textTheme.titleSmall!.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
