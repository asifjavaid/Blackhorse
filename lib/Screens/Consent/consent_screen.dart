import 'package:ekvi/Components/DeleteAccount/delete_account_dialog.dart';
import 'package:ekvi/Providers/ConsentProvider/consent_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/app_colors.dart';
import '../../Utils/constants/static_constants.dart';
import '../../Widgets/TextFields/custom_checkbox_listile.dart';
import '../../generated/assets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../l10n/app_localizations.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {

  late ConsentProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ConsentProvider>(context, listen: false);
    provider.getConsentPreferences();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(body: GradientBackground(
      child: Consumer<ConsentProvider>(
        builder: (c, value, x) {
          return SafeArea(
            child: SlidingUpPanel(
              controller: value.panelController,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              backdropEnabled: false,
              isDraggable: true,
              renderPanelSheet: true,
              minHeight: 0,
              maxHeight: 690,
              panel: _ConsentHelpText(
                textTheme: textTheme,
              ),
              body: Column(
                children: [
                  BackNavigation(
                      title: "Consent",
                      endIcon: InkWell(
                        onTap: () => value.toggleBottomSheet(),
                        child: SvgPicture.asset(
                          Assets.customiconsQuestion,
                          height: 16,
                          width: 16,
                          color: AppColors.actionColor600,
                        ),
                      ),
                      callback: () {
                        value.updateNotificationPreferences();
                        AppNavigation.goBack();
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        CustomCheckboxListTile(
                          value: value.wantsConsent1,
                          onChanged: value.setWantsConsent1,
                          title: TextSpan(
                            style: textTheme.labelMedium,
                            children: [
                              TextSpan(
                                text: value.consentMessages.first,
                                style: textTheme.labelMedium!
                                    .copyWith(color: AppColors.neutralColor500),
                              ),
                            ],
                          ),
                        ),
                        CustomCheckboxListTile(
                          value: value.wantsConsent2,
                          onChanged: value.setWantsConsent2,
                          title: TextSpan(
                            style: textTheme.labelMedium,
                            children: [
                              TextSpan(
                                text: value.consentMessages[1],
                                style: textTheme.labelMedium!
                                    .copyWith(color: AppColors.neutralColor500),
                              ),
                            ],
                          ),
                        ),
                        CustomCheckboxListTile(
                          value: value.wantsConsent3,
                          onChanged: value.setWantsConsent3,
                          title: TextSpan(
                            style: textTheme.labelMedium,
                            children: [
                              TextSpan(
                                text: value.consentMessages[2],
                                style: textTheme.labelMedium!
                                    .copyWith(color: AppColors.neutralColor500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32 + 24,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}

class _ConsentHelpText extends StatelessWidget {
  final TextTheme textTheme;

  const _ConsentHelpText({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manage your consent',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.neutralColor600,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Your data, your choice. Here\'s what each consent option means and how you can manage them:\n',
            style: _genericTextStyle(),
          ),
          const SizedBox(height: 8),
          // Build bullet points
          ...consentBulletPoints.map((point) {
            return _buildBulletPoint(point['title']!, point['description']!);
          }),
          const SizedBox(height: 8),
          Text(
            'You\'re in control! You can change your optional consent preferences anytime. Changes take effect immediately.',
            style: _genericTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet point
          Text(
            '•',
            style: _genericTextStyle(),
          ),
          const SizedBox(width: 6),
          // Text content
          Expanded(
            child: RichText(
              text: TextSpan(
                style: _genericTextStyle(),
                children: [
                  TextSpan(
                    text: title,
                    style: _genericTextStyle(isHeading: true),
                  ),
                  TextSpan(
                    text: description,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.neutralColor600,
                      height: 1.60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _genericTextStyle({bool isHeading = false}) {
    return TextStyle(
      color: AppColors.neutralColor600,
      fontSize: 14.56,
      fontWeight: isHeading ? FontWeight.w700 : FontWeight.w400,
    );
  }
}
