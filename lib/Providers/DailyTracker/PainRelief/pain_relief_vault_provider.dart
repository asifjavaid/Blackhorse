import 'package:ekvi/Models/DailyTracker/PainRelief/user_pain_relief_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/PainRelief/pain_relief_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';

class PainReliefVaultProvider extends ChangeNotifier {
  String _practiceName = '';
  String _emoji = '⭐';
  String _practiceType = 'Select type';
  bool _isVisibleInTracker = true;
  bool _isTrigger = false;
  final List<String> _triggers = [];
  String _note = '';

  List<String> _practiceTypeList = [
    'Select type',
    "Heat/Cold Therapy",
    "TENS/Devices",
    "Manual Therapies",
    "Positions",
    "Topical Applications",
    "Alternative Therapies",
  ];

  final List<String> _triggersList = [
    'Pain',
    'Energy',
    'Mood',
    'Stress',
    'Headache',
    'Nausea',
    'Fatigue',
    'Bloating',
    'Brain Fog',
    'Sleep',
    'Bowel Movement',
    'Urination',
    'Movement',
  ];

  UserPainReliefResponseModel? _editingPractice;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emojiController = TextEditingController();

  String get practiceName => _practiceName;
  String get emoji => _emoji;
  String get note => _note;
  String get practiceType => _practiceType;
  List<String> get practiceTypeList => _practiceTypeList;
  bool get isVisibleInTracker => _isVisibleInTracker;
  bool get isTrigger => _isTrigger;
  List<String> get triggers => _triggers;
  List<String> get triggersList => _triggersList;

  List<UserPainReliefResponseModel> _currentPractices = [];
  List<UserPainReliefResponseModel> get currentPractices => _currentPractices.where((p) => p.isVisibleInTracker).toList();
  List<UserPainReliefResponseModel> get allPractices => _currentPractices.toList();
  List<UserPainReliefResponseModel> get previousPractices => _currentPractices.where((p) => !p.isVisibleInTracker).toList();

  void setPracticeName(String value) {
    _practiceName = value;
    notifyListeners();
  }

  void setEmoji(String value) {
    _emoji = value;
    notifyListeners();
  }

  void setActiveTypeList(List<String> value) {
    _practiceTypeList = value;
    notifyListeners();
  }

  void setSelectedType(String value) {
    _practiceType = value;
    notifyListeners();
  }

  void setIsVisibleInTracker(bool value) {
    _isVisibleInTracker = value;
    notifyListeners();
  }

  void setIsTrigger(bool value) {
    _isTrigger = value;
    if (!value) _triggers.clear();
    notifyListeners();
  }

  void toggleTrigger(String trigger) {
    if (_triggers.contains(trigger)) {
      _triggers.remove(trigger);
    } else {
      _triggers.add(trigger);
    }
    notifyListeners();
  }

  void setNote(String value) {
    _note = value;
    AppNavigation.goBack();
    notifyListeners();
  }

  void initialiseFields({UserPainReliefResponseModel? model, bool notify = false}) {
    _editingPractice = model;
    if (model == null) {
      _practiceName = '';
      _emoji = '💊';
      _practiceType = 'Select type';
      _isVisibleInTracker = true;
      _isTrigger = false;
      _triggers.clear();
      _note = '';
    } else {
      _practiceName = model.name;
      _emoji = model.emoji;
      _practiceType = model.type;
      _isVisibleInTracker = model.isVisibleInTracker;
      _isTrigger = model.isTrigger;
      _triggers
        ..clear()
        ..addAll(model.triggers);
      _note = model.note;
    }
    nameController.text = _practiceName;
    emojiController.text = _emoji;
    if (notify) notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emojiController.dispose();
    super.dispose();
  }

  bool validatePainReliefData(BuildContext context, bool show) {
    if (_practiceName.isEmpty || _emoji.isEmpty || _practiceType.isEmpty || _practiceType == 'Select type') {
      if (show) HelperFunctions.showNotification(context, "Please fill the required fields");
      return false;
    }
    return true;
  }

  Future<void> submitPracticeData(BuildContext context) async {
    if (!validatePainReliefData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    final userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

    try {
      if (_editingPractice != null) {
        final updatedData = _editingPractice!.copyWith(
          userId: userId!,
          name: _practiceName,
          emoji: _emoji,
          type: _practiceType,
          isVisibleInTracker: _isVisibleInTracker,
          isTrigger: _isTrigger,
          triggers: List<String>.from(_triggers),
          note: _note,
        );
        final result = await PainReliefService.updatePracticeRecord(_editingPractice!.id!, updatedData);
        result.fold(
          (l) => HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString()),
          (updated) {
            final i = _currentPractices.indexWhere((p) => p.id == updated.id);
            if (i != -1) _currentPractices[i] = updated;
            CustomLoading.hideLoadingIndicator();
            notifyListeners();
            AppNavigation.goBack();
          },
        );
      } else {
        final newData = UserPainReliefResponseModel(
          userId: userId!,
          name: _practiceName,
          emoji: _emoji,
          type: _practiceType,
          isVisibleInTracker: _isVisibleInTracker,
          isTrigger: _isTrigger,
          triggers: _triggers,
          note: _note,
        );
        final result = await PainReliefService.savePracticeRecord(newData);
        result.fold(
          (l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
            CustomLoading.hideLoadingIndicator();
          },
          (_) async {
            CustomLoading.hideLoadingIndicator();
            AppNavigation.goBack();
            fetchPainReliefPractices();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> deletePracticeData() async {
    if (_editingPractice == null) return;

    CustomLoading.showLoadingIndicator();
    final result = await PainReliefService.deletePracticeRecord(_editingPractice!.id!);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
        CustomLoading.hideLoadingIndicator();
      },
      (_) {
        _currentPractices.removeWhere((p) => p.id == _editingPractice!.id);
        _editingPractice = null;
        notifyListeners();
        CustomLoading.hideLoadingIndicator();
        HelperFunctions.showNotification(AppNavigation.currentContext!, "Practice deleted successfully.");
        AppNavigation.goBack();
      },
    );
  }

  Future<void> fetchPainReliefPractices({bool showLoader = true}) async {
    if (showLoader) CustomLoading.showLoadingIndicator();
    try {
      final result = await PainReliefService.getPractices();
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
          if (showLoader) CustomLoading.hideLoadingIndicator();
        },
        (r) {
          _currentPractices = r;
          if (showLoader) CustomLoading.hideLoadingIndicator();
          notifyListeners();
        },
      );
    } catch (e) {
      if (showLoader) CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> toggleVisibility(UserPainReliefResponseModel model, bool newVisibility) async {
    final index = _currentPractices.indexWhere((p) => p.id == model.id);
    if (index == -1) return;

    final updated = model.copyWith(isVisibleInTracker: newVisibility);
    _currentPractices[index] = updated;
    notifyListeners();

    final result = await PainReliefService.updatePracticeRecord(model.id!, updated);
    result.fold(
      (l) => HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString()),
      (data) {
        _currentPractices[index] = data;
        notifyListeners();
      },
    );
  }
}
