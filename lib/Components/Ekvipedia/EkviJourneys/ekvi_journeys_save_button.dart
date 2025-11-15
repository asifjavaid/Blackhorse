import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EkviJourneysSaveButton extends StatefulWidget {
  const EkviJourneysSaveButton({super.key});

  @override
  State<EkviJourneysSaveButton> createState() => _EkviJourneysSaveButtonState();
}

class _EkviJourneysSaveButtonState extends State<EkviJourneysSaveButton> {
  bool _isLoading = false;

  Future<void> _handleTap() async {
    if (_isLoading) return; // Prevent multiple taps

    setState(() {
      _isLoading = true;
    });

    try {
      final provider = context.read<EkviJourneysProvider>();
      final lessonId = provider.lesson?.lessonId;
      final isSaved = provider.isLessonSaved;

      if (lessonId == null) return;

      if (isSaved) {
        await provider.unSaveCurrentLesson(lessonId);
      } else {
        await provider.saveCurrentLesson(lessonId);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysProvider>();
    final isSaved = provider.isLessonSaved;

    return GestureDetector(
      onTap: _isLoading ? null : _handleTap,
      child: AnimatedOpacity(
        opacity: _isLoading ? 0.6 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.neutralColor50,
            border: Border.all(color: AppColors.neutralColor50, width: 1.5),
          ),
          padding: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            isSaved ? '${AppConstant.assetIcons}save-filled.svg' : '${AppConstant.assetIcons}saveIcon.svg',
            height: 24,
            width: 24,
            fit: isSaved ? BoxFit.scaleDown : BoxFit.contain,
            colorFilter: ColorFilter.mode(
              _isLoading ? AppColors.neutralColor400 : AppColors.actionColor600,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
