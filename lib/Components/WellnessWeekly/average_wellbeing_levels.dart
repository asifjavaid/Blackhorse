import 'package:fl_chart/fl_chart.dart';
import 'package:ekvi/Providers/WellnessWeekly/wellbeing_levels_provider.dart';
import 'package:ekvi/Models/WellnessWeekly/wellbeing_levels_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AverageWellbeingLevels extends StatefulWidget {
  const AverageWellbeingLevels({super.key});

  @override
  State<AverageWellbeingLevels> createState() => _AverageWellbeingLevelsState();
}

class _AverageWellbeingLevelsState extends State<AverageWellbeingLevels> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WellbeingLevelsProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Average wellbeing levels",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 2.h),
          Consumer<WellbeingLevelsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.error != null) {
                return _buildErrorState(context, provider.error!);
              }

              if (provider.hasNoData || !provider.hasSufficientData) {
                return _buildNoDataState(context);
              }

              final dailyAverages = provider.dailyAverages;
              if (dailyAverages.isEmpty) {
                return _buildNoDataState(context);
              }

              return WellnessLineChart(dailyAverages: dailyAverages);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 24,
          ),
          SizedBox(height: 1.h),
          Text(
            "Error loading wellbeing levels",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red.shade700,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataState(BuildContext context) {
    return Stack(
      children: [
        WellnessLineChart(
          dailyAverages: [
            DailyAverage(
              day: 'Monday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
            DailyAverage(
              day: 'Tuesday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
            DailyAverage(
              day: 'Wednesday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
            DailyAverage(
              day: 'Thursday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
            DailyAverage(
              day: 'Friday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
            DailyAverage(
              day: 'Saturday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
            DailyAverage(
              day: 'Sunday',
              moodAvg: 0,
              energyAvg: 0,
              stressAvg: 0,
              date: '',
            ),
          ],
        ),
        // Overlay text
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Start tracking to see your wellbeing levels✨",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WellnessLineChart extends StatelessWidget {
  final List<DailyAverage> dailyAverages;

  const WellnessLineChart({super.key, required this.dailyAverages});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                minY: 1,
                maxY: 10,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, _) => Text(
                        value.toInt().toString(),
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                      getTitlesWidget: (value, _) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < dailyAverages.length) {
                          final day = dailyAverages[value.toInt()].day;
                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              day.substring(0, 3).toUpperCase(),
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 12),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _buildLineBarData(
                    color: Colors.green,
                    spots: _buildMoodSpots(),
                  ),
                  _buildLineBarData(
                    color: Colors.orange,
                    spots: _buildEnergySpots(),
                  ),
                  _buildLineBarData(
                    color: Colors.purple,
                    spots: _buildStressSpots(),
                  ),
                ],
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: 1,
                      color: Colors.grey.shade600,
                      strokeWidth: 0.3,
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.bottomLeft,
                        style: const TextStyle(color: Colors.red),
                        labelResolver: (line) => '',
                      ),
                    ),
                    HorizontalLine(
                      y: 10,
                      color: Colors.grey.shade600,
                      strokeWidth: 0.3,
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topLeft,
                        style: const TextStyle(color: Colors.blue),
                        labelResolver: (line) => '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Legend
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color: Colors.green, label: "Mood"),
              SizedBox(width: 16),
              _LegendDot(color: Colors.orange, label: "Energy"),
              SizedBox(width: 16),
              _LegendDot(color: Colors.purple, label: "Stress"),
            ],
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildLineBarData({
    required Color color,
    required List<FlSpot> spots,
  }) {
    // Check if all values are 0 (no data)
    final hasData = spots.any((spot) => spot.y > 0);

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: hasData ? color : Colors.transparent,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: hasData, // Hide dots when no data
        getDotPainter: (spot, percent, bar, index) =>
            FlDotCirclePainter(radius: 4, color: color, strokeWidth: 0),
      ),
      belowBarData: BarAreaData(show: false),
    );
  }

  List<FlSpot> _buildMoodSpots() {
    return dailyAverages.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.moodAvg);
    }).toList();
  }

  List<FlSpot> _buildEnergySpots() {
    return dailyAverages.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.energyAvg);
    }).toList();
  }

  List<FlSpot> _buildStressSpots() {
    return dailyAverages.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.stressAvg);
    }).toList();
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }
}
