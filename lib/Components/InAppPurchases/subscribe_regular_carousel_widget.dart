import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SubscribeRegularCarouselWidget extends StatefulWidget {
  const SubscribeRegularCarouselWidget({super.key});

  @override
  State<SubscribeRegularCarouselWidget> createState() => SubscribeRegularCarouselWidgetState();
}

class SubscribeRegularCarouselWidgetState extends State<SubscribeRegularCarouselWidget> {
  final List<CarouselItemData> items = [
    CarouselItemData(
      itemAddress: "${AppConstant.assetImages}subscribe_regular_carousel.svg",
      title: "Unlock",
      text: "Unlock your personalized insights, patterns, and trends unique to you.",
    ),
    CarouselItemData(
      itemAddress: "${AppConstant.assetImages}subscribe_regular_carousel.svg",
      title: "Learn",
      text: "Access all stories and expert tips in Ekvipedia, including content tailored to your symptoms.",
    ),
    CarouselItemData(
      itemAddress: "${AppConstant.assetImages}subscribe_regular_carousel.svg",
      title: "Empower",
      text: "Feel supported to make informed decisions about your health.",
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "${AppConstant.assetImages}subscribe_regular_carousel.svg",
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 15.h,
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
              enlargeFactor: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
            items: items.map((data) {
              return Column(
                children: [
                  const SizedBox(height: 8),
                  Text(data.title, textAlign: TextAlign.center, style: textTheme.displayMedium),
                  const SizedBox(height: 8),
                  Text(
                    data.text,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                ],
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
                  border: Border.all(
                    color: currentIndex == index ? AppColors.secondaryColor600 : AppColors.secondaryColor500,
                    width: 2,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CarouselItemData {
  final String title;
  final String text;
  final String itemAddress;

  CarouselItemData({required this.title, required this.itemAddress, required this.text});
}
