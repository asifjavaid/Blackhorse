import 'dart:async';
import 'dart:io';

import 'package:ekvi/Utils/Constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../Providers/DailyTracker/daily_tracker_provider.dart';
import '../../../../Routes/app_navigation.dart';
import '../../../../Utils/constants/app_constant.dart';
import '../../../../Utils/helpers/helper_functions.dart';
import '../../../../Widgets/Gradient/gradient_background.dart';

class TrackingSettingsScreen extends StatefulWidget {
  const TrackingSettingsScreen({super.key});

  @override
  State<TrackingSettingsScreen> createState() => _TrackingSettingsScreenState();
}

class _TrackingSettingsScreenState extends State<TrackingSettingsScreen> {


  var provider = Provider.of<DailyTrackerProvider>(AppNavigation.currentContext!, listen: false);

  @override
  void initState() {
    super.initState();
    provider.fetchUserProfile(showLoader: true);
    //startTrackingPreferencesSync(context);
  }

  @override
  void dispose() {
    //stopTrackingPreferencesSync(); // 🔥 REQUIRED
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {

        return true; // allow back navigation
      },
      child: Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: AppColors.actionColor600, size: 16,),
                      onPressed: () {
                        Navigator.pop(context);
                        provider.patchSaveUserTrackingPreferences(context);
                      },
                    ),

                    Text("Customize tracking", textAlign: TextAlign.center, style: textTheme.displaySmall),

                    GestureDetector(
                      onTap: () => HelperFunctions.openCustomBottomSheet(context, content: _helpPanel(), height: 700),
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                          height: 16,
                          width: 16,
                          color: AppColors.actionColor600,
                          "${AppConstant.assetIcons}info.svg",
                          semanticsLabel: 'Tracker Settings Info',
                        ),
                      ),
                    ),

                  ],
                ),

                // 🔽 Page content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: provider.categories.map((category) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.title,
                                    style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.neutralColor600,
                                        fontSize: 16
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    margin: const EdgeInsets.only(bottom: 14, top: 10),
                                    color: Colors.white,
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
                                            style: textTheme.titleMedium!.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.neutralColor600,
                                                fontSize: 14
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
                                              // provider.patchSaveUserTrackingPreferences(context);
                                              /*_saveToggleState(
                                                category.title,
                                                item.title,
                                                newValue,
                                              );*/
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),/*
                          Consumer<DailyTrackerProvider>(
                            builder: (context, provider, child) {

                              return CustomButton(
                                title: "Save",

                                onPressed: () => provider.patchSaveUserTrackingPreferences(context)
                              );
                            },
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Timer? _trackingTimer;
  void startTrackingPreferencesSync(BuildContext context) {
    _trackingTimer?.cancel(); // prevent duplicates

    _trackingTimer = Timer.periodic(
      const Duration(seconds: 7),
          (timer) {
        provider.patchSaveUserTrackingPreferences(context);
      },
    );
  }

  void stopTrackingPreferencesSync() {
    _trackingTimer?.cancel();
    _trackingTimer = null;
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

class _TitleText extends TextSpan {
  _TitleText(String text, TextTheme textTheme)
      : super(
    text: text,
    style: textTheme.titleSmall?.copyWith(color: AppColors.neutralColor600, fontWeight: FontWeight.w700, height: 0),
  );
}

class _SubtitleText extends TextSpan {
  _SubtitleText(String text, TextTheme textTheme)
      : super(
    text: text,
    style: textTheme.bodySmall?.copyWith(
      color: AppColors.neutralColor600,
      height: 1.60,
    ),
  );
}


Widget _helpPanel() {
  TextTheme textTheme = Theme.of(AppNavigation.currentContext!).textTheme;
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customize your tracking',
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.neutralColor600,
          ),
        ),
        const SizedBox(height: 24),
        Text.rich(TextSpan(
          children: [
            _SubtitleText(
                'This is your space to decide what you want to track right now.\n\n'
                    'You don’t need to track everything. '
                    'Many women find it more helpful to focus on the symptoms, actions, and '
                    'life areas that feel most relevant in this phase of their life or cycle.\n\n',
                textTheme),
            _TitleText('How it works', textTheme),
          ],
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text.rich(
            TextSpan(
              children: [
                _SubtitleText('• Turn items on to include them in your Daily  Tracker\n', textTheme),
                _SubtitleText('• Turn items off to hide them from view\n', textTheme),
                _SubtitleText('• You can change this anytime if your needs  change\n', textTheme),
              ],
            ),
          ),
        ),
        Text.rich(TextSpan(children: [
          _SubtitleText(
              'Nothing you turn off is deleted. Your past data stays safe, and you can always add things back later.\n\n'
                  'Think of tracking as a conversation with your body. Start small, stay curious, and let this evolve with you.',
              textTheme),
        ])),
        const SizedBox(height: 32),
      ],
    ),
  );
}