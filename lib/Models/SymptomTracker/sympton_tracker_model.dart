import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/SymptomTracker/symptom_tracker_lower_panel_model.dart';

class SymptomTrackerModel {
  String title;
  String headingText;
  String? description;
  String? imageUri;
  List<OptionModel>? optionsList;
  String? contentText;
  bool? isCheckBox;
  SymptomTrackerPanel? symptomTrackerPanel;
  SymptomTrackerModel({required this.title, required this.headingText, this.description, this.imageUri, this.optionsList, this.contentText, this.isCheckBox, this.symptomTrackerPanel});
}
