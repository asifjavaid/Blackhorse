import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/url_launcher_helper.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';

class EkviStore extends StatelessWidget {
  const EkviStore({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 64,
          ),
          Text(
            "Join the Ekvi Tribe",
            style: textTheme.displaySmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "This is your space to connect with other women living with endometriosis, share experiences, ask questions, and support one another. It’s also where we’ll discuss and announce exciting feature updates for the Ekvi app and host community events🧡 ",
            style: textTheme.bodySmall,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomButton(
            title: "Join the Ekvi Tribe",
            onPressed: () {
              UrlLauncherService.openUrl(AppConstant.joinTheEkviTribe);
            },
            buttonType: ButtonType.primary,
          ),
        ],
      ),
    );
  }
}
