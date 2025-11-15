import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading {
  static void hideLoadingIndicator() async {
    AppNavigation.goBack();
  }

  static void showLoadingIndicator({bool usePostFrameCallback = true}) {
    void showDialogFunction() {
      showDialog(
        context: AppNavigation.currentContext!,
        barrierDismissible: false,
        // ignore: deprecated_member_use
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: LoadingAnimationWidget.waveDots(
              color: AppColors.primaryColor600,
              size: 55,
            ),
          ),
        ),
      );
    }

    if (usePostFrameCallback) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showDialogFunction());
    } else {
      showDialogFunction();
    }
  }
}
