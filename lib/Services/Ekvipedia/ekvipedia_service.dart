import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Services/Ekvipedia/ekvipedia_network.dart';

class EkvipediaService {
  final EkvipediaNetwork _network;

  EkvipediaService() : _network = EkvipediaNetwork();

  Future<Either<Exception, EkvipediaContentEntries>> fetchLatestNewsFromAPI() async {
    try {
      final response =
          await _network.httpGetRequest('entries', queryParams: {'content_type': 'appContent', 'fields.contentType.sys.id': '6oBqniAiowXPsQMWRxYSWH', 'include': '10', "order": "-fields.date"});
      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchLatestEventsFromAPI() async {
    try {
      // Get the current date and set time to start of the day in UTC
      final now = DateTime.now().toUtc();
      final startOfDay = DateTime.utc(now.year, now.month, now.day);
      final response =
          await _network.httpGetRequest('entries', queryParams: {'content_type': 'eventContent', 'include': '10', 'fields.date[gte]': startOfDay.toIso8601String(), "order": "-fields.date"});
      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchLatestEventsFromAPIById(String entryId) async {
    try {
      final response = await _network.httpGetRequest('entries/$entryId', queryParams: {'content_type': 'eventContent', 'include': '1', "order": "-fields.date"});

      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchNewsFromEkviAPI() async {
    try {
      final response =
          await _network.httpGetRequest('entries', queryParams: {'content_type': 'appContent', 'fields.contentType.sys.id': '2cncFsaU4f0oTipB0zQsyT', 'include': '10', "order": "-fields.date"});
      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchTopPicksForYouAPI(List<String> entryIds) async {
    try {
      final String ids = entryIds.join(',');
      final response = await _network.httpGetRequest('entries', queryParams: {
        'content_type': 'appContent',
        'fields.tags.sys.id[in]': ids,
        // 'include': '10',
      });
      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchArticleTopicsAPI() async {
    try {
      final response = await _network.httpGetRequest('entries', queryParams: {'content_type': 'topic', 'include': '10', "order": "fields.ranking"});
      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchArticleSubTopicsAPI(String topicID) async {
    try {
      final response = await _network.httpGetRequest('entries', queryParams: {
        'content_type': 'appContent',
        'fields.topic.sys.id': topicID,
        'include': '10',
      });

      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      ekvipediaEntriesModel.items = sortEntriesBySubTopicRanking(ekvipediaEntriesModel.items ?? [], ekvipediaEntriesModel.includes);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, EkvipediaContentEntries>> fetchStoriesAPI() async {
    try {
      final response =
          await _network.httpGetRequest('entries', queryParams: {'content_type': 'appContent', 'fields.contentType.sys.id': '4grT6pZzM5fFgfUn5Xm5k2', 'include': '10', "order": "-fields.date"});

      EkvipediaContentEntries ekvipediaEntriesModel = EkvipediaContentEntries.fromJson(response as Map<String, dynamic>);
      return Right(ekvipediaEntriesModel);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  List<EntryItem>? sortEntriesBySubTopicRanking(List<EntryItem> entries, Includes? includes) {
    entries.sort((a, b) {
      String? subTopicAId = a.fields['subTopic']?["sys"]?["id"] as String?;
      String? subTopicBId = b.fields['subTopic']?["sys"]?["id"] as String?;

      if (subTopicAId == null && subTopicBId == null) return 0;
      if (subTopicAId == null) return 1;
      if (subTopicBId == null) return -1;

      EntryItem? itemA = EkvipediaContentEntries.getIncludesEntryById(subTopicAId, includes);
      EntryItem? itemB = EkvipediaContentEntries.getIncludesEntryById(subTopicBId, includes);

      int? rankingA = itemA?.fields['ranking'] as int?;
      int? rankingB = itemB?.fields['ranking'] as int?;

      if (rankingA == null && rankingB == null) return 0;
      if (rankingA == null) return 1;
      if (rankingB == null) return -1;

      return rankingA.compareTo(rankingB);
    });

    return entries;
  }
}
