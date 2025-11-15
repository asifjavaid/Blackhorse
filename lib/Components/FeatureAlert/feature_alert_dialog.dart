import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureAlertDialog extends StatelessWidget {
  const FeatureAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      surfaceTintColor: AppColors.whiteColor,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: const Icon(Icons.close), onPressed: () => AppNavigation.goBack()),
            ),
            const SizedBox(
              height: 32,
            ),
            const AnnouncementWidget(),
            const SizedBox(
              height: 32,
            ),
            Text("New Feature Alert", style: textTheme.displayMedium),
            const SizedBox(height: 16),
            Text(
              "Some new symptoms made it into the tracking! Let us introduce; Mood, Stress & Energy. Give it a go, and see what you think!",
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 207,
        height: 207,
        padding: const EdgeInsets.all(40.39),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.29),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19F89D87),
              blurRadius: 6,
              offset: Offset(2, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            "${AppConstant.assetIcons}announcement.svg",
            height: 126,
            width: 126,
          ),
        ));
  }
}
