import 'package:ekvi/Providers/Notifications/notifications_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/static_constants.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../generated/assets.dart';

class NotificationsPreferencesScreen extends StatefulWidget {
  const NotificationsPreferencesScreen({super.key});

  @override
  State<NotificationsPreferencesScreen> createState() => _NotificationsPreferencesScreenState();
}

class _NotificationsPreferencesScreenState extends State<NotificationsPreferencesScreen> {
  late NotificationsProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<NotificationsProvider>(context, listen: false);
    provider.getNotificationPreferences();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var localizations = AppLocalizations.of(context)!;
    var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);
    return Scaffold(
      body: GradientBackground(
        child: Consumer<NotificationsProvider>(builder: (c, value, x) {
          return SafeArea(
            child: SlidingUpPanel(
              controller: value.panelController,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              backdropEnabled: false,
              isDraggable: true,
              renderPanelSheet: true,
              minHeight: 0,
              maxHeight: 690,
              panel: _NotificationHelpText(
                textTheme: textTheme,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BackNavigation(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      title: localizations.notifications,
                      endIcon: InkWell(
                        onTap: () => value.toggleBottomSheet(),
                        child: SvgPicture.asset(
                          Assets.customiconsQuestion,
                          height: 16,
                          width: 16,
                          color: AppColors.actionColor600,
                        ),
                      ),
                      callback: () => sideNavManagerProvider.onSelected(MenuItems(AppNavigation.currentContext!).bottomNavManager),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: ShapeDecoration(
                              color: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              shadows: const [AppThemes.shadowDown],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Manage notifications',
                                  style: textTheme.titleMedium?.copyWith(
                                    color: AppColors.neutralColor600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                ...List.generate(
                                  value.notificationCategories.length,
                                  (index) {
                                    return _CommonNotificationToggle(
                                      textTheme: textTheme,
                                      title: value.notificationCategories[index],
                                      titleValue: value.notificationCategoriesEnabled[index],
                                      index: index,
                                      callBack: (values) {
                                        value.updateValue(index, values);
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Material(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: AppColors.accentColorOne400,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.iconsClock16,
                                                height: 16,
                                                width: 16,
                                                color: AppColors.actionColor600,
                                              ),
                                              const SizedBox(width: 10),
                                              Text("10:00AM", style: textTheme.titleSmall!.copyWith(fontSize: 12)),
                                            ],
                                          ),
                                          SvgPicture.asset(
                                            Assets.customiconsArrowDown,
                                            height: 14,
                                            width: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          CustomButton(
                            title: 'Save',
                            onPressed: () => value.updateNotificationPreferences(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NotificationHelpText extends StatelessWidget {
  final TextTheme textTheme;

  const _NotificationHelpText({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage your notifications',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.neutralColor600,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'We’re here to keep you informed, but only with what’s relevant to you. Here’s a quick overview of the types of notifications you can enable:\n',
            style: _genericTextStyle(),
          ),
          const SizedBox(height: 8),
          // Build bullet points
          ...bulletPoints.map((point) {
            return _buildBulletPoint(point['title']!, point['description']!);
          }),
          const SizedBox(height: 8),
          Text(
            'You’re in control! Enable or disable any category to tailor your experience.',
            style: _genericTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet point
          Text(
            '•',
            style: _genericTextStyle(),
          ),
          const SizedBox(width: 6),
          // Text content
          Expanded(
            child: RichText(
              text: TextSpan(
                style: _genericTextStyle(),
                children: [
                  TextSpan(
                    text: title,
                    style: _genericTextStyle(isHeading: true),
                  ),
                  TextSpan(
                    text: description,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _genericTextStyle({bool isHeading = false}) {
    return TextStyle(
      color: AppColors.neutralColor600,
      fontSize: 14.56,
      fontWeight: isHeading ? FontWeight.w700 : FontWeight.w400,
    );
  }
}

class _CommonNotificationToggle extends StatelessWidget {
  const _CommonNotificationToggle({
    required this.textTheme,
    required this.title,
    required this.titleValue,
    this.callBack,
    this.index,
  });

  final TextTheme textTheme;
  final String title;
  final int? index;
  final bool titleValue;
  final Function(bool value)? callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: index == 0 ? 0 : 24,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.neutralColor600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomSwitch(
            value: titleValue,
            onChanged: callBack!,
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 45,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.value ? AppColors.actionColor600 : AppColors.neutralColor300,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Align(
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 17, // Thumb size
            height: 17,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
