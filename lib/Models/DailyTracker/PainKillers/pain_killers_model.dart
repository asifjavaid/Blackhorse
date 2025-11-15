import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryPainKillers {
  List<OptionModel> painKillersTime;
  List<Painkillers>? painkillers;
  int effectiveScale;
  String notesPlaceholder;
  String painKillerNotes;

  CategoryPainKillers({
    required this.painKillersTime,
    required this.effectiveScale,
    required this.notesPlaceholder,
    required this.painKillerNotes,
  });

  void updateFrom(PainKillersResponseModel data) {
    for (var option in painKillersTime) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    effectiveScale = data.effectiveScale ?? 1;
    painkillers = data.painkillers;
    painKillerNotes = data.note ?? "";
  }

  bool validate() {
    final OptionModel? time = painKillersTime.firstWhereOrNull((o) => o.isSelected);
    if (time == null) {
      throw "Please select time";
    }

    if (effectiveScale == 0) {
      throw "Please choose pain level on scale";
    }

    final hasUnits = painkillers != null && painkillers!.any((p) => (p.units ?? 0) > 0);
    if (!hasUnits) {
      throw "Please enter units for at least one painkiller";
    }

    return true;
  }

  Future<PainKillersResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = painKillersTime.firstWhereOrNull((option) => option.isSelected);

    return PainKillersResponseModel(userId: userId!, date: date, timeOfDay: time!.text.replaceAll(" ", ""), effectiveScale: effectiveScale, painkillers: painkillers, note: painKillerNotes);
  }
}

class Painkillers {
  String? id;
  int? units;

  Painkillers({this.id, this.units});

  Painkillers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    units = json['units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['units'] = units;
    return data;
  }
}

class PainKillersResponseModel {
  String? userId;
  String? timeOfDay;
  int? effectiveScale;
  String? date;
  List<Painkillers>? painkillers;
  String? note;
  String? createdAt;
  String? updatedAt;

  PainKillersResponseModel({this.userId, this.timeOfDay, this.effectiveScale, this.date, this.painkillers, this.note, this.createdAt, this.updatedAt});

  PainKillersResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    timeOfDay = json['timeOfDay'];
    effectiveScale = json['effectiveScale'];
    date = json['date'];
    if (json['painkillers'] != null) {
      painkillers = <Painkillers>[];
      json['painkillers'].forEach((v) {
        painkillers!.add(Painkillers.fromJson(v));
      });
    }
    note = json['note'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['timeOfDay'] = timeOfDay;
    data['effectiveScale'] = effectiveScale;
    data['date'] = date;
    if (painkillers != null) {
      data['painkillers'] = painkillers!.where((p) => (p.units ?? 0) > 0).map((p) => p.toJson()).toList();
    }
    data['note'] = note;
    return data;
  }
}
