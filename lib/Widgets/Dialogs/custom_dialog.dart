import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:sizer/sizer.dart';

import '../Buttons/custom_button.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, leftButtonText, rightButtonText;
  // final Image image;
  final Function leftButtonCallback;
  final Function rightButtonCallback;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.leftButtonText,
      required this.rightButtonText,
      // required this.image,
      required this.leftButtonCallback,
      required this.rightButtonCallback});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        // Backdrop filter to blur the background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        // The dialog itself
        Positioned(
          // top: 20.h,
          // left: 0,
          // right: 0,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(4.w),
              // width: 100.w,
              height: 50.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        AppNavigation.goBack();
                      },
                    ),
                  ),
                  // image,
                  SizedBox(height: 2.h),
                  // Heading
                  Text(title, textAlign: TextAlign.center, style: textTheme.headlineSmall!.copyWith(fontSize: 18)),
                  SizedBox(height: 1.h),
                  // Description
                  SizedBox(
                    width: 60.w,
                    child: Text(description, textAlign: TextAlign.center, style: textTheme.bodySmall),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        title: leftButtonText,
                        elevation: 0,
                        color: AppColors.whiteColor,
                        fontColor: AppColors.primaryColor600,
                        minSize: Size(20.w, 5.h),
                        onPressed: () => leftButtonCallback(),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      CustomButton(title: rightButtonText, elevation: 0, minSize: Size(20.w, 5.h), onPressed: () => rightButtonCallback()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
