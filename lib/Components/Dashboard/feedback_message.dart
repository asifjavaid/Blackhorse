import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class FeedbackMessage extends StatelessWidget {
  const FeedbackMessage({super.key});

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
            AppLocalizations.of(context)!.appForYou,
            style: textTheme.displaySmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "So your thoughts mean the world to us. If you had a wishlist for this app, what magical ingredients would you sprinkle to make it uniquely yours?\n\nShare your dreams, and let's make this app an even greater masterpiece together 🧡",
            style: textTheme.bodySmall,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomButton(
            title: AppLocalizations.of(context)!.shareWishes,
            buttonType: ButtonType.secondary,
            onPressed: () async {
              await Intercom.instance.displayMessenger();
            },
          ),
          const SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }
}
