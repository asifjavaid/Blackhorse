import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:flutter/material.dart';

class EditProfileSettings extends StatelessWidget {
  const EditProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackNavigation(
                    title: "Profile Settings",
                    callback: () {
                      AppNavigation.goBack();
                    }),
                if (UserManager().isPremium)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      title: Text("Subscription", style: Theme.of(AppNavigation.currentContext!).textTheme.bodyMedium),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.actionColor600,
                        size: 24,
                      ),
                      onTap: () => AppNavigation.navigateTo(AppRoutes.subscriptionPlan),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListTile(
                    title: Text("Delete account", style: Theme.of(AppNavigation.currentContext!).textTheme.bodyMedium),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.actionColor600,
                      size: 24,
                    ),
                    onTap: () => AppNavigation.navigateTo(AppRoutes.deleteAccount),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
