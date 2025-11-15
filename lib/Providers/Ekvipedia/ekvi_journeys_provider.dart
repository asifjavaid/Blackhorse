import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/EkviJourneys/failure.dart';
import 'package:ekvi/Models/EkviJourneys/get_all_saved_lessons.dart';
import 'package:ekvi/Models/EkviJourneys/journeys.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_progress.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Models/EkviJourneys/module_completion_response.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/Ekvipedia/ekvi_journeys_service.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/Models/EkviJourneys/save_lesson.dart';

class EkviJourneysProvider with ChangeNotifier {
  Includes? assets;
  List<Journeys> _journeys = [];
  List<Journeys> _expandHorizonJourneys = [];
  List<Journeys> _recentlyAccessedJourneys = [];
  LessonStructure? _lesson;
  LessonStructure? _currentCourseLesson;
  LessonProgress? _lessonProgress;
  SaveLesson? _saveLesson;
  ModuleCompletionResponse? _moduleCompletionResponse;
  List<GetAllSavedLessons> _getAllSavedLessons = [];

  bool _isLoading = false;
  String? _error;

  List<Journeys> get journeys => _journeys;
  List<Journeys> get expandHorizonJourneys => _expandHorizonJourneys;
  List<Journeys> get recentlyAccessedJourneys => _recentlyAccessedJourneys;
  LessonStructure? get lesson => _lesson;
  LessonStructure? get currentCourseLesson => _currentCourseLesson; // Getter for dashboard
  LessonProgress? get lessonProgress => _lessonProgress;
  SaveLesson? get saveLesson => _saveLesson;
  ModuleCompletionResponse? get moduleCompletionResponse => _moduleCompletionResponse;
  List<GetAllSavedLessons> get savedLessons => _getAllSavedLessons;

  bool get isLessonSaved => _lesson?.isSaved ?? false;

  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get isUserPremium => UserManager().isPremium;
  bool isCoursePremium(String courseId) => accessTypeFor(courseId) == 'premium';

  int completionPctFor(String courseId) {
    try {
      // Search in both journeys and expandHorizonJourneys
      final allJourneys = [..._journeys, ..._expandHorizonJourneys];
      return allJourneys.firstWhere((j) => j.courseId == courseId).completionPct ?? 0;
    } catch (_) {
      return 0;
    }
  }

  String accessTypeFor(String courseId) {
    try {
      // Search in both journeys and expandHorizonJourneys
      final allJourneys = [..._journeys, ..._expandHorizonJourneys];
      final t = allJourneys.firstWhere((j) => j.courseId == courseId).accessType;
      return (t ?? 'free').toLowerCase().trim();
    } catch (_) {
      return 'free';
    }
  }

  Future<void> fetchLatestJourneys() async {
    _error = null;
    notifyListeners();

    final result = await EkviJourneysService.getLatestJourneys();

    result.fold(
      (Failure failure) {
        _error = failure.message;
      },
      (List<Journeys> data) {
        _journeys = data;
      },
    );
    notifyListeners();
  }

  Future<void> fetchExpandHorizon() async {
    _error = null;
    notifyListeners();

    final result = await EkviJourneysService.getExpandHorizon();

    result.fold(
      (Failure failure) {
        _error = failure.message;
      },
      (List<Journeys> data) {
        _expandHorizonJourneys = data;
      },
    );
    notifyListeners();
  }

  Future<void> fetchRecentlyAccessed({int limit = 3}) async {
    _error = null;
    notifyListeners();

    final result = await EkviJourneysService.getRecentlyAccessed(limit: limit);

    result.fold(
      (Failure failure) {
        _error = failure.message;
      },
      (List<Journeys> data) {
        _recentlyAccessedJourneys = data;
      },
    );
    notifyListeners();
  }

  Future<void> syncContentfulData() async {
    final result = await EkviJourneysService.syncContentful();

    result.fold(
      (failure) {
        debugPrint('Contentful sync failed: ${failure.message}');
      },
      (response) {
        debugPrint('Contentful sync successful: ${response.message}');
      },
    );
  }

  Future<void> fetchLesson(String moduleId, {bool? sequential}) async {
    _error = null;
    _isLoading = true;
    _moduleCompletionResponse = null; // Clear module completion when fetching new lesson
    notifyListeners();

    final result = await EkviJourneysService.getLessonStructure(moduleId, sequential: sequential);

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _lesson = null;
      },
      (LessonStructure data) {
        _lesson = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> submitLessonProgress({
    required String lessonId,
    required bool isCompleted,
    required int playbackSec,
  }) async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    final result = await EkviJourneysService.lessonProgress(
      lessonId: lessonId,
      isCompleted: isCompleted,
      playbackSec: playbackSec,
    );

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _lessonProgress = null;
      },
      (LessonProgress data) {
        _error = null;
        _lessonProgress = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCurrentCourseLesson() async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    final result = await EkviJourneysService.getCurrentCourseLesson();

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _currentCourseLesson = null;
        _lesson = null;
      },
      (LessonStructure data) {
        _currentCourseLesson = data;
        _lesson = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPreviousLesson(String moduleId, {int? currentLessonOrder, bool? sequential}) async {
    _error = null;
    _isLoading = true;
    _moduleCompletionResponse = null; // Clear module completion when fetching new lesson
    notifyListeners();

    final result = await EkviJourneysService.getPreviousLesson(moduleId, currentLessonOrder: currentLessonOrder, sequential: sequential);

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _lesson = null;
      },
      (LessonStructure data) {
        _lesson = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNextLesson(String moduleId, int currentLessonOrder, {bool? sequential}) async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    final result = await EkviJourneysService.getNextLesson(moduleId, currentLessonOrder, sequential: sequential);

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _lesson = null;
        _moduleCompletionResponse = null;
      },
      (dynamic data) {
        if (data is LessonStructure) {
          _lesson = data;
          _moduleCompletionResponse = null;
        } else if (data is ModuleCompletionResponse) {
          _moduleCompletionResponse = data;
          _lesson = null;
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> handleLessonCompletion(BuildContext context) async {
    final lessonId = _lesson?.lessonId;
    if (lessonId == null) return;

    await submitLessonProgress(
      lessonId: lessonId,
      isCompleted: true,
      playbackSec: 100,
    );

    if (_error != null) {
      Future.microtask(() {
        HelperFunctions.showNotification(AppNavigation.currentContext!, _error!);
      });
      return;
    }

    final moduleId = _lesson?.moduleID;
    final lessonOrder = _lesson?.lessonOrder;
    if (moduleId == null || lessonOrder == null) return;

    // Use sequential=true for lesson completion flow
    await fetchNextLesson(moduleId, lessonOrder, sequential: true);

    // Check if we got a module completion response
    if (_moduleCompletionResponse != null) {
      // Only fetch journeys to update progress, don't fetch current course lesson
      // as it would clear the module completion response
      await fetchLatestJourneys();
    }
  }

  Future<void> saveCurrentLesson(String lessonId) async {
    _error = null;
    notifyListeners();
    final result = await EkviJourneysService.saveLesson(lessonId);

    result.fold(
      (failure) {
        _error = failure.message;
        _saveLesson = null;
        notifyListeners();
      },
      (SaveLesson data) {
        _saveLesson = data;
        _error = null;
        // Update the lesson's isSaved status by creating a new lesson object
        if (_lesson != null) {
          _lesson = LessonStructure(
            lessonId: _lesson!.lessonId,
            title: _lesson!.title,
            moduleTitle: _lesson!.moduleTitle,
            lessonType: _lesson!.lessonType,
            lessonOrder: _lesson!.lessonOrder,
            mediaUrl: _lesson!.mediaUrl,
            featuredImageUrl: _lesson!.featuredImageUrl,
            moduleFeaturedImageUrl: _lesson!.moduleFeaturedImageUrl,
            lessonContent: _lesson!.lessonContent,
            lessonReferences: _lesson!.lessonReferences,
            isCompleted: _lesson!.isCompleted,
            isSaved: true, // Updated save status
            playbackSec: _lesson!.playbackSec,
            totalLessons: _lesson!.totalLessons,
            moduleOrder: _lesson!.moduleOrder,
            moduleID: _lesson!.moduleID,
            totalModules: _lesson!.totalModules,
          );
        }
        notifyListeners();
      },
    );
  }

  Future<void> unSaveCurrentLesson(String lessonId) async {
    _error = null;
    notifyListeners();

    final result = await EkviJourneysService.unSaveLesson(lessonId);

    result.fold(
      (failure) {
        _error = failure.message;
        _saveLesson = null;
      },
      (SaveLesson data) {
        _saveLesson = data;
        // Update the lesson's isSaved status by creating a new lesson object
        if (_lesson != null) {
          _lesson = LessonStructure(
            lessonId: _lesson!.lessonId,
            title: _lesson!.title,
            moduleTitle: _lesson!.moduleTitle,
            lessonType: _lesson!.lessonType,
            lessonOrder: _lesson!.lessonOrder,
            mediaUrl: _lesson!.mediaUrl,
            featuredImageUrl: _lesson!.featuredImageUrl,
            moduleFeaturedImageUrl: _lesson!.moduleFeaturedImageUrl,
            lessonContent: _lesson!.lessonContent,
            lessonReferences: _lesson!.lessonReferences,
            isCompleted: _lesson!.isCompleted,
            isSaved: false, // Updated save status
            playbackSec: _lesson!.playbackSec,
            totalLessons: _lesson!.totalLessons,
            moduleOrder: _lesson!.moduleOrder,
            moduleID: _lesson!.moduleID,
            totalModules: _lesson!.totalModules,
          );
        }
        _error = null;
      },
    );

    notifyListeners();
  }

  Future<void> fetchAllSavedLessons() async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    final result = await EkviJourneysService.getAllSavedLessons();

    result.fold(
      (failure) {
        _error = failure.message;
        _getAllSavedLessons = [];
      },
      (data) {
        _getAllSavedLessons = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void extractAndStoreAssetsFromLesson() {
    final lessonContent = _lesson?.lessonContent;

    if (lessonContent is Map<String, dynamic> && lessonContent['nodeType'] == 'document' && lessonContent['content'] is List) {
      final List<Map<String, dynamic>> contentList = List<Map<String, dynamic>>.from(lessonContent['content']);

      final List<Asset> extractedAssets = [];
      final List<EntryItem> extractedEntries = [];

      for (final node in contentList) {
        if (node['nodeType'] == 'embedded-asset-block') {
          final target = node['data']?['target'];
          if (target != null && target['sys'] != null && target['fields'] != null && target['metadata'] != null) {
            try {
              final asset = Asset.fromJson(target);
              extractedAssets.add(asset);
            } catch (e) {
              debugPrint('❌ Failed to parse asset: $e');
            }
          }
        } else if (node['nodeType'] == 'embedded-entry-block' || node['nodeType'] == 'embedded-entry-inline') {
          final target = node['data']?['target'];
          if (target != null && target['sys'] != null && target['fields'] != null && target['metadata'] != null) {
            try {
              final entry = EntryItem.fromJson(target);
              extractedEntries.add(entry);
            } catch (e) {
              debugPrint('❌ Failed to parse entry: $e');
            }
          }
        }
      }
      assets = Includes(assets: extractedAssets, entries: extractedEntries);
      notifyListeners();
    }
  }

  void ensureAssetsExtracted() {
    if (assets != null || _lesson == null) return;

    final rawContent = _lesson?.lessonContent;
    if (rawContent is Map<String, dynamic> && rawContent['content'] is List && rawContent['nodeType'] == 'document') {
      final List<Map<String, dynamic>> contentList = List<Map<String, dynamic>>.from(rawContent['content']);

      final extractedAssets = (contentList.where((node) => node['nodeType'] == 'embedded-asset-block' && node['data']?['target']?['fields'] != null).map((node) => {
            "metadata": <String, dynamic>{},
            "sys": node['data']['target']['sys'],
            "fields": node['data']['target']['fields'],
          })).toList();

      final extractedEntries =
          (contentList.where((node) => (node['nodeType'] == 'embedded-entry-block' || node['nodeType'] == 'embedded-entry-inline') && node['data']?['target']?['fields'] != null).map((node) => {
                "metadata": <String, dynamic>{},
                "sys": node['data']['target']['sys'],
                "fields": node['data']['target']['fields'],
              })).toList();

      assets = Includes.fromJson({"Asset": extractedAssets, "Entry": extractedEntries});
      notifyListeners();
    }
  }

  Includes? extractAssetsFromModuleCompletionContent() {
    final moduleCompletion = _moduleCompletionResponse;
    if (moduleCompletion?.moduleCompletionContent == null) return null;

    final content = moduleCompletion!.moduleCompletionContent!;
    if (content['content'] is! List || content['nodeType'] != 'document') {
      return null;
    }

    final List<Map<String, dynamic>> contentList = List<Map<String, dynamic>>.from(content['content']);

    final extractedAssets = (contentList.where((node) => node['nodeType'] == 'embedded-asset-block' && node['data']?['target']?['fields'] != null).map((node) => {
          "metadata": <String, dynamic>{},
          "sys": node['data']['target']['sys'],
          "fields": node['data']['target']['fields'],
        })).toList();

    final extractedEntries =
        (contentList.where((node) => (node['nodeType'] == 'embedded-entry-block' || node['nodeType'] == 'embedded-entry-inline') && node['data']?['target']?['fields'] != null).map((node) => {
              "metadata": <String, dynamic>{},
              "sys": node['data']['target']['sys'],
              "fields": node['data']['target']['fields'],
            })).toList();

    return Includes.fromJson({"Asset": extractedAssets, "Entry": extractedEntries});
  }

  List<Map<String, dynamic>>? getLessonContentList() {
    final rawContent = _lesson?.lessonContent;
    if (rawContent is Map<String, dynamic> && rawContent['content'] is List && rawContent['nodeType'] == 'document') {
      return List<Map<String, dynamic>>.from(rawContent['content']);
    }
    return null;
  }

  Future<void> fetchLessonById(String lessonId) async {
    _error = null;
    _isLoading = true;
    _lesson = null;
    _moduleCompletionResponse = null; // Clear module completion when fetching new lesson
    notifyListeners();

    final result = await EkviJourneysService.getLessonStructureById(lessonId);

    result.fold(
      (Failure failure) {
        _error = failure.message;
      },
      (LessonStructure data) {
        _lesson = data;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshAllData() async {
    await Future.wait([
      fetchLatestJourneys(),
      fetchExpandHorizon(),
      fetchRecentlyAccessed(),
      fetchCurrentCourseLesson(),
    ]);
  }

  Future<void> startCourseJourney(String courseId) async {
    _error = null;
    _isLoading = true;
    _lesson = null;
    _moduleCompletionResponse = null; // Clear module completion when starting new journey
    notifyListeners();

    final result = await EkviJourneysService.startCourseJourney(courseId);

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _lesson = null;
      },
      (LessonStructure data) {
        _lesson = data;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> continueCourseJourney(String courseId) async {
    _error = null;
    _isLoading = true;
    _lesson = null;
    _moduleCompletionResponse = null; // Clear module completion when continuing journey
    notifyListeners();

    final result = await EkviJourneysService.continueCourseJourney(courseId);

    result.fold(
      (Failure failure) {
        _error = failure.message;
        _lesson = null;
      },
      (LessonStructure data) {
        _lesson = data;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
