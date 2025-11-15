import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/url_launcher_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndPolicyText extends StatefulWidget {
  const TermsAndPolicyText({
    super.key,
  });

  @override
  State<TermsAndPolicyText> createState() => _TermsAndPolicyTextState();
}

class _TermsAndPolicyTextState extends State<TermsAndPolicyText> {
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _termsRecognizer.onTap = () => UrlLauncherService.openUrl(AppConstant.ekviTermsURL);
    _privacyRecognizer.onTap = () => UrlLauncherService.openUrl(AppConstant.ekviPrivacyURL);
  }

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Terms & Conditions',
            recognizer: _termsRecognizer,
            style: textTheme.labelMedium?.copyWith(
              fontSize: 12,
              color: AppColors.actionColor600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.actionColor600,
            ),
          ),
          TextSpan(
            text: '   |   ',
            style: textTheme.labelMedium?.copyWith(
              fontSize: 12,
              color: AppColors.actionColor600,
            ),
          ),
          TextSpan(
            text: 'Privacy Policy',
            recognizer: _privacyRecognizer,
            style: textTheme.labelMedium?.copyWith(
              fontSize: 12,
              color: AppColors.actionColor600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.actionColor600,
            ),
          ),
        ],
      ),
    );
  }
}
