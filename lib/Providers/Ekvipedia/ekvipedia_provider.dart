// ekvipedia_provider.dart
import 'package:ekvi/Models/Ekvipedia/ekvipedia_entries_model.dart';
import 'package:ekvi/Services/Ekvipedia/ekvipedia_service.dart';
import 'package:ekvi/Services/Insights/insights_service.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';

class EkvipediaProvider extends ChangeNotifier {
  final EkvipediaService _service;
  EkvipediaContentEntries latestNews = EkvipediaContentEntries();
  EkvipediaContentEntries latestEvents = EkvipediaContentEntries();
  EkvipediaContentEntries newsFromEkvi = EkvipediaContentEntries();
  EkvipediaContentEntries topPicksForYou = EkvipediaContentEntries();
  EkvipediaContentEntries articleTopics = EkvipediaContentEntries();
  EkvipediaContentEntries ekviStories = EkvipediaContentEntries();
  Map<String, SubtopicGroup> articleSubtopics = {};
  Map<String, String> topSymptomTags = {};
  bool isTopSymptomsLoading = false;
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  Map<String, String> topSymptomsLookup = {
    "Pain": "63hdLQjJlJXxZoWRTamtwR",
    "Bleeding": "7piLSh9FzSkpC6JMFtFLX5",
    "Mood": "6TCxHWjXCUzF0qXFAKePl7",
    "Stress": "4bT8sD9vuq94TShpACxblz",
    "Energy": "2jLlKXhUhddI67LpUNaJQr",
    "Nausea": "5dafMgPv2ZaO0TBgw4ALNs",
    "Fatigue": "7nnkD8aF93zUyergLPCW6p",
    "Bloating": "5RfRPZ1csVHMdrNiGAAjcb",
    "Brainfog": "6GcjnCuKo6hf3JLrttfSZ2",
    "Hormones": "4FuekOAKAsz78oVEK6LKg8",
    "Alcohol": "5PsG9Cd8smzaPuZQOCfkhx",
    "Intimacy": "1CXtm4fZipFPvBeKo47E9I",
    "Ovulation test": "25wgqhTyRDQDtbP3peToL1",
    "Pregnancy test": "dZdTYi9I3ch1LR8NyhrhZ",
  };
  String? errorMessage;

  EkvipediaProvider() : _service = EkvipediaService();

  Future<void> fetchLatestNews() async {
    final result = await _service.fetchLatestNewsFromAPI();
    result.fold(
      (error) {
        errorMessage = error.toString();
        notifyListeners();
      },
      (data) {
        latestNews = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchLatestEvents() async {
    final result = await _service.fetchLatestEventsFromAPI();
    result.fold(
      (error) {
        errorMessage = error.toString();
        notifyListeners();
      },
      (data) {
        latestEvents = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchNewsFromEkvi() async {
    final result = await _service.fetchNewsFromEkviAPI();
    result.fold(
      (error) {
        errorMessage = error.toString();
        notifyListeners();
      },
      (data) {
        newsFromEkvi = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopPicksForYou(List<String> data) async {
    List<String> tagIds = topSymptomTags.values.toList();
    final result = await _service.fetchTopPicksForYouAPI(tagIds);
    result.fold(
      (error) {
        isTopSymptomsLoading = false;
        errorMessage = error.toString();
        notifyListeners();
      },
      (data) {
        isTopSymptomsLoading = false;
        topPicksForYou = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopSymptomsFromServer() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isTopSymptomsLoading = true;
      notifyListeners();
    });

    CustomLoading.showLoadingIndicator();
    final result = await InsightsService.fetchTopSymptoms();
    result.fold(
      (error) {
        CustomLoading.hideLoadingIndicator();
        errorMessage = error.toString();
        notifyListeners();
      },
      (data) {
        topSymptomTags = {for (var symptom in data.where(topSymptomsLookup.containsKey).take(3)) symptom: topSymptomsLookup[symptom]!};

        if (topSymptomTags.isNotEmpty) {
          fetchTopPicksForYou(data);
        } else {
          isTopSymptomsLoading = false;
        }

        CustomLoading.hideLoadingIndicator();
        notifyListeners();
      },
    );
  }

  Future<void> fetchArticleTopics() async {
    final result = await _service.fetchArticleTopicsAPI();
    result.fold(
      (error) {
        errorMessage = error.toString();
        notifyListeners();
      },
      (data) {
        articleTopics = data;
        notifyListeners();
      },
    );
  }

  Future<void> fetchArticleSubTopics(String? id) async {
    if (id != null) {
      final result = await _service.fetchArticleSubTopicsAPI(id);
      result.fold(
        (error) {
          errorMessage = error.toString();
          notifyListeners();
        },
        (data) {
          articleSubtopics = EkvipediaContentEntries.groupArticlesBySubtopic(data);
          notifyListeners();
        },
      );
    }
  }

  Future<void> fetchAuthorStories() async {
    final result = await _service.fetchStoriesAPI();
    result.fold(
      (error) {
        errorMessage = error.toString();
        CustomLoading.hideLoadingIndicator();
        notifyListeners();
      },
      (data) {
        ekviStories = data;
        notifyListeners();
      },
    );
  }
}
