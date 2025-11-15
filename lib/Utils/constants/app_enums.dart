// ignore_for_file: constant_identifier_names

enum SymptomCategory {
  Body_Pain,
  Bleeding,
  Dr_Visit,
  Hormones,
  Pain_Killers,
  Alcohol,
  Ovulation_test,
  Pregnancy_test,
  Intimacy,
  Notes,
  Mood,
  Stress,
  Energy,
  Nausea,
  Fatigue,
  Bloating,
  Brain_Fog,
  Bowel_movement,
  Movement,
  Self_Care,
  Pain_Relief,
  Headache,
  Urination
}

enum PainEventsCategory {
  Existing,
  Eating,
  Toilet,
  Travel,
  Exercise,
  Sleep,
  Intimacy,
  Work,
  Headache
}

enum BodySide { Front, Back }

enum CategoryDataType { Category, Event }

enum CycleEvent { period, proliferative, ovulation, secretory }

enum PanelType { viewCycleCalendarInformation, viewSymptoms }

enum CategoryPanelMode { addOnly, edit }

enum EventPanelMode { addOnly, edit }

enum MayDayIconType {
  trackingCompleted,
  trackingIncomplete,
  periodReminder,
  contraceptionReminder,
  medicationReminder,
}

enum ButtonType { primary, secondary }

enum MultiSymptomChartType { average, max }

enum DashboardMoodPanelType { tracker, roll, bitoff, toughtime, notalone }

enum OfferType {
  freeTrial,
  discountedIntroOffer,
  regular,
}

enum CourseCtaType { Unlock, Start, Continue }

String courseCtaTitle(CourseCtaType t) {
  switch (t) {
    case CourseCtaType.Unlock:
      return 'Unlock this journey';
    case CourseCtaType.Start:
      return 'Start this Journey';
    case CourseCtaType.Continue:
      return 'Continue this Journey';
  }
}
