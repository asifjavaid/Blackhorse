import 'package:ekvi/Components/Ekvipedia/EkviJourneys/EkviJourneysLesson/bottom_sheet_video_content_renderer.dart';
import 'package:ekvi/Models/EkviJourneys/current_course_lesson.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/ekvi_journeys_bottom_sheet_helper.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:ekvi/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EkviJourneysBottomSheetOverlay extends StatefulWidget {
  final LessonStructure? lesson;
  final CurrentCourseLesson? currentLesson;

  const EkviJourneysBottomSheetOverlay({
    super.key,
    this.lesson,
    this.currentLesson,
  });

  @override
  State<EkviJourneysBottomSheetOverlay> createState() =>
      _EkviJourneysBottomSheetOverlayState();
}

class _EkviJourneysBottomSheetOverlayState
    extends State<EkviJourneysBottomSheetOverlay> {
  final BottomSheetHelper _helper = BottomSheetHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _helper.insertOverlay(context, () => _buildOverlay());
    });
  }

  @override
  void dispose() {
    _helper.removeOverlay();
    super.dispose();
  }

  Widget _buildOverlay() {
    final lessonContent =
        widget.lesson?.lessonContent ?? widget.currentLesson?.lessonContent;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _helper.sheetHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [AppThemes.shadowUp],
          ),
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
            child: Column(
              children: [
                // Header with expand/collapse handle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.lesson?.title ?? "",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                ),
                        maxLines: 2,
                      ),
                    ),

                    // Expand/collapse button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _helper.toggleHeight(),
                        borderRadius: BorderRadius.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            _helper.isExpanded
                                ? '${AppConstant.assetIcons}upArrow.svg'
                                : '${AppConstant.assetIcons}downArrow.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 12,
                ),

                // Content area
                if (_helper.isExpanded)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (lessonContent is Map<String, dynamic> &&
                              lessonContent['nodeType'] == 'document' &&
                              lessonContent['content'] is List)
                            BottomSheetVideoContentRenderer(
                              content: List<Map<String, dynamic>>.from(
                                  lessonContent['content']),
                              assets: null,
                            )
                          else
                            const Text('No lesson content available.'),
                          const SizedBox(
                              height: 100), // Extra space for button area
                        ],
                      ),
                    ),
                  ),

                // Fixed bottom button area
                CustomButton(
                  title: "Mark as complete",
                  onPressed: () {
                    Provider.of<EkviJourneysProvider>(context, listen: false)
                        .handleLessonCompletion(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
