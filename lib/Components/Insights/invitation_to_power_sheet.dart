import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Providers/userProvider/free_user_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class InvitationToPowerSheet extends StatefulWidget {
  const InvitationToPowerSheet({super.key});

  @override
  InvitationToPowerSheetState createState() => InvitationToPowerSheetState();
}

class InvitationToPowerSheetState extends State<InvitationToPowerSheet> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<FreeUserProvider>(
      builder: (context, value, child) => InvitationOfPower(textTheme: textTheme, value: value),
    );
  }
}

class InvitationOfPower extends StatelessWidget {
  const InvitationOfPower({super.key, required this.textTheme, required this.value});

  final TextTheme textTheme;
  final FreeUserProvider value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is Ekvi Empower?',
            style: textTheme.headlineSmall?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Ekvi Empower is a subscription service designed to support you on your wellness journey. With Ekvi Empower, you will:',
            style: textTheme.bodySmall,
          ),
          UnlockPersonalizedWidget(
            textTheme: textTheme,
            isButton: true,
          ),
          // const SubscriptionStepper(),
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
    );
  }
}

class UnlockPersonalizedWidget extends StatelessWidget {
  const UnlockPersonalizedWidget({
    super.key,
    required this.textTheme,
    required this.isButton,
  });

  final TextTheme textTheme;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32, bottom: isButton ? 32 : 0, left: 16, right: 16),
      child: Column(
        children: [
          InsightRow(
            title: 'Gain personalized insights',
            subtitle: ' into your unique symptom patterns, helping you make sense of your body’s signals.',
            textTheme: textTheme,
          ),
          const SizedBox(height: 16.0),
          InsightRow(
            title: 'Receive exclusive content ',
            subtitle: 'and expert tips tailored to your symptoms, giving you the knowledge to make informed decisions about your well-being.',
            textTheme: textTheme,
          ),
          const SizedBox(height: 16.0),
          InsightRow(
            title: 'Feel supported ',
            subtitle: 'to make informed decisions about your health.',
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }
}

class InsightRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextTheme textTheme;

  const InsightRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "${AppConstant.assetIcons}Vector.svg",
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomCenter,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: textTheme.bodySmall,
                ),
                TextSpan(
                  text: subtitle,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
