import "dart:math" as math;

import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PainLevelSelector extends StatelessWidget {
  final String? title;
  final ValueChanged<int> onChanged;
  final int? selectedPainLevel;
  final List<String>? levels;

  final List<Color>? activeTrackColorList;
  final bool elevated;
  final EdgeInsets? margin;
  final bool? enableHelp;
  final Widget? helpWidget;

  PainLevelSelector(
      {super.key,
      this.title,
      required this.onChanged,
      this.selectedPainLevel,
      this.levels,
      this.enableHelp = true,
      this.activeTrackColorList,
      this.elevated = true,
      this.margin,
      this.helpWidget});

  final List<String> descriptors = [
    "Minimal: I can notice a faint pain, but it's not slowing me down.",
    "Mild: I'm aware of the pain. It's like a persistent hum in the background.",
    "Uncomfortable: There's a nagging pain that's hard to ignore. It's uncomfortable but manageable.",
    "Moderate: I am constantly aware of the pain but I can continue most activities.",
    "Distracting: My pain is persistent enough that it's distracting me from my tasks.",
    "Distressing: It's difficult to maintain my routine because the pain demands attention.",
    "Unmanageable: I am in constant pain. It’s restricting my enjoyment and participation in daily activities.",
    "Severe: Pain dominates my existence. It's difficult to engage in conversation or even think clearly.",
    "Debilitating: The pain consumes all my attention. It's a challenge to express thoughts or needs.",
    "Excruciating: I'm completely overwhelmed by pain. Can’t move, can’t think, can’t bear it."
  ];

  final List<Color> activeTrackColors = [
    AppColors.successColor500,
    AppColors.successColor500,
    AppColors.successColor500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.accentColorTwo500,
    AppColors.errorColor500,
    AppColors.errorColor500,
    AppColors.errorColor500,
  ];

  final List<String> painLevels = [
    "Minimal",
    "Mild",
    "Uncomfortable",
    "Moderate",
    "Distracting",
    "Distressing",
    "Unmanageable",
    "Severe",
    "Debilitating",
    "Excruciating"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: elevated ? [AppThemes.shadowDown] : [],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title ?? "How intense was it?",
                    style: Theme.of(context).textTheme.headlineSmall),
                enableHelp ?? true
                    ? GestureDetector(
                        onTap: () => HelperFunctions.openCustomBottomSheet(
                            context,
                            content:
                                helpWidget ?? const PainLevelSelectorWidget(),
                            height: 645),
                        child: SvgPicture.asset(
                          "${AppConstant.assetIcons}info.svg",
                          semanticsLabel: 'Cycle Calendar Info',
                          width: 24,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(height: 16.0),
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: SliderTheme(
                    data: SliderThemeData(
                        activeTrackColor: _getActiveTrackColor(
                            selectedPainLevel, activeTrackColorList),
                        inactiveTrackColor: AppColors.neutralColor200,
                        trackShape: CustomSliderTrackShape(
                            radius: 12.0, 
                            divisions: 10,
                            selectedPainLevel: selectedPainLevel ?? 0),
                        trackHeight: 26.0,
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 0),
                        thumbShape: SliderComponentShape.noThumb,
                        tickMarkShape: SliderTickMarkShape.noTickMark),
                    child: Slider(
                        value: (selectedPainLevel ?? 0).toDouble(),
                        min: 0,
                        max: 10,
                        divisions: 10,
                        onChanged: (value) => onChanged(value.round())))),
            const SizedBox(height: 14),
            _renderLevels()
          ],
        ),
      ),
    );
  }

  Widget _renderLevels() {
    if (levels != null) {
      return _buildLevels(levels!);
    } else if (selectedPainLevel != null && selectedPainLevel! > 0) {
      return _buildSelectedPainLevelText();
    }
    return const SizedBox.shrink();
  }

  Widget _buildSelectedPainLevelText() {
    final selectedPainLevelText = painLevels[selectedPainLevel! - 1];
    return Row(children: [
      Container(
        margin: EdgeInsets.only(
          left: HelperFunctions.getPainLevelTextMargin(selectedPainLevel),
        ),
        child: Text(
          selectedPainLevelText,
          style: Theme.of(AppNavigation.currentContext!).textTheme.labelMedium,
        ),
      ),
    ]);
  }

  Widget _buildLevels(List<String> levels) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: levels
            .map(
              (level) => Text(
                level,
                style: Theme.of(AppNavigation.currentContext!)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppColors.neutralColor500),
              ),
            )
            .toList());
  }

  Color _getActiveTrackColor(
      int? selectedPainLevel, List<Color>? activeTrackColorList) {
    if (selectedPainLevel == null || selectedPainLevel <= 0) {
      return Colors.transparent;
    }
    int index = selectedPainLevel - 1;
    if (activeTrackColorList != null && index < activeTrackColorList.length) {
      return activeTrackColorList[index];
    }
    return activeTrackColors[math.min(index, activeTrackColors.length - 1)];
  }
}

class CustomSliderTrackShape extends SliderTrackShape {
  final double radius;
  final int divisions;
  final int selectedPainLevel;
  const CustomSliderTrackShape({
    this.radius = 12.0, 
    required this.divisions,
    required this.selectedPainLevel
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
    Offset? secondaryOffset,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final Paint activePaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? Colors.blue;
    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor ?? Colors.grey;
    final Paint borderPaint = Paint()
      ..color = AppColors.neutralColor300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;

    final double trackWidth = parentBox.size.width;
    final Radius radiusValue = Radius.circular(radius);

    // Inactive track
    final Rect inactiveRect = Rect.fromLTRB(
        offset.dx,
        offset.dy + (parentBox.size.height - trackHeight) / 2,
        offset.dx + trackWidth,
        offset.dy + (parentBox.size.height + trackHeight) / 2);
    context.canvas.drawRRect(
        RRect.fromRectAndCorners(inactiveRect,
            topLeft: radiusValue,
            bottomLeft: radiusValue,
            topRight: radiusValue,
            bottomRight: radiusValue),
        inactivePaint);

    // Draw border around the inactive track
    context.canvas.drawRRect(
        RRect.fromRectAndCorners(inactiveRect,
            topLeft: radiusValue,
            bottomLeft: radiusValue,
            topRight: radiusValue,
            bottomRight: radiusValue),
        borderPaint);

    // Calculate the exact position for the selected pain level
    final double divisionWidth = trackWidth / divisions;
    final double activeTrackEnd = offset.dx + (selectedPainLevel * divisionWidth);

    // Active track
    final Rect activeRect = Rect.fromLTRB(
        offset.dx,
        offset.dy + (parentBox.size.height - trackHeight) / 2,
        activeTrackEnd,
        offset.dy + (parentBox.size.height + trackHeight) / 2);
    context.canvas.drawRRect(
        RRect.fromRectAndCorners(activeRect,
            topLeft: radiusValue, bottomLeft: radiusValue),
        activePaint);

    // Division markers
    Paint divisionPaint = Paint()
      ..color = AppColors.neutralColor300
      ..strokeWidth = 0.2;

    // Draw lines on the inactive part of the track
    for (int i = 1; i < divisions; i++) {
      double x = offset.dx + i * divisionWidth;
      if (x > activeTrackEnd) {
        context.canvas.drawLine(
            Offset(x, offset.dy + (parentBox.size.height - trackHeight) / 2),
            Offset(x, offset.dy + (parentBox.size.height + trackHeight) / 2),
            divisionPaint);
      }
    }
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(offset.dx, trackTop, trackWidth, trackHeight);
  }
}

class PainLevelSelectorWidget extends StatelessWidget {
  const PainLevelSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating your pain relief',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(TextSpan(
            children: [
              _SubtitleText(
                  "Tracking how well the painkiller eased your pain can help you and your healthcare provider understand what works best for you. After taking your painkiller, describe the relief "
                  "you felt using the scale:\n",
                  textTheme),
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text.rich(
              TextSpan(
                children: [
                  _TitleText('• None: ', textTheme),
                  _SubtitleText("No relief at all\n", textTheme),
                  _TitleText('• Mild: ', textTheme),
                  _SubtitleText("Just a little better\n", textTheme),
                  _TitleText('• Moderate: ', textTheme),
                  _SubtitleText("Somewhat better\n", textTheme),
                  _TitleText('• Good: ', textTheme),
                  _SubtitleText("Feeling much better\n", textTheme),
                  _TitleText('• Excellent: ', textTheme),
                  _SubtitleText("Pain-free!\n", textTheme),
                ],
              ),
            ),
          ),
          Text(
            'Why this matters',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.neutralColor600,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text.rich(TextSpan(children: [
            _SubtitleText(
                'By capturing how well your painkillers work, you’re building a clear picture of what helps and what doesn’t. This information is invaluable for you and your healthcare provider to make the best decisions about your treatment and keep you on track to feeling your best. Remember, tracking your experience is key to understanding your pain management journey. Let’s make sure you’re getting the relief you deserve!',
                textTheme),
          ])),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TitleText extends TextSpan {
  _TitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.titleSmall?.copyWith(
              color: AppColors.neutralColor600,
              fontWeight: FontWeight.w700,
              height: 0),
        );
}

class _SubtitleText extends TextSpan {
  _SubtitleText(String text, TextTheme textTheme)
      : super(
          text: text,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.neutralColor600,
            height: 1.60,
          ),
        );
}
