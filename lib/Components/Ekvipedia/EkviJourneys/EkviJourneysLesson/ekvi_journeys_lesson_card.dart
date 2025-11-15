import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EkviJourneysLessonCard extends StatelessWidget {
  const EkviJourneysLessonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysProvider>();
    final lesson = provider.currentCourseLesson;
    final textTheme = Theme.of(context).textTheme;

    if (lesson == null) return const SizedBox.shrink();

    final int currentOrder = lesson.moduleOrder ?? 2;
    final int totalModules = lesson.totalModules ?? 5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        const maxCardWidth = 600.0;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? maxCardWidth : double.infinity,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 64),
                Text(
                  'You are  on a mission!',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._buildProgressionIndicator(
                              currentOrder, totalModules),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            AppRoutes.ekviJourneysLesson,
                            arguments:
                                ScreenArguments(isCurrentLessonFlow: true),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [AppThemes.shadowDown],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      lesson.moduleFeaturedImageUrl
                                                  ?.isNotEmpty ==
                                              true
                                          ? lesson.moduleFeaturedImageUrl!
                                          : 'https://tigerweb.towson.edu/plupin1/images/tom-and-jerry.jpeg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 20, 16, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lesson.moduleTitle ?? '',
                                      style: textTheme.headlineSmall
                                          ?.copyWith(height: 1.1),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Module ${lesson.moduleOrder ?? '-'} of ${lesson.totalModules ?? '-'}',
                                          style:
                                              textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        CustomButton(
                                          title: 'Continue',
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(
                                              AppRoutes.ekviJourneysLesson,
                                              arguments: ScreenArguments(
                                                  isCurrentLessonFlow: true),
                                            );
                                          },
                                          buttonType: ButtonType.primary,
                                          minSize: const Size(110, 26),
                                          maxSize: const Size(110, 26),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildProgressionIndicator(int currentOrder, int totalModules) {
    List<Widget> widgets = [];

    // Determine which 3 circles to show based on current module position
    List<int> visibleCircles = [];

    if (currentOrder == 1) {
      // Module 1: Show 1, 2, 3
      visibleCircles = [1, 2, 3];
    } else if (currentOrder == totalModules) {
      // Last module: Show last 3 modules
      visibleCircles = [totalModules - 2, totalModules - 1, totalModules];
    } else {
      // Middle modules: Show current module and 2 after it
      visibleCircles = [currentOrder - 1, currentOrder, currentOrder + 1];
    }

    // Show only the determined circles
    for (int i = 0; i < visibleCircles.length; i++) {
      int circleNumber = visibleCircles[i];

      // Add circle with appropriate offset
      double horizontalOffset = 0.0;
      if (i == 0) {
        horizontalOffset = 12.0; // First circle offset
      } else if (i == visibleCircles.length - 1) {
        horizontalOffset = 12.0; // Last circle offset
      }

      widgets.add(_buildOffsetModuleCircle('$circleNumber',
          isCurrent: circleNumber == currentOrder,
          horizontalOffset: horizontalOffset));

      // Add dotted line between circles (except after the last circle)
      if (i < visibleCircles.length - 1) {
        double startOffset = 0.0;
        double endOffset = 0.0;
        bool reverse = false;

        if (i == 0) {
          startOffset = 12.0;
          endOffset = 3.0;
        } else if (i == visibleCircles.length - 2) {
          startOffset = 3.0;
          endOffset = 12.0;
          reverse = true;
        }

        widgets.add(_buildDottedLine(
            startOffset: startOffset, endOffset: endOffset, reverse: reverse));
      }
    }

    return widgets;
  }

  static Widget _buildModuleCircle(String label, {required bool isCurrent}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrent
            ? AppColors.neutralColor50
            : AppColors.neutralColor50.withOpacity(0.4),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Zitter',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: isCurrent
                ? AppColors.actionColor600
                : AppColors.actionColor600.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  static Widget _buildOffsetModuleCircle(String label,
      {required bool isCurrent, double horizontalOffset = 0.0}) {
    return Row(
      children: [
        SizedBox(width: horizontalOffset),
        _buildModuleCircle(label, isCurrent: isCurrent),
      ],
    );
  }

  static Widget _buildDottedLine({
    bool reverse = false,
    double height = 36,
    double startOffset = 0,
    double endOffset = 0,
  }) {
    return CustomPaint(
      size: Size(24 + startOffset + endOffset, height),
      painter: CurvedDottedLinePainter(
        color: AppColors.actionColor600.withOpacity(0.5),
        reverse: reverse,
        startOffset: startOffset,
        endOffset: endOffset,
      ),
    );
  }
}

class CurvedDottedLinePainter extends CustomPainter {
  final Color color;
  final bool reverse;
  final double startOffset;
  final double endOffset;

  CurvedDottedLinePainter({
    required this.color,
    this.reverse = false,
    this.startOffset = 0,
    this.endOffset = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.moveTo(startOffset + size.width / 2, 0);
    path.quadraticBezierTo(
      size.width * (reverse ? 0.55 : 0.75),
      size.height / 2,
      size.width / 2 + endOffset,
      size.height,
    );

    const double dashWidth = 2.0;
    const double dashSpace = 2.1;
    double distance = 0.0;

    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
