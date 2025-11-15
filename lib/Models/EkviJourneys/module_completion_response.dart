class ModuleCompletionResponse {
  final bool moduleCompleted;
  final String moduleId;
  final String moduleTitle;
  final NextModuleInfo? nextModuleInfo;
  final bool isJourneyComplete;
  final Map<String, dynamic>? moduleCompletionContent;

  ModuleCompletionResponse({
    required this.moduleCompleted,
    required this.moduleId,
    required this.moduleTitle,
    this.nextModuleInfo,
    required this.isJourneyComplete,
    this.moduleCompletionContent,
  });

  factory ModuleCompletionResponse.fromJson(Map<String, dynamic> json) {
    return ModuleCompletionResponse(
      moduleCompleted: json['moduleCompleted'] ?? false,
      moduleId: json['moduleId'] ?? '',
      moduleTitle: json['moduleTitle'] ?? '',
      nextModuleInfo: json['nextModuleInfo'] != null ? NextModuleInfo.fromJson(json['nextModuleInfo']) : null,
      isJourneyComplete: json['isJourneyComplete'] ?? false,
      moduleCompletionContent: json['moduleCompletionContent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moduleCompleted': moduleCompleted,
      'moduleId': moduleId,
      'moduleTitle': moduleTitle,
      'nextModuleInfo': nextModuleInfo?.toJson(),
      'isJourneyComplete': isJourneyComplete,
      'moduleCompletionContent': moduleCompletionContent,
    };
  }
}

class NextModuleInfo {
  final String nextModuleId;
  final String nextModuleTitle;
  final String firstLessonId;

  NextModuleInfo({
    required this.nextModuleId,
    required this.nextModuleTitle,
    required this.firstLessonId,
  });

  factory NextModuleInfo.fromJson(Map<String, dynamic> json) {
    return NextModuleInfo(
      nextModuleId: json['nextModuleId'] ?? '',
      nextModuleTitle: json['nextModuleTitle'] ?? '',
      firstLessonId: json['firstLessonId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nextModuleId': nextModuleId,
      'nextModuleTitle': nextModuleTitle,
      'firstLessonId': firstLessonId,
    };
  }
}
