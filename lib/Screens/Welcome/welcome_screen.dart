import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Providers/Splash/splash_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Consumer<SplashProvider>(builder: (context, value, child) {
        return GradientBackground(
          child: Selector<LocaleProvider, Locale>(
            selector: (context, provider) => provider.locale,
            builder: (context, locale, child) {
              value.updateWelcomeData(context);
              return Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 6.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: cs.CarouselSlider(
                        options: cs.CarouselOptions(
                          height: 35.h,
                          pauseAutoPlayInFiniteScroll: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 10),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            value.updateCurrentWelcomeData(index);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        items: List.from(value.welcomeData).map((data) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data.title,
                                      textAlign: TextAlign.center,
                                      style: textTheme.displayLarge),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(data.description,
                                      textAlign: TextAlign.center,
                                      style: textTheme.bodySmall),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    value.currentWelcomeDataIndex < 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: value.welcomeData.map((data) {
                              int index = value.welcomeData.indexOf(data);
                              return Container(
                                width: 6.0,
                                height: 6.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        value.currentWelcomeDataIndex == index
                                            ? AppColors.secondaryColor600
                                            : Colors.transparent,
                                    border: Border.all(
                                        color: AppColors.secondaryColor600)),
                              );
                            }).toList(),
                          )
                        : CustomButton(
                            title: AppLocalizations.of(context)!.getStarted,
                            onPressed: () => AppNavigation.navigateTo(
                                AppRoutes.registerRoute),
                          ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
