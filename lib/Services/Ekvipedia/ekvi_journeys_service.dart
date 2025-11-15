import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/EkviJourneys/course_structure.dart';
import 'package:ekvi/Models/EkviJourneys/failure.dart';
import 'package:ekvi/Models/EkviJourneys/get_all_saved_lessons.dart';
import 'package:ekvi/Models/EkviJourneys/journeys.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_progress.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Models/EkviJourneys/module_completion_response.dart';
import 'package:ekvi/Models/EkviJourneys/save_lesson.dart';
import 'package:ekvi/Models/EkviJourneys/sync_contentful.dart';
import 'package:ekvi/Network/api_links.dart';
import 'package:ekvi/Services/Ekvipedia/ekvipedia_network.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/core/di/user_singleton.dart';

class EkviJourneysService {
  static Future<Either<Failure, List<Journeys>>> getJourneys() async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpGetRequest(ApiLinks.journeysList(userId!));

      if (response is List) {
        final journeys = response.map((item) => Journeys.fromJson(item)).toList();
        return Right(journeys);
      } else {
        return Left(Failure('Unexpected response format while fetching journeys'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<Journeys>>> getLatestJourneys() async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpGetRequest(ApiLinks.latestJourneys(userId!));

      if (response is List) {
        final journeys = response.map((item) => Journeys.fromJson(item)).toList();
        return Right(journeys);
      } else {
        return Left(Failure('Unexpected response format while fetching latest journeys'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<Journeys>>> getExpandHorizon() async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpGetRequest(ApiLinks.expandHorizon(userId!));

      if (response is List) {
        final journeys = response.map((item) => Journeys.fromJson(item)).toList();
        return Right(journeys);
      } else {
        return Left(Failure('Unexpected response format while fetching expand horizon courses'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<Journeys>>> getRecentlyAccessed({int limit = 3}) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpGetRequest(ApiLinks.recentlyAccessed(userId!, limit: limit));

      if (response is List) {
        final journeys = response.map((item) => Journeys.fromJson(item)).toList();
        return Right(journeys);
      } else {
        return Left(Failure('Unexpected response format while fetching recently accessed courses'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, SyncContentful>> syncContentful() async {
    try {
      final response = await EkvipediaNetwork.newhttpPostRequest(
        ApiLinks.syncContentful,
        {},
      );

      if (response is Map<String, dynamic>) {
        final result = SyncContentful.fromJson(response);
        return Right(result);
      } else {
        return Left(Failure('Unexpected response format while syncing Contentful'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, CourseStructure>> getCourseStructure(String courseId) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      bool isPremium = UserManager().isPremium;

      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.courseStructure(userId!, courseId, isPremium: isPremium),
      );
      if (response is Map<String, dynamic>) {
        final course = CourseStructure.fromJson(response);
        return Right(course);
      } else {
        return Left(
          Failure('Unexpected response format while fetching course structure'),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonStructure>> getLessonStructure(String moduleId, {bool? sequential}) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.getLesson(userId!, moduleId, sequential: sequential),
      );

      if (response is Map<String, dynamic>) {
        final lesson = LessonStructure.fromJson(response);
        return Right(lesson);
      } else {
        return Left(
          Failure('Unexpected response format while fetching lesson'),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonProgress>> lessonProgress({
    required String lessonId,
    required bool isCompleted,
    required int playbackSec,
  }) async {
    try {
      final requestBody = {
        "lessonId": lessonId,
        "isCompleted": isCompleted,
        "playbackSec": playbackSec,
      };

      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpPostRequest(
        ApiLinks.lessonProgress(userId!),
        requestBody,
      );

      if (response is Map<String, dynamic>) {
        final progress = LessonProgress.fromJson(response);
        return Right(progress);
      } else {
        return Left(
          Failure('Unexpected response format while submitting lesson progress'),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonStructure>> getCurrentCourseLesson() async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');

      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.getCurrentCourseLesson(userId!),
      );

      if (response is Map<String, dynamic>) {
        final lesson = LessonStructure.fromJson(response);
        return Right(lesson);
      } else {
        return Left(
          Failure('Unexpected response format while fetching current course lesson'),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonStructure>> getPreviousLesson(
    String moduleId, {
    int? currentLessonOrder,
    bool? sequential,
  }) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.previousLesson(userId!, moduleId, currentLessonOrder: currentLessonOrder, sequential: sequential),
      );

      if (response is Map<String, dynamic>) {
        final lesson = LessonStructure.fromJson(response);
        return Right(lesson);
      } else {
        return Left(Failure('Unexpected response format while fetching previous lesson'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, dynamic>> getNextLesson(String moduleId, int currentLessonOrder, {bool? sequential}) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.nextLesson(userId!, moduleId, currentLessonOrder, sequential: sequential),
      );

      if (response is Map<String, dynamic>) {
        // Check if this is a module completion response
        if (response.containsKey('moduleCompleted')) {
          final moduleCompletion = ModuleCompletionResponse.fromJson(response);
          return Right(moduleCompletion);
        } else {
          // This is a regular lesson response
          final lesson = LessonStructure.fromJson(response);
          return Right(lesson);
        }
      } else {
        return Left(Failure('Unexpected response format while fetching next lesson'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, SaveLesson>> saveLesson(String lessonId) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpPostRequest(
        ApiLinks.saveLesson(userId!, lessonId),
        {},
      );

      if (response is Map<String, dynamic>) {
        final result = SaveLesson.fromJson(response);
        return Right(result);
      } else {
        return Left(Failure('Unexpected response format while saving lesson'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, SaveLesson>> unSaveLesson(String lessonId) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpDeleteRequest(
        ApiLinks.unSaveLesson(userId!, lessonId),
        {},
      );

      if (response is Map<String, dynamic>) {
        final result = SaveLesson.fromJson(response);
        return Right(result);
      } else {
        return Left(Failure('Unexpected response format while unsaving lesson'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, List<GetAllSavedLessons>>> getAllSavedLessons() async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.getSavedLessons(userId!),
      );

      if (response is List) {
        final lessons = response.map((item) => GetAllSavedLessons.fromJson(item)).toList();
        return Right(lessons);
      } else {
        return Left(Failure("Unexpected response format while fetching saved lessons"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonStructure>> getLessonStructureById(String lessonId) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.getLessonStructurebyId(userId!, lessonId),
      );

      if (response is Map<String, dynamic>) {
        final lesson = LessonStructure.fromJson(response);
        return Right(lesson);
      } else {
        return Left(Failure('Unexpected response format while fetching lesson by ID'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonStructure>> startCourseJourney(String courseId) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.startCourseJourney(userId!, courseId),
      );

      if (response is Map<String, dynamic>) {
        final lesson = LessonStructure.fromJson(response);
        return Right(lesson);
      } else {
        return Left(Failure('Unexpected response format while starting course journey'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  static Future<Either<Failure, LessonStructure>> continueCourseJourney(String courseId) async {
    try {
      String? userId = await SharedPreferencesHelper.getStringPrefValue(key: 'userId');
      final response = await EkvipediaNetwork.newhttpGetRequest(
        ApiLinks.continueCourseJourney(userId!, courseId),
      );

      if (response is Map<String, dynamic>) {
        final lesson = LessonStructure.fromJson(response);
        return Right(lesson);
      } else {
        return Left(Failure('Unexpected response format while continuing course journey'));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
