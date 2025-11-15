import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CycleCalendarInstructions extends StatefulWidget {
  const CycleCalendarInstructions({super.key});

  @override
  State<CycleCalendarInstructions> createState() => _CycleCalendarInstructionsState();
}

class _CycleCalendarInstructionsState extends State<CycleCalendarInstructions> {
  final List<CarouselItemData> items = [
    CarouselItemData(itemAddress: "${AppConstant.assetImages}cycle_predictions_instructions_1.svg"),
    CarouselItemData(itemAddress: "${AppConstant.assetImages}cycle_predictions_instructions_2.svg"),
    CarouselItemData(itemAddress: "${AppConstant.assetImages}cycle_predictions_instructions_4.svg"),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Consumer<CycleCalendarProvider>(
        builder: (context, value, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 35.h,
                      pauseAutoPlayInFiniteScroll: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                    items: items.map((data) {
                      return data.itemAddress.endsWith("png")
                          ? Image.asset(data.itemAddress)
                          : SvgPicture.asset(
                              data.itemAddress,
                              height: 26.h,
                              width: 91.w,
                            );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items.map((data) {
                      int index = items.indexOf(data);
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index ? AppColors.secondaryColor600 : Colors.transparent,
                          border: Border.all(color: currentIndex == index ? AppColors.secondaryColor600 : AppColors.secondaryColor500, width: 2),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Welcome to your Cycle Calendar!\n\nDive into tracking your periods, pain, and bleeding with a few taps. This is your space for logging, understanding, and taking charge of your endo symptoms. Each entry is a step toward deeper insights and empowerment.\n\nStart today, and let’s transform how you connect with your body🧡",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    title: "Let's Go",
                    onPressed: () => value.setInstructionsViewed(),
                  ),
                ],
              ),
            ));
  }
}

class CarouselItemData {
  final String itemAddress;

  CarouselItemData({required this.itemAddress});
}
