class WellnessWeeklyPopupResponse {
  final bool shouldShowPopup;
  final WellnessWeeklyPopupData? popupData;
  final WellnessWeeklyMetadata? metadata;

  WellnessWeeklyPopupResponse({
    required this.shouldShowPopup,
    this.popupData,
    this.metadata,
  });

  factory WellnessWeeklyPopupResponse.fromJson(Map<String, dynamic> json) {
    return WellnessWeeklyPopupResponse(
      shouldShowPopup: json['should_show_popup'] ?? false,
      popupData: json['popup_data'] != null
          ? WellnessWeeklyPopupData.fromJson(json['popup_data'])
          : null,
      metadata: json['metadata'] != null
          ? WellnessWeeklyMetadata.fromJson(json['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'should_show_popup': shouldShowPopup,
      'popup_data': popupData?.toJson(),
      'metadata': metadata?.toJson(),
    };
  }
}

class WellnessWeeklyPopupData {
  final String title;
  final String message;
  final String buttonText;
  final bool reportAvailable;
  final String weekStartDate;

  WellnessWeeklyPopupData({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.reportAvailable,
    required this.weekStartDate,
  });

  factory WellnessWeeklyPopupData.fromJson(Map<String, dynamic> json) {
    return WellnessWeeklyPopupData(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      buttonText: json['button_text'] ?? '',
      reportAvailable: json['report_available'] ?? false,
      weekStartDate: json['week_start_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'button_text': buttonText,
      'report_available': reportAvailable,
      'week_start_date': weekStartDate,
    };
  }
}

class WellnessWeeklyMetadata {
  final String? lastReportGenerated;
  final String? lastPopupShown;
  final bool popupDismissed;

  WellnessWeeklyMetadata({
    this.lastReportGenerated,
    this.lastPopupShown,
    required this.popupDismissed,
  });

  factory WellnessWeeklyMetadata.fromJson(Map<String, dynamic> json) {
    return WellnessWeeklyMetadata(
      lastReportGenerated: json['last_report_generated'],
      lastPopupShown: json['last_popup_shown'],
      popupDismissed: json['popup_dismissed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_report_generated': lastReportGenerated,
      'last_popup_shown': lastPopupShown,
      'popup_dismissed': popupDismissed,
    };
  }
}
