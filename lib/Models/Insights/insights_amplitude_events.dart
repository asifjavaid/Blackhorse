import 'package:ekvi/Models/Amplitude/amplitude_event.dart';

class InsightsAccessedEvent extends BaseEvent {
  final String accessMethod;
  final DateTime dateAccessed;
  final String userSegment;

  InsightsAccessedEvent({
    required this.accessMethod,
    required this.dateAccessed,
    required this.userSegment,
  });

  @override
  String get eventName => 'InsightsAccessed';
  @override
  String get description => 'User accesses Insights';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'accessMethod': accessMethod,
        'dateAccessed': dateAccessed.toIso8601String(),
        'userSegment': userSegment,
      };
}

class InsightsToggleViewEvent extends BaseEvent {
  final String symptom;
  final String timeFrame;

  InsightsToggleViewEvent({
    required this.symptom,
    required this.timeFrame,
  });

  @override
  String get eventName => 'InsightsToggleView';
  @override
  String get description => 'User toggles view for insights';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'symptom': symptom,
        'timeFrame': timeFrame,
      };
}
