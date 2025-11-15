import 'package:ekvi/Components/Ekvipedia/EkviJourneys/ekvi_journeys_save_button.dart';
import 'package:ekvi/Models/EkviJourneys/current_course_lesson.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_video_player_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class EkviJourneysVideoPlayer extends StatefulWidget {
  final LessonStructure? lesson;
  final CurrentCourseLesson? currentLesson;

  const EkviJourneysVideoPlayer({
    super.key,
    this.lesson,
    this.currentLesson,
  });

  @override
  State<EkviJourneysVideoPlayer> createState() =>
      _EkviJourneysVideoPlayerState();
}

class _EkviJourneysVideoPlayerState extends State<EkviJourneysVideoPlayer> {
  late EkviJourneysVideoPlayerProvider _videoProvider;

  @override
  void initState() {
    super.initState();
    final url = widget.lesson?.mediaUrl ?? widget.currentLesson?.mediaUrl ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _videoProvider = context.read<EkviJourneysVideoPlayerProvider>();
      if (url.isNotEmpty) {
        _videoProvider.initialize(url);
      }
    });
  }

  @override
  void dispose() {
    _videoProvider.disposePlayer();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = d.inHours;
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  bool _showSpinner(VideoPlayerController? c) {
    if (c == null) return true;
    final v = c.value;
    if (!v.isInitialized) return true;
    if (v.isBuffering) return true;
    if (!v.isPlaying && v.position == Duration.zero) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysVideoPlayerProvider>();
    final ctrl = provider.controller;

    final total = provider.duration.inSeconds;
    final max = total > 0 ? total.toDouble() : 1.0;
    final current = provider.position.inSeconds;
    final value = current.clamp(0, total).toDouble();

    return Column(
      children: [
        // Progress + time (kept same heights as you had)
        Column(
          children: [
            Slider(
              value: total == 0 ? 0 : value,
              max: max,
              onChanged: (v) => provider.seekTo(Duration(seconds: v.toInt())),
              activeColor: AppColors.primaryColor600,
              inactiveColor: AppColors.secondaryColor500,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(provider.position)),
                  Text(
                      "-${_formatDuration(provider.duration - provider.position)}"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Video area fills what's available from parent (the sliver gives a bounded height)
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await provider.playPause();
              if (mounted) setState(() {}); // re-evaluate spinner right away
            },
            onDoubleTap: provider.toggleControlsVisibility,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: Stack(
                  children: [
                    // Video
                    if (ctrl != null && ctrl.value.isInitialized)
                      Positioned.fill(
                        child: FittedBox(
                          fit: BoxFit
                              .cover, // no distortion, letterbox if needed
                          child: SizedBox(
                            width: ctrl.value.size.width,
                            height: ctrl.value.size.height,
                            child: VideoPlayer(ctrl),
                          ),
                        ),
                      )
                    else
                      const Positioned.fill(
                          child: ColoredBox(color: Colors.black)),

                    // Loader until ready/playing
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          opacity: _showSpinner(ctrl) ? 1 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // Save button
                    const Positioned(
                      top: 20,
                      right: 20,
                      child: EkviJourneysSaveButton(),
                    ),

                    // Overlay controls
                    if (provider.showControls &&
                        provider.isVideoReady &&
                        ctrl != null)
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: false,
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: provider.jumpBackward,
                                    child: SvgPicture.asset(
                                      '${AppConstant.assetIcons}secBack.svg',
                                      width: 40,
                                      height: 40,
                                      color: AppColors.neutralColor100
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(width: 60),
                                  GestureDetector(
                                    onTap: provider.playPause,
                                    child: SizedBox(
                                      width: 72,
                                      height: 72,
                                      child: Icon(
                                        provider.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: AppColors.neutralColor100
                                            .withOpacity(0.9),
                                        size: 72,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 60),
                                  GestureDetector(
                                    onTap: provider.jumpForward,
                                    child: SvgPicture.asset(
                                      '${AppConstant.assetIcons}secForward.svg',
                                      width: 40,
                                      height: 40,
                                      color: AppColors.neutralColor100
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
