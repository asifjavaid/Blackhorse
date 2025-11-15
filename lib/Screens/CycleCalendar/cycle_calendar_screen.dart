import 'package:ekvi/Components/CycleCalendar/cycle_calendar_header.dart';
import 'package:ekvi/Components/CycleCalendar/cycle_calendar_panel_content.dart';
import 'package:ekvi/Components/CycleCalendar/cycle_calendar_instructions.dart';
import 'package:ekvi/Components/CycleCalendar/cycle_calendar_monthly_widget.dart';
import 'package:ekvi/Providers/CycleCalendar/cycle_calendar_provider.dart';
import 'package:ekvi/Screens/CycleCalendar/cycle_predictions_ui_helper.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CycleCalendarScreen extends StatefulWidget {
  const CycleCalendarScreen({super.key});

  @override
  State<CycleCalendarScreen> createState() => _CycleCalendarScreenState();
}

class _CycleCalendarScreenState extends State<CycleCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CycleCalendarProvider>(
        builder: (context, value, child) => GradientBackground(
          child: SafeArea(
            child: (!value.shouldViewInstructions)
                ? value.cycleCalendarData.isDataLoaded
                    ? Stack(children: [
                        SlidingUpPanel(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          backdropEnabled: false,
                          backdropOpacity: 0.6,
                          renderPanelSheet: true,
                          maxHeight: !value.isEditMode
                              ? !value.showNotificationText
                                  ? 104
                                  : 134
                              : 290,
                          minHeight: !value.isEditMode
                              ? !value.showNotificationText
                                  ? 104
                                  : 134
                              : 290,
                          panel: const CyclePredictionPanelContent(),
                          body: Column(
                            children: [
                              const CyclePredictionHeader(),
                              Expanded(
                                child: InfiniteListView.builder(
                                  itemBuilder: (BuildContext context, int index) {
                                    DateTime month = HelperFunctions.calculateMonth(index);
                                    return MonthCalendarWidget(focusedDay: month);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SlidingUpPanel(
                          controller: value.panelController,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          maxHeight: value.panelType == PanelType.viewCycleCalendarInformation ? 314 : CyclePredictionsUIHelper.calculatePanelMaxHeight(value.selectedCycleDay),
                          minHeight: 0,
                          panel: CyclePredictionsUIHelper.panelContent(value.panelType),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19F89D87),
                              blurRadius: 6,
                              offset: Offset(-2, -2),
                              spreadRadius: 0,
                            )
                          ],
                        )
                      ])
                    : const SizedBox.shrink()
                : const SingleChildScrollView(
                    child: Column(
                      children: [
                        CyclePredictionHeader(),
                        SizedBox(
                          height: 20,
                        ),
                        CycleCalendarInstructions(),
                        SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
