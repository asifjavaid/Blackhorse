import 'package:ekvi/Components/PainRelief/pain_relief_practice_option_chip.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/YourWellBeing/your_well_being_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PainReliefMyPractices extends StatelessWidget {
  const PainReliefMyPractices({super.key});

  @override
  Widget build(BuildContext context) {
    final vaultProvider = Provider.of<PainReliefVaultProvider>(context);
    final currentPractices = vaultProvider.currentPractices;
    final allPractices = vaultProvider.allPractices;
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
                "My practices",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              GestureDetector(
                onTap: allPractices.isEmpty
                    ? () => AppNavigation.navigateTo(AppRoutes.addPainReliefPracticesScreen)
                    : () {
                        Provider.of<YourWellBeingProvider>(context, listen: false).selectTab(WellbeingTab.painRelief);
                        AppNavigation.navigateTo(AppRoutes.yourWellBeingScreen);
                      },
                child: HelperFunctions.giveBackgroundToIcon(
                  height: 36,
                  width: 36,
                  allPractices.isEmpty
                      ? const Icon(Icons.add)
                      : SvgPicture.asset(
                          '${AppConstant.assetIcons}edit.svg',
                          height: 36,
                        ),
                  bgColor: AppColors.actionColor400,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          if (allPractices.isEmpty)
            Text(
              "You haven't added any pain relief practices yet. Add one by clicking the + icon.",
              style: textTheme.titleSmall!.copyWith(
                color: AppColors.neutralColor500,
                fontStyle: FontStyle.italic,
              ),
            )
          else if (currentPractices.isEmpty)
            Text(
              "You haven't marked any pain relief practices as active. Review them by clicking the edit icon.",
              style: textTheme.titleSmall!.copyWith(
                color: AppColors.neutralColor500,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: currentPractices
                  .map((practice) => PainReliefPracticeOptionChip(
                        practice: practice,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
