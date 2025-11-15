// file: my_painkillers.dart

import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyPainkillers extends StatelessWidget {
  const MyPainkillers({super.key});

  @override
  Widget build(BuildContext context) {
    final vaultProvider = Provider.of<PainKillersVaultProvider>(context);
    final pkProvider = Provider.of<PainKillersProvider>(context);
    final activePills = vaultProvider.currentPills;
    final allPills = vaultProvider.allPills;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [AppThemes.shadowDown],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My painkillers",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              GestureDetector(
                  child: HelperFunctions.giveBackgroundToIcon(
                      height: 36,
                      width: 36,
                      allPills.isEmpty
                          ? const Icon(
                              Icons.add,
                            )
                          : SvgPicture.asset(
                              '${AppConstant.assetIcons}edit.svg',
                              height: 36,
                            ),
                      bgColor: AppColors.actionColor400),
                  onTap: () => allPills.isEmpty ? AppNavigation.navigateTo(AppRoutes.painKillerAddScreen) : AppNavigation.navigateTo(AppRoutes.allPainKillersVault))
            ],
          ),
          const SizedBox(height: 16),
          if (allPills.isEmpty)
            Text(
              "You haven't added any painkillers yet. Add one by clicking the + icon.",
              style: textTheme.titleSmall!.copyWith(
                color: AppColors.neutralColor500,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (activePills.isEmpty)
            Text(
              "You haven't marked any painkillers as active. Review them by clicking the edit icon.",
              style: textTheme.titleSmall!.copyWith(
                color: AppColors.neutralColor500,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            // Otherwise, display each pill with +/- controls
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activePills.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final pill = activePills[index];
                final currentQuantity = pkProvider.getPillQuantity(pill);

                return Row(
                  children: [
                    HelperFunctions.giveBackgroundToIcon(
                      width: 36,
                      height: 36,
                      const Icon(
                        AppCustomIcons.pill_1,
                        color: AppColors.actionColor600,
                        size: 18,
                      ),
                      bgColor: AppColors.actionColor400,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pill.name,
                            style: textTheme.bodySmall,
                          ),
                          Text(
                            "${pill.dosage}${pill.dosageEntity}",
                            style: textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: currentQuantity > 0 ? () => pkProvider.decrementPillQuantity(pill) : null,
                      child: HelperFunctions.giveBackgroundToIcon(
                          height: 30,
                          width: 30,
                          const Icon(
                            Icons.remove,
                            size: 18,
                          ),
                          bgColor: AppColors.actionColor400),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: AppColors.actionColor500),
                      ),
                      child: Center(child: Text("$currentQuantity", style: Theme.of(context).textTheme.bodyMedium)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () => pkProvider.incrementPillQuantity(pill),
                      child: HelperFunctions.giveBackgroundToIcon(height: 30, width: 30, const Icon(Icons.add, size: 18), bgColor: AppColors.actionColor400),
                    )
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
