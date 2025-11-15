import 'package:ekvi/Models/Amplitude/amplitude_event.dart';

class EkvipediaArticleViewedEvent extends BaseEvent {
  final String articleTitle;
  final String? topic;
  final String? category;

  EkvipediaArticleViewedEvent({
    required this.articleTitle,
    this.topic,
    this.category,
  });

  @override
  String get eventName => 'ArticleViewed';

  @override
  String get description => 'Triggered when the user taps on the articles';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'Article Title': articleTitle,
        'Topic': topic,
        'Category': category,
      };
}

class EkvipediaArticleCompleteEvent extends BaseEvent {
  final String articleTitle;
  final String? topic;
  final String? category;

  EkvipediaArticleCompleteEvent({
    required this.articleTitle,
    this.topic,
    this.category,
  });

  @override
  String get eventName => 'ArticleComplete';

  @override
  String get description => 'Triggered when the users scrolls to the end';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'Article Title': articleTitle,
        'Topic': topic,
        'Category': category,
      };
}

class EkvipediaArticleExitEvent extends BaseEvent {
  final String articleTitle;
  final String? topic;
  final String? category;

  EkvipediaArticleExitEvent({
    required this.articleTitle,
    this.topic,
    this.category,
  });

  @override
  String get eventName => 'ArticleExit';

  @override
  String get description => 'Triggered when the user exit the article details screen';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'Article Title': articleTitle,
        'Topic': topic,
        'Category': category,
      };
}


class EkvipediaTopicViewedEvent extends BaseEvent {
  final String topicTitle;
  final String? category;

  EkvipediaTopicViewedEvent({
    required this.topicTitle,
    this.category,
  });

  @override
  String get eventName => 'TopicViewed';

  @override
  String get description => 'Triggered when the user taps on the topics';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'Topic Title': topicTitle,
        'Category': category,
      };
}
