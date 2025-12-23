import 'dart:io';

import 'package:ekvi/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/DailyTracker/TrackingSettings/TrackingCategory.dart';
import '../../../../Models/DailyTracker/TrackingSettings/TrackingItem.dart';
import '../../../../Routes/app_navigation.dart';
import '../../../../Utils/constants/app_constant.dart';
import '../../../../Utils/helpers/helper_functions.dart';
import '../../../../Widgets/Gradient/gradient_background.dart'; // Import the package

class TrackingSettingsScreen extends StatefulWidget {
  const TrackingSettingsScreen({super.key});

  @override
  State<TrackingSettingsScreen> createState() => _TrackingSettingsScreenState();
}

class _TrackingSettingsScreenState extends State<TrackingSettingsScreen> {
  final List<TrackingCategory> categories = [
    TrackingCategory(
      title: 'Things I experience',
      items: [
        TrackingItem(title: 'Pain'),
        TrackingItem(title: 'Bleeding'),
        TrackingItem(title: 'Headache'),
        TrackingItem(title: 'Mood'),
        TrackingItem(title: 'Stress'),
        TrackingItem(title: 'Energy'),
      ],
    ),
    // ... all other categories remain the same as in the previous response
    TrackingCategory(
      title: 'Symptoms',
      items: [
        TrackingItem(title: 'Nausea'),
        TrackingItem(title: 'Fatigue'),
        TrackingItem(title: 'Bloating'),
        TrackingItem(title: 'Brain fog'),
      ],
    ),
    TrackingCategory(
      title: 'Things I put in my body',
      items: [
        TrackingItem(title: 'Painkillers'),
        TrackingItem(title: 'Hormones'),
        TrackingItem(title: 'Alcohol'),
      ],
    ),
    TrackingCategory(
      title: 'Bathroom habits',
      items: [
        TrackingItem(title: 'Bowel movement'),
        TrackingItem(title: 'Urination'),
      ],
    ),
    TrackingCategory(
      title: 'Wellbeing',
      items: [
        TrackingItem(title: 'Movement'),
        TrackingItem(title: 'Self-care'),
        TrackingItem(title: 'Pain relief'),
      ],
    ),
    TrackingCategory(
      title: 'Intimacy & Fertility',
      items: [
        TrackingItem(title: 'Intimacy'),
        TrackingItem(title: 'Ovulation test'),
        TrackingItem(title: 'Pregnancy test'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadToggleStates();
  }

  // Load the saved states from SharedPreferences
  Future<void> _loadToggleStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var category in categories) {
        for (var item in category.items) {
          // Use a unique key for each item, defaulting to true if not found
          final key = _generateKey(category.title, item.title);
          item.isEnabled = prefs.getBool(key) ?? true;
        }
      }
    });
  }

  // Save the state of a single toggle button
  Future<void> _saveToggleState(String categoryTitle, String itemTitle, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _generateKey(categoryTitle, itemTitle);
    await prefs.setBool(key, value);
  }

  // Helper function to create unique keys (e.g., "Things I experience_Pain")
  String _generateKey(String categoryTitle, String itemTitle) {
    return '${categoryTitle}_$itemTitle'.replaceAll(' ', '_').toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppColors.actionColor600, size: 16,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text("Customize tracking", textAlign: TextAlign.center, style: textTheme.displaySmall),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => HelperFunctions.openCustomBottomSheet(context, content: _helpPanel(), height: Platform.isAndroid ? 300 : 330),
                    child: SvgPicture.asset(
                      height: 16,
                      width: 16,
                      color: AppColors.actionColor600,
                      "${AppConstant.assetIcons}info.svg",
                      semanticsLabel: 'Tracker Settings Info',
                    ),
                  )
                ],
              ),

              // 🔽 Page content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: categories.map((category) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.title,
                              style: textTheme.titleMedium,
                            ),
                            Card(
                              margin: const EdgeInsets.only(bottom: 10, top: 10),
                              color: Colors.white,
                              elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: category.items.length,
                                  itemBuilder: (context, index) {
                                    final item = category.items[index];
                                    return ListTile(
                                      shape: const Border(),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      dense: true,
                                      title: Text(
                                        item.title,
                                        style: textTheme.titleMedium?.copyWith(
                                          color: AppColors.neutralColor600,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: CustomSwitch(
                                        value: item.isEnabled,
                                        width: 45,
                                        height: 25,
                                        activeColor: AppColors.actionColor600,
                                        inactiveColor: AppColors.neutralColor300,
                                        thumbColor: AppColors.neutralColor50,
                                        onChanged: (newValue) {
                                          setState(() {
                                            item.isEnabled = newValue;
                                          });
                                          _saveToggleState(
                                            category.title,
                                            item.title,
                                            newValue,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Duration duration;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.width = 44,
    this.height = 24,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.white,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double thumbSize = height - 6;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: duration,
        width: width,
        height: height,
        padding: const EdgeInsets.only(top: 2,bottom: 2, left: 4, right: 4),
        decoration: BoxDecoration(
          color: value ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: AnimatedAlign(
          duration: duration,
          alignment:
          value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              color: thumbColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}


Widget _helpPanel() {
  TextTheme textTheme = Theme.of(AppNavigation.currentContext!).textTheme;
  return SingleChildScrollView(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("What does it mean?", textAlign: TextAlign.start, style: textTheme.headlineSmall!.copyWith(color: AppColors.neutralColor600)),
      const SizedBox(
        height: 24,
      ),
      Row(
        children: [
          Text(
            "1-10",
            style: textTheme.bodySmall,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Intensity of the tracked symptom",
            style: textTheme.bodySmall,
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          SvgPicture.asset("${AppConstant.assetIcons}dt_help_1.svg"),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Tracked intensity",
            style: textTheme.bodySmall,
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          SvgPicture.asset("${AppConstant.assetIcons}dt_help_2.svg"),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Tracked symptom, without intensity",
            style: textTheme.bodySmall,
          )
        ],
      ),
      const SizedBox(
        height: 12,
      ),
      Row(
        children: [
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: AppColors.primaryColor500),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            width: 32,
            height: 32,
            child: Center(
              child: Text(
                '1',
                style: textTheme.bodyLarge!.copyWith(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "Units tracked",
            style: textTheme.bodySmall,
          )
        ],
      ),
    ]),
  );
}