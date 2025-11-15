// category_pain_relief.dart
import 'package:collection/collection.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/pain_relief_response_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';

class CategoryPainRelief {
  List<OptionModel> painReliefOptionalModel;
  List<String> practices;
  int enjoymentScale;
  String notesPlaceholder;
  String painReliefNotes;

  CategoryPainRelief({
    required this.painReliefOptionalModel,
    required this.practices,
    required this.notesPlaceholder,
    required this.painReliefNotes,
    required this.enjoymentScale,
  });

  void updateFrom(PainReliefResponseModel data) {
    for (var option in painReliefOptionalModel) {
      bool isSelected = data.timeOfDay!.replaceAll(" ", "").toLowerCase() == option.text.replaceAll(" ", "").toLowerCase();
      option.isSelected = isSelected;
    }
    enjoymentScale = data.enjoymentScale ?? 1;
    practices = data.practices?.map((e) => e.id ?? "").toList() ?? [];
    painReliefNotes = data.note ?? "";
  }

  bool validate() {
    final OptionModel? time = painReliefOptionalModel.firstWhereOrNull((o) => o.isSelected);
    if (time == null) throw "Please select when you took action.";
    if (practices.isEmpty) throw "Please select a practice.";
    if (enjoymentScale == 0) throw "Please select enjoyment.";
    return true;
  }

  Future<PainReliefResponseModel> convertTo(String date) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    OptionModel? time = painReliefOptionalModel.firstWhereOrNull((option) => option.isSelected);
    return PainReliefResponseModel(
      userId: userId!,
      timeOfDay: time!.text.replaceAll(" ", ""),
      date: date,
      enjoymentScale: enjoymentScale,
      note: painReliefNotes,
      practices: practices.map((e) => PainPractice(id: e)).toList(),
    );
  }
}
