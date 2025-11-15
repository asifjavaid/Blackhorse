import 'package:ekvi/Models/EkviJourneys/course_structure.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/Models/EkviJourneys/failure.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Services/Ekvipedia/ekvi_journeys_service.dart';
import 'package:provider/provider.dart';

class EkviJourneysCourseProvider with ChangeNotifier {
  // Course Structure Fields
  String? _courseId;
  String? _imageUrl;
  String? _title;
  String? _accessType; // 'free' | 'premium'
  List<Map<String, dynamic>> _description = [];
  Map<String, dynamic>? _rawDescription;
  int? _totalModules;
  int? _totalDuration;
  List<String> _tags = [];
  List<Map<String, dynamic>> _modules = [];

  // Host Info
  String? _hostName;
  String? _hostBio;
  String? _hostDescription;
  String? _hostProfilePicture;
  Map<String, String> _hostSocials = {};

  // Lesson
  LessonStructure? _lesson;

  // Loading/Error State
  bool _isLoading = false;
  String? _error;

  // Getters
  String? get courseId => _courseId;
  String? get imageUrl => _imageUrl;
  String? get title => _title;
  String? get accessType => _accessType;
  List<Map<String, dynamic>> get description => _description;
  Map<String, dynamic>? get descriptionRaw => _rawDescription;
  int? get totalModules => _totalModules;
  int? get totalDuration => _totalDuration;
  List<String> get tags => _tags;
  List<Map<String, dynamic>> get modules => _modules;

  String? get hostName => _hostName;
  String? get hostBio => _hostBio;
  String? get hostDescription => _hostDescription;
  String? get hostProfilePicture => _hostProfilePicture;
  Map<String, String> get hostSocials => _hostSocials;

  LessonStructure? get lesson => _lesson;
  bool get isLoading => _isLoading;
  String? get error => _error;

  CourseCtaType computePrimaryCta(EkviJourneysProvider jp) {
    final cid = _courseId;
    if (cid == null) return CourseCtaType.Start;

    if (!jp.isUserPremium && jp.isCoursePremium(cid)) {
      return CourseCtaType.Unlock;
    }

    final pct = jp.completionPctFor(cid);
    return (pct <= 0) ? CourseCtaType.Start : CourseCtaType.Continue;
  }

  Future<void> handlePrimaryCta(EkviJourneysProvider jp) async {
    final cta = computePrimaryCta(jp);
    final courseId = _courseId;

    if (courseId == null) {
      _error = 'Course ID not available';
      notifyListeners();
      return;
    }

    switch (cta) {
      case CourseCtaType.Unlock:
        AppNavigation.navigateTo(AppRoutes.subscribe,
            arguments: ScreenArguments(navigationCallback: () async {
          // First refresh the provider to update course access status
          await Provider.of<EkviJourneysProvider>(AppNavigation.currentContext!,
                  listen: false)
              .refreshAllData();
          // Also refresh the course structure to update access type
          await refreshCourseStructure();
          AppNavigation.popUntilAndNavigateTo(
            AppRoutes.sideNavManager, // pop until side nav manager
            AppRoutes.ekviJourneysCourse, // navigate to course screen
            arguments: ScreenArguments(courseId: courseId),
          );
        }));
        return;

      case CourseCtaType.Start:
        // Navigate to lesson screen with start course journey flag
        AppNavigation.navigateTo(
          AppRoutes.ekviJourneysLesson,
          arguments: ScreenArguments(
            courseId: courseId,
            isStartCourseJourney: true,
          ),
        );
        return;

      case CourseCtaType.Continue:
        // Navigate to lesson screen with continue course journey flag
        AppNavigation.navigateTo(
          AppRoutes.ekviJourneysLesson,
          arguments: ScreenArguments(
            courseId: courseId,
            isContinueCourseJourney: true,
          ),
        );
        return;
    }
  }

  // Fetch Course Structure from API
  Future<void> fetchCourseStructure(String courseId,
      {bool resetCourseState = true}) async {
    if (resetCourseState) _resetCourseState();
    _error = null;
    _isLoading = true;
    notifyListeners();

    final result = await EkviJourneysService.getCourseStructure(courseId);

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _resetCourseState();
      },
      (CourseStructure data) {
        try {
          _courseId = data.courseId;
          _imageUrl = data.imageUrl;
          _title = data.title;
          _totalModules = data.totalModules;
          _totalDuration = data.totalDuration;

          // ✅ Bind access type from API; default to 'free'
          _accessType = (data.accessType ?? 'free').toLowerCase().trim();

          _tags = List<String>.from(data.tags ?? []);
          _modules = (data.modules ?? []).map((m) => m.toJson()).toList();

          // Capture full raw description
          final desc = data.description;
          if (desc is Map<String, dynamic>) {
            _rawDescription = desc;
            final content = desc['content'];
            if (content is List) {
              _description = content.whereType<Map<String, dynamic>>().toList();
            } else {
              _description = [];
            }
          } else {
            _rawDescription = null;
            _description = [];
          }

          // Host
          final host = data.host;
          if (host != null) {
            _hostName = host.name;
            _hostBio = host.bio;
            _hostDescription = host.description;
            _hostProfilePicture = host.profilePicture;
            _hostSocials = {};
            if (host.socials != null) {
              host.socials!.toJson().forEach((key, value) {
                if (value is String) {
                  _hostSocials[key] = value;
                }
              });
            }
          } else {
            _hostName = null;
            _hostBio = null;
            _hostDescription = null;
            _hostProfilePicture = null;
            _hostSocials = {};
          }
        } catch (e) {
          _error = 'Failed to parse course data.';
          _resetCourseState();
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void _resetCourseState() {
    _courseId = null;
    _imageUrl = null;
    _title = null;
    _description = [];
    _rawDescription = null;
    _totalModules = null;
    _totalDuration = null;
    _accessType = null;
    _tags = [];
    _modules = [];
    _hostName = null;
    _hostBio = null;
    _hostDescription = null;
    _hostProfilePicture = null;
    _hostSocials = {};
    _lesson = null;
  }

  Future<void> refreshCourseStructure() async {
    final courseId = _courseId;
    if (courseId != null) {
      await fetchCourseStructure(courseId, resetCourseState: false);
    }
  }
}
