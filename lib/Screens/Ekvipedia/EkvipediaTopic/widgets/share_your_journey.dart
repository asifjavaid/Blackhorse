import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/url_launcher_helper.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';

class ShareYourJourney extends StatelessWidget {
  const ShareYourJourney({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share Your Journey with Us",
            style: textTheme.displaySmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Your experience with endometriosis is unique, and your story could inspire and support others on their journey.\n\nWhether you’ve faced challenges, found strength, or discovered new ways to thrive, we want to hear from you.\n\nShare your voice, because it deserves to be heard.",
            style: textTheme.bodySmall,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomButton(
            title: "Share My Story",
            onPressed: () async {
              UrlLauncherService.openUrl(AppConstant.shareMyStory);
            },
            buttonType: ButtonType.secondary,
          ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }
}
