class BodyPartsByDate {
  CompletedParts? completedParts;

  BodyPartsByDate({this.completedParts});

  BodyPartsByDate.fromJson(Map<String, dynamic> json) {
    completedParts = json['completedParts'] != null ? CompletedParts.fromJson(json['completedParts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (completedParts != null) {
      data['completedParts'] = completedParts!.toJson();
    }
    return data;
  }
}

class CompletedParts {
  List<EventData>? evening;
  List<EventData>? allDay;
  List<EventData>? night;
  List<EventData>? morning;
  List<EventData>? afternoon;

  CompletedParts({this.evening, this.allDay, this.night, this.morning, this.afternoon});

  CompletedParts.fromJson(Map<String, dynamic> json) {
    if (json['Evening'] != null) {
      evening = <EventData>[];
      json['Evening'].forEach((v) {
        evening!.add(EventData.fromJson(v));
      });
    }
    if (json['All Day'] != null) {
      allDay = <EventData>[];
      json['All Day'].forEach((v) {
        allDay!.add(EventData.fromJson(v));
      });
    }
    if (json['Night'] != null) {
      night = <EventData>[];
      json['Night'].forEach((v) {
        night!.add(EventData.fromJson(v));
      });
    }
    if (json['Morning'] != null) {
      morning = <EventData>[];
      json['Morning'].forEach((v) {
        morning!.add(EventData.fromJson(v));
      });
    }
    if (json['Afternoon'] != null) {
      afternoon = <EventData>[];
      json['Afternoon'].forEach((v) {
        afternoon!.add(EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (evening != null) {
      data['Evening'] = evening!.map((v) => v.toJson()).toList();
    }
    if (allDay != null) {
      data['All Day'] = allDay!.map((v) => v.toJson()).toList();
    }
    if (night != null) {
      data['Night'] = night!.map((v) => v.toJson()).toList();
    }
    if (morning != null) {
      data['Morning'] = morning!.map((v) => v.toJson()).toList();
    }
    if (afternoon != null) {
      data['Afternoon'] = afternoon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventData {
  List<String>? feeling;
  int? howBad;
  String? timeOfDay;
  String? bodyPart;
  String? name;
  String? date;
  List<PartOfLifeEffect>? partOfLifeEffect;
  List<String>? painFeelingTime;
  String? userId;
  String? id;
  List<String>? type;

  EventData({this.feeling, this.howBad, this.timeOfDay, this.bodyPart, this.name, this.date, this.partOfLifeEffect, this.painFeelingTime, this.userId, this.id, this.type});

  EventData.fromJson(Map<String, dynamic> json) {
    feeling = json['feeling'].cast<String>();
    howBad = json['howBad'];
    timeOfDay = json['timeOfDay'];
    bodyPart = json['bodyPart'];
    name = json['name'];
    date = json['date'];
    if (json['partOfLifeEffect'] != null) {
      partOfLifeEffect = <PartOfLifeEffect>[];
      json['partOfLifeEffect'].forEach((v) {
        partOfLifeEffect!.add(PartOfLifeEffect.fromJson(v));
      });
    }
    if (json['painFeelingTime'] != null) {
      painFeelingTime = <String>[];
      json['painFeelingTime'].forEach((v) {
        painFeelingTime!.add(v);
      });
    }
    userId = json['userId'];
    id = json['id'];
    if (json['type'] != null) {
      type = <String>[];
      json['type'].forEach((v) {
        type!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeling'] = feeling;
    data['howBad'] = howBad;
    data['timeOfDay'] = timeOfDay;
    data['bodyPart'] = bodyPart;
    data['name'] = name;
    data['date'] = date;
    if (partOfLifeEffect != null) {
      data['partOfLifeEffect'] = partOfLifeEffect!.map((v) => v.toJson()).toList();
    }
    if (painFeelingTime != null) {
      data['painFeelingTime'] = painFeelingTime!.map((v) => v).toList();
    }
    data['userId'] = userId;
    data['id'] = id;
    if (type != null) {
      data['type'] = type!.map((v) => v).toList();
    }
    return data;
  }
}

class PartOfLifeEffect {
  String? impactLevel;
  String? type;

  PartOfLifeEffect({this.impactLevel, this.type});

  PartOfLifeEffect.fromJson(Map<String, dynamic> json) {
    impactLevel = json['impactLevel'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['impactLevel'] = impactLevel;
    data['type'] = type;
    return data;
  }
}
