class CycleCalendarAPI {
  bool? ifCycleExists;
  String? currentDate;
  bool isDataLoaded = false;
  List<CalendarData>? calendarData;

  CycleCalendarAPI({this.ifCycleExists, this.currentDate, this.calendarData});

  CycleCalendarAPI.fromJson(Map<String, dynamic> json) {
    ifCycleExists = json['ifCycleExists'];
    currentDate = json['currentDate'];
    if (json['calendar_data'] != null) {
      calendarData = <CalendarData>[];
      json['calendar_data'].forEach((v) {
        calendarData!.add(CalendarData.fromJson(v));
      });
    }
    isDataLoaded = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ifCycleExists'] = ifCycleExists;
    data['currentDate'] = currentDate;
    if (calendarData != null) {
      data['calendar_data'] = calendarData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalendarData {
  String? date;
  List<CycleDayEvent>? events;

  CalendarData({this.date, this.events});

  CalendarData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['events'] != null) {
      events = <CycleDayEvent>[];
      json['events'].forEach((v) {
        events!.add(CycleDayEvent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CycleDayEvent {
  String? type;
  String? status;
  String? intensity;
  String? name;

  CycleDayEvent({this.type, this.status, this.intensity, this.name});

  CycleDayEvent.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    intensity = json['intensity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['status'] = status;
    data['intensity'] = intensity;
    data['name'] = name;
    return data;
  }
}

class SelectedCycleDay {
  DateTime? date;
  List<CycleDayEvent>? events;

  SelectedCycleDay({this.date, this.events});
}

class DateChanges {
  final List<DateTime> addedDates;
  final List<DateTime> removedDates;

  DateChanges({required this.addedDates, required this.removedDates});

  factory DateChanges.fromMap(Map<String, List<DateTime>> map) {
    return DateChanges(
      addedDates: map['addedDates'] ?? [],
      removedDates: map['removedDates'] ?? [],
    );
  }

  Map<String, List<DateTime>> toMap() {
    return {
      'addedDates': addedDates,
      'removedDates': removedDates,
    };
  }
}
