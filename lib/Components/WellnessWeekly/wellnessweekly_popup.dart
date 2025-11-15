import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WellnessWeeklyPopup extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;

  const WellnessWeeklyPopup({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 85.w,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [AppThemes.shadowDown],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => AppNavigation.goBack(),
                  borderRadius: BorderRadius.circular(100),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: AppColors.actionColor600,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset(
                  "assets/images/wellness_weekly_notification.png",
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFamily: "Zitter",
                      fontSize: 20,
                      height: 1.3,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.neutralColor600,
                    ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                title: buttonText,
                onPressed: () {
                  AppNavigation.navigateTo(AppRoutes.wellnessWeeklyScreen);
                },
                buttonType: ButtonType.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
