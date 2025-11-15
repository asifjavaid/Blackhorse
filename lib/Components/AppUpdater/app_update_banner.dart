import 'package:ekvi/Providers/AppUpdater/app_updater_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppUpdateBanner extends StatelessWidget {
  const AppUpdateBanner({super.key, s});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<AppUpdaterProvider>(
      builder: (context, value, child) => value.showBanner
          ? Container(
              width: double.infinity,
              color: AppColors.actionColor600,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.updateMessage,
                          style: textTheme.bodyMedium!.copyWith(color: AppColors.neutralColor50),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: value.launchStoreUrl,
                              child: Text(
                                'Update to the latest version',
                                style: textTheme.headlineSmall!.copyWith(
                                  color: AppColors.neutralColor50,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.neutralColor50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
