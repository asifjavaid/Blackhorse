import 'package:ekvi/Components/FAQ/faq_widget.dart';
import 'package:ekvi/Providers/FAQs/faqs_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackNavigation(title: "FAQs", callback: () => AppNavigation.goBack()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Got questions?",
                        style: textTheme.displayMedium,
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        "We've got answers! So, go ahead, explore, and discover all the ways Ekvi can make your life easier and more enjoyable. We're here to ensure that your time with us is not just productive but also a lot of fun. Happy Ekvi-ing!",
                        style: textTheme.labelMedium,
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
                Consumer<FAQsProvider>(
                  builder: (context, value, child) => ContentBox(padding: const EdgeInsets.only(left: 12, right: 12, top: 12), listView: false, children: [
                    ...value.faqs.map((faq) => FAQWidget(faq: faq)),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
