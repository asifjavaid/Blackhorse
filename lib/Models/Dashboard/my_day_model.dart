class MyDayModel {
  bool isDataLoaded = false;
  bool? isOnboarded;
  bool? isCycleDetail;
  CycleDetail? cycleDetail;
  String? cyclePhase;
  String? currentCycleDay;
  String? nextPeriodStartDay;
  bool? isMyDayDataExist;
  MyDayHistory? myDayHistory;
  MyDateReminders? myDateReminders;

  MyDayModel({this.isCycleDetail, this.cycleDetail, this.cyclePhase, this.currentCycleDay, this.nextPeriodStartDay, this.isMyDayDataExist, this.myDayHistory, this.myDateReminders, this.isOnboarded});

  MyDayModel.fromJson(Map<String, dynamic> json) {
    isCycleDetail = json['isCycleDetail'];
    isOnboarded = json['isOnboarded'];
    cycleDetail = json['cycleDetail'] != null ? CycleDetail.fromJson(json['cycleDetail']) : null;
    cyclePhase = json['cyclePhase'];
    currentCycleDay = json['currentCycleDay'];
    nextPeriodStartDay = json['nextPeriodStartDay'];
    isMyDayDataExist = json['isMyDayDataExist'];
    myDayHistory = json['MyDayHistory'] != null ? MyDayHistory.fromJson(json['MyDayHistory']) : null;
    myDateReminders = json['MyDateReminders'] != null ? MyDateReminders.fromJson(json['MyDateReminders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isCycleDetail'] = isCycleDetail;
    data['isOnboarded'] = isOnboarded;
    if (cycleDetail != null) {
      data['cycleDetail'] = cycleDetail!.toJson();
    }
    data['cyclePhase'] = cyclePhase;
    data['currentCycleDay'] = currentCycleDay;
    data['nextPeriodStartDay'] = nextPeriodStartDay;
    data['isMyDayDataExist'] = isMyDayDataExist;
    if (myDayHistory != null) {
      data['MyDayHistory'] = myDayHistory!.toJson();
    }
    if (myDateReminders != null) {
      data['MyDateReminders'] = myDateReminders!.toJson();
    }
    return data;
  }
}

class CycleDetail {
  String? userCycleLength;
  String? userPeriodLength;
  String? periodStartDate;
  String? periodEndDate;
  String? menstruationPhaseStart;
  String? menstruationPhaseEnd;
  String? ovulationDate;
  String? ovulationPhaseStart;
  String? ovulationPhaseEnd;
  String? follicularStartDate;
  String? follicularEndDate;
  String? lutealStartDate;
  String? lutealEndDate;

  CycleDetail(
      {this.userCycleLength,
      this.userPeriodLength,
      this.periodStartDate,
      this.periodEndDate,
      this.menstruationPhaseStart,
      this.menstruationPhaseEnd,
      this.ovulationDate,
      this.ovulationPhaseStart,
      this.ovulationPhaseEnd,
      this.follicularStartDate,
      this.follicularEndDate,
      this.lutealStartDate,
      this.lutealEndDate});

  CycleDetail.fromJson(Map<String, dynamic> json) {
    userCycleLength = json['userCycleLength'];
    userPeriodLength = json['userPeriodLength'];
    periodStartDate = json['periodStartDate'];
    periodEndDate = json['periodEndDate'];
    menstruationPhaseStart = json['menstruationPhaseStart'];
    menstruationPhaseEnd = json['menstruationPhaseEnd'];
    ovulationDate = json['ovulationDate'];
    ovulationPhaseStart = json['ovulationPhaseStart'];
    ovulationPhaseEnd = json['ovulationPhaseEnd'];
    follicularStartDate = json['follicularStartDate'];
    follicularEndDate = json['follicularEndDate'];
    lutealStartDate = json['lutealStartDate'];
    lutealEndDate = json['lutealEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCycleLength'] = userCycleLength;
    data['userPeriodLength'] = userPeriodLength;
    data['periodStartDate'] = periodStartDate;
    data['periodEndDate'] = periodEndDate;
    data['menstruationPhaseStart'] = menstruationPhaseStart;
    data['menstruationPhaseEnd'] = menstruationPhaseEnd;
    data['ovulationDate'] = ovulationDate;
    data['ovulationPhaseStart'] = ovulationPhaseStart;
    data['ovulationPhaseEnd'] = ovulationPhaseEnd;
    data['follicularStartDate'] = follicularStartDate;
    data['follicularEndDate'] = follicularEndDate;
    data['lutealStartDate'] = lutealStartDate;
    data['lutealEndDate'] = lutealEndDate;
    return data;
  }
}

class MyDayHistory {
  List<String>? afternoon;
  List<String>? night;
  List<String>? noTimeOfDay;
  List<String>? evening;
  List<String>? morning;
  List<String>? allDay;

  MyDayHistory({this.afternoon, this.night, this.noTimeOfDay, this.evening, this.morning, this.allDay});

  MyDayHistory.fromJson(Map<String, dynamic> json) {
    afternoon = json['Afternoon'] != null ? json['Afternoon'].cast<String>() : [];
    night = json['Night'] != null ? json['Night'].cast<String>() : [];
    if (json['noTimeOfDay'] != null) {
      noTimeOfDay = <String>[];
      json['noTimeOfDay'].forEach((v) {
        noTimeOfDay!.add(v);
      });
    }
    evening = json['Evening'] != null ? json['Evening'].cast<String>() : [];
    morning = json['Morning'] != null ? json['Morning'].cast<String>() : [];
    allDay = json['AllDay'] != null ? json['AllDay'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Afternoon'] = afternoon;
    data['Night'] = night;
    if (noTimeOfDay != null) {
      data['noTimeOfDay'] = noTimeOfDay!.map((v) => v).toList();
    }
    data['Evening'] = evening;
    data['Morning'] = morning;
    data['AllDay'] = allDay;
    return data;
  }
}

class Reminder {
  String? reminderType;
  String? reminderText;
  String? time;

  Reminder({this.reminderType, this.reminderText, this.time});

  Reminder.fromJson(Map<String, dynamic> json) {
    reminderType = json['reminderType'];
    reminderText = json['reminderText'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reminderType'] = reminderType;
    data['reminderText'] = reminderText;
    data['time'] = time;
    return data;
  }
}

class MyDateReminders {
  List<Reminder>? disabled;
  List<Reminder>? upcoming;

  MyDateReminders({this.disabled, this.upcoming});

  MyDateReminders.fromJson(Map<String, dynamic> json) {
    if (json['disabled'] != null) {
      disabled = [];
      json['disabled'].forEach((v) {
        disabled!.add(Reminder.fromJson(v));
      });
    }

    if (json['upcoming'] != null) {
      upcoming = [];
      json['upcoming'].forEach((v) {
        upcoming!.add(Reminder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (disabled != null) {
      data['disabled'] = disabled!.map((v) => v.toJson()).toList();
    }
    if (upcoming != null) {
      data['upcoming'] = upcoming!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
