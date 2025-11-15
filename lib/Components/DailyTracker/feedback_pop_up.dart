import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:flutter/material.dart';

class FeatureFeedback extends StatefulWidget {
  final SymptomFeedback feedback;
  final void Function(bool) callback;

  const FeatureFeedback({super.key, required this.feedback, required this.callback});

  @override
  // ignore: library_private_types_in_public_api
  _FeatureFeedbackState createState() => _FeatureFeedbackState();
}

class _FeatureFeedbackState extends State<FeatureFeedback> {
  bool _isFeedbackGiven = false;
  bool _isThumbUpPressed = false;
  bool _isThumbDownPressed = false;

  void _handleFeedback(bool isPositive) async {
    widget.callback(isPositive);
    setState(() {
      if (isPositive) {
        _isThumbUpPressed = true;
        _isThumbDownPressed = false;
      } else {
        _isThumbDownPressed = true;
        _isThumbUpPressed = false;
      }
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isFeedbackGiven = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (_isFeedbackGiven) {
      return (widget.feedback.isFeedbackSaved != null) && (widget.feedback.isFeedbackSaved == false) && ((widget.feedback.impressionCount ?? 0) < 5)
          ? Container(
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 24,
              ),
              decoration: ShapeDecoration(
                color: AppColors.primaryColor400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Row(children: [
                    Text(
                      'Thank you',
                      textAlign: TextAlign.start,
                      style: textTheme.displaySmall,
                    ),
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    Text(
                      'We appreciate your feedback',
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ]),
                ],
              ),
            )
          : const SizedBox.shrink();
    }

    return (widget.feedback.isFeedbackSaved != null) && (widget.feedback.isFeedbackSaved == false) && ((widget.feedback.impressionCount ?? 0) < 5)
        ? Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 24,
            ),
            decoration: ShapeDecoration(
              color: AppColors.primaryColor400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Feature Alert',
                  textAlign: TextAlign.start,
                  style: textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'This is our first version of the this feature. We know it’s not perfect yet, but would love to know how we can turn it into one!',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Is it a keeper?',
                  style: textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: _isThumbUpPressed ? AppColors.secondaryColor600 : AppColors.whiteColor, borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () => _handleFeedback(true),
                            icon: Icon(
                              AppCustomIcons.tumbs_up,
                              color: _isThumbUpPressed ? AppColors.whiteColor : null,
                            )),
                      ),
                      const SizedBox(width: 64),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: _isThumbDownPressed ? AppColors.secondaryColor600 : AppColors.whiteColor, borderRadius: BorderRadius.circular(50)),
                        child: IconButton(onPressed: () => _handleFeedback(false), icon: Icon(AppCustomIcons.thumbs_down, color: _isThumbDownPressed ? Colors.white : null)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
