import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
// import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

class LanguagePanel extends StatelessWidget {
  const LanguagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<SideNavManagerProvider>(
      builder: (context, sideNavManager, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            "Select language",
            style: textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _buildLanguageContainer(context, '${AppConstant.assetImages}english.png', 'English', sideNavManager.languageCode == "en", "en"),
              // _buildLanguageContainer(context, '${AppConstant.assetImages}norwegian.png', 'Norwegian', sideNavManager.languageCode == "nb", "nb"),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          CustomButton(
            onPressed: () {
              sideNavManager.saveSelectedLanguage(context);
            },
            title: "Save",
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  // Widget _buildLanguageContainer(BuildContext context, String imagePath, String text, bool isSelected, String languageCodeToSet) {
  //   TextTheme textTheme = Theme.of(context).textTheme;
  //   return InkWell(
  //     onTap: () => Provider.of<SideNavManagerProvider>(context, listen: false).updateLanguageCode(languageCodeToSet),
  //     child: Container(
  //       width: 36.w,
  //       height: 150,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12.0),
  //         border: Border.all(
  //           color: isSelected ? AppColors.accentColorTwo500 : AppColors.neutralColor200, // Change the border color when selected
  //           width: 1.0,
  //         ),
  //         color: isSelected ? AppColors.accentColorTwo400 : AppColors.whiteColor, // Change the background color when selected
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           // Image.asset(
  //           //   imagePath,
  //           //   width: 55.0,
  //           //   height: 55.0,
  //           // ),
  //           const SizedBox(height: 16.0),
  //           Text(
  //             text,
  //             style: textTheme.bodyMedium!.copyWith(fontSize: 14),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
