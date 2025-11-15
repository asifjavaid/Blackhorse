import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CyclePredictionHeader extends StatelessWidget {
  const CyclePredictionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CycleCalendarProvider>(context, listen: true);
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 16, bottom: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text("Calendar",
              textAlign: TextAlign.center, style: textTheme.displaySmall),
          const Spacer(),
          GestureDetector(
            onTap: () => provider.handleCycleCalendarInformation(),
            child: SvgPicture.asset(
              "${AppConstant.assetIcons}info.svg",
              semanticsLabel: 'Cycle Calendar Info',
            ),
          ),
        ],
      ),
    );
  }
}
