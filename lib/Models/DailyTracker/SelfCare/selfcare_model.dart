import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategorySelfCare {
  List<OptionModel> selfCareOptionalModel;
  List<String> practices;
  int enjoymentScale;
  String notesPlaceholder;
  String selfCareNotes;

  CategorySelfCare({
    required this.selfCareOptionalModel,
    required this.practices,
    required this.notesPlaceholder,
    required this.selfCareNotes,
    required this.enjoymentScale,
  });

  void updateFrom(SelfCareResponseModel data) {
    for (var option in selfCareOptionalModel) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    enjoymentScale = data.enjoymentScale ?? 1;
    practices = data.practices?.map((e) => e.id ?? "").toList() ?? [];
    selfCareNotes = data.note ?? "";
  }

  bool validate() {
    final OptionModel? time = selfCareOptionalModel.firstWhereOrNull((o) => o.isSelected);

    if (time == null) {
      throw "Please select when you moved to continue.";
    }

    if (practices.isEmpty) {
      throw "Please select your practice to continue.";
    }
    if (enjoymentScale == 0) {
      throw "Please select enjoyment to continue.";
    }

    return true;
  }

  Future<SelfCareResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = selfCareOptionalModel.firstWhereOrNull((option) => option.isSelected);

    return SelfCareResponseModel(
      userId: userId!,
      timeOfDay: time!.text.replaceAll(" ", ""),
      date: date,
      enjoymentScale: enjoymentScale,
      note: selfCareNotes,
      practices: practices.map((e) => Practices(id: e)).toList(),
    );
  }
}

class SelfCareResponseModel {
  String? userId;
  String? timeOfDay;
  String? date;
  int? enjoymentScale;
  List<Practices>? practices;
  String? note;
  String? createdAt;
  String? updatedAt;

  SelfCareResponseModel({this.userId, this.timeOfDay, this.date, this.practices, this.note, this.createdAt, this.updatedAt, this.enjoymentScale});

  SelfCareResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    timeOfDay = json['timeOfDay'];
    enjoymentScale = json['enjoymentScale'];
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
    data['enjoymentScale'] = enjoymentScale;
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
