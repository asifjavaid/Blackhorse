class AffirmationsModel {
  final String overallReportType;
  final List<Affirmation> affirmations;
  final AffirmationsMetadata metadata;

  AffirmationsModel({
    required this.overallReportType,
    required this.affirmations,
    required this.metadata,
  });

  factory AffirmationsModel.fromJson(Map<String, dynamic> json) {
    return AffirmationsModel(
      overallReportType: json['overall_report_type'] ?? 'no_data',
      affirmations: (json['affirmations'] as List<dynamic>?)
              ?.map((affirmation) => Affirmation.fromJson(affirmation))
              .toList() ??
          [],
      metadata: AffirmationsMetadata.fromJson(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overall_report_type': overallReportType,
      'affirmations':
          affirmations.map((affirmation) => affirmation.toJson()).toList(),
      'metadata': metadata.toJson(),
    };
  }

  // Helper methods to check report type
  bool get hasWins => overallReportType == 'wins';
  bool get hasMixedResults => overallReportType == 'mixed';
  bool get hasNoWins => overallReportType == 'no_wins';
  bool get hasNoData => overallReportType == 'no_data';
}

class Affirmation {
  final String id;
  final String text;
  final String category;
  final String theme;
  final int displayOrder;

  Affirmation({
    required this.id,
    required this.text,
    required this.category,
    required this.theme,
    required this.displayOrder,
  });

  factory Affirmation.fromJson(Map<String, dynamic> json) {
    return Affirmation(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      category: json['category'] ?? '',
      theme: json['theme'] ?? '',
      displayOrder: json['display_order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'category': category,
      'theme': theme,
      'display_order': displayOrder,
    };
  }

  // Helper methods
  bool get isWinsCategory => category == 'wins';
  bool get isMixedCategory => category == 'mixed';
  bool get isNoWinsCategory => category == 'no_wins';
}

class AffirmationsMetadata {
  final int totalAvailable;
  final String category;
  final bool rotationApplied;
  final String selectionMethod;

  AffirmationsMetadata({
    required this.totalAvailable,
    required this.category,
    required this.rotationApplied,
    required this.selectionMethod,
  });

  factory AffirmationsMetadata.fromJson(Map<String, dynamic> json) {
    return AffirmationsMetadata(
      totalAvailable: json['total_available'] ?? 0,
      category: json['category'] ?? '',
      rotationApplied: json['rotation_applied'] ?? false,
      selectionMethod: json['selection_method'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_available': totalAvailable,
      'category': category,
      'rotation_applied': rotationApplied,
      'selection_method': selectionMethod,
    };
  }
}
