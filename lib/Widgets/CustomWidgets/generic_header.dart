import 'package:ekvi/Providers/WellnessWeekly/wellness_weekly_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:provider/provider.dart';

class GenericScreenHeader extends StatelessWidget {
  final String text;
  const GenericScreenHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Consumer<WellnessWeeklyProvider>(
        builder: (context, provider, child) => SizedBox(
              height: kToolbarHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildBackButton(),
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontFamily: "Zitter",
                          fontSize: 20,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ));
  }

  GestureDetector _buildBackButton() {
    return GestureDetector(
      onTap: () {
        AppNavigation.goBack();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 48,
        width: 48,
        child: Center(
          child: SvgPicture.asset(
            '${AppConstant.assetIcons}backIcon.svg',
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
