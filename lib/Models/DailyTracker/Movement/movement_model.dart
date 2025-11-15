import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryMovement {
  List<OptionModel> movementsOptionalModel;
  List<String> practices;
  int intensityScale;
  int enjoymentScale;
  String notesPlaceholder;
  String movementsNotes;
  DateTime durationTime;

  CategoryMovement(
      {required this.movementsOptionalModel,
      required this.intensityScale,
      required this.practices,
      required this.notesPlaceholder,
      required this.movementsNotes,
      required this.enjoymentScale,
      required this.durationTime});

  void updateFrom(MovementResponseModel data) {
    for (var option in movementsOptionalModel) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    intensityScale = data.intensityScale ?? 1;
    enjoymentScale = data.enjoymentScale ?? 1;
    practices = data.practices?.map((e) => e.id ?? "").toList() ?? [];
    movementsNotes = data.note ?? "";
    final duration = data.durationMinutes ?? 0;
    final hours = duration ~/ 60;
    final minutes = duration % 60;

    final now = DateTime.now();
    durationTime = DateTime(now.year, now.month, now.day, hours, minutes);
  }

  bool validate() {
    final OptionModel? time = movementsOptionalModel.firstWhereOrNull((o) => o.isSelected);
    if (time == null && intensityScale == 0 && practices.isEmpty && enjoymentScale == 0 && (durationTime.hour == 0 && durationTime.minute == 0)) {
      throw "Please select when you moved, intensity, enjoyment, your practice, and duration to continue.";
    }
    if (time == null) {
      throw "Please select when you moved to continue.";
    }
    if (intensityScale == 0) {
      throw "Please select intensity to continue.";
    }
    if (practices.isEmpty) {
      throw "Please select your practice to continue.";
    }
    if (enjoymentScale == 0) {
      throw "Please select enjoyment to continue.";
    }

    if (durationTime.hour == 0 && durationTime.minute == 0) {
      throw "Please select movement duration to continue";
    }

    return true;
  }

  Future<MovementResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = movementsOptionalModel.firstWhereOrNull((option) => option.isSelected);

    final totalMinutes = (durationTime.hour * 60) + durationTime.minute;

    return MovementResponseModel(
      userId: userId!,
      timeOfDay: time!.text.replaceAll(" ", ""),
      date: date,
      durationMinutes: totalMinutes,
      intensityScale: intensityScale,
      enjoymentScale: enjoymentScale,
      note: movementsNotes,
      practices: practices.map((e) => Practices(id: e)).toList(),
    );
  }
}

class MovementResponseModel {
  String? userId;
  String? timeOfDay;
  String? date;
  int? intensityScale;
  int? enjoymentScale;
  int? durationMinutes;
  List<Practices>? practices;
  String? note;
  String? createdAt;
  String? updatedAt;

  MovementResponseModel({this.userId, this.timeOfDay, this.date, this.intensityScale, this.durationMinutes, this.practices, this.note, this.createdAt, this.updatedAt, this.enjoymentScale});

  MovementResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    timeOfDay = json['timeOfDay'];
    intensityScale = json['intensityScale'];
    enjoymentScale = json['enjoymentScale'];
    durationMinutes = json['durationMinutes'];
    if (json['practices'] != null) {
      practices = <Practices>[];
      json['practices'].forEach((v) {
        practices!.add(Practices.fromJson(v));
      });
    }
    date = json['date'];
    note = json['note'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['timeOfDay'] = timeOfDay;
    data['date'] = date;
    data['intensityScale'] = intensityScale;
    data['enjoymentScale'] = enjoymentScale;
    data['durationMinutes'] = durationMinutes;
    if (practices != null) {
      data['practices'] = practices!.map((v) => v.id).toList();
    }
    data['note'] = note;
    return data;
  }
}

class Practices {
  String? name;
  String? type;
  String? id;
  Practices({this.id, this.name, this.type});

  Practices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    type = json['type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name;
    }
    if (type != null) {
      data['type'] = type;
    }
    return data;
  }
}
