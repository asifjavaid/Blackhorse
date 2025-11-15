import 'package:ekvi/Components/Insights/invitation_to_power_sheet.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Providers/userProvider/free_user_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnlockStoriesPanelContent extends StatefulWidget {
  const UnlockStoriesPanelContent({super.key});

  @override
  State<UnlockStoriesPanelContent> createState() => _UnlockStoriesPanelContentState();
}

class _UnlockStoriesPanelContentState extends State<UnlockStoriesPanelContent> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<FreeUserProvider>(
      builder: (context, value, child) => Column(
        children: [
          if (value.unlockStory)
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      value.invitationToPowerShow(!value.invitationToPower);
                      if (value.invitationToPower) {
                        var res = await showModelFunction(context);
                        if (res) {
                          value.invitationToPowerShow(!value.invitationToPower);
                        }
                      }
                    },
                    child: Text('Exciting, tell me more',
                        textAlign: TextAlign.center,
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.actionColor600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.actionColor600,
                        )),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                      title: 'Unlock your data',
                      onPressed: () {
                        PurchaseAccessedEvent(feature: "Insights").log();
                        AppNavigation.navigateTo(AppRoutes.subscribe);
                      }),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<bool> showModelFunction(context) {
    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (c) {
          return const InvitationToPowerSheet();
        }).then(
      (value) {
        return true;
      },
    );
  }
}
