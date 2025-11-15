import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:flutter/material.dart';

class SelfcareShell extends StatelessWidget {
  final String title;
  final Widget body;
  const SelfcareShell({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BackNavigation(
                    title: title,
                    callback: () => AppNavigation.goBack(),
                  ),
                  body,
                ],
              ),
            ),
          ),
        ),
      );
}
