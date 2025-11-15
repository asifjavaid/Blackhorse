import 'package:ekvi/Providers/Insights/multi_symptoms_chart_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InsightsExpandGraphWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const InsightsExpandGraphWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ??
            () {
              Provider.of<MultiSymptomsChartProvider>(context, listen: false).initializeGraphType(MultiSymptomChartType.average);
              AppNavigation.navigateTo(
                AppRoutes.multisymptomschart,
              );
            },
        child: Container(
          width: 36,
          height: 36,
          decoration: const ShapeDecoration(
            color: AppColors.actionColor400,
            shape: OvalBorder(),
          ),
          child: Center(
            child: SizedBox(
              height: 16,
              width: 16,
              child: SvgPicture.asset(
                "${AppConstant.assetIcons}expand.svg",
              ),
            ),
          ),
        ));
  }
}
