import 'package:ekvi/Components/Insights/EnergyCharts/insights_average_energy_chart.dart';
import 'package:ekvi/Components/Insights/EnergyCharts/insights_energy_tags.dart';
import 'package:ekvi/Components/Insights/EnergyCharts/insights_maximum_energy_chart.dart';
import 'package:ekvi/Providers/DailyTracker/Energy/energy_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnergyCharts extends StatelessWidget {
  const EnergyCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EnergyProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          value.insightsAverageEnergyChartData.isDataLoaded
              ? InsightsAverageEnergyChart(
                  data: value.insightsAverageEnergyChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          value.insightsMaximumEnergyChartData.isDataLoaded
              ? InsightsMaximumEnergyChart(
                  data: value.insightsMaximumEnergyChartData,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 24,
          ),
          const InsightsEnergyTags(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
