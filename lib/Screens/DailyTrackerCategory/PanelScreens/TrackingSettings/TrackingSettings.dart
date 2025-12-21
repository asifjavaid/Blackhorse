import 'package:ekvi/Utils/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/DailyTracker/TrackingSettings/TrackingCategory.dart';
import '../../../../Models/DailyTracker/TrackingSettings/TrackingItem.dart';
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
              // 🔝 Custom AppBar inside gradient
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: AppColors.actionColor600),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Customize tracking',
                          style: textTheme.displaySmall,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: AppColors.actionColor600),
                      onPressed: () {},
                    ),
                  ],
                ),
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
                                    return SwitchListTile(
                                      title: Text(item.title),
                                      value: item.isEnabled,
                                      shape: const Border(), // 🔥 removes divider
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          item.isEnabled = newValue;
                                        });
                                        _saveToggleState(
                                          category.title,
                                          item.title,
                                          newValue,
                                        );
                                      },

                                      activeThumbColor: Colors.white,
                                      activeColor: AppColors.primaryColor600,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      dense: true,
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
