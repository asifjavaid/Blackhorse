import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/SelfCare/user_selfcare_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/SelfCare/selfcare_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';

class SelfcareVaultProvider extends ChangeNotifier {
  String _practiceName = '';
  String _emoji = '⭐️';
  String _practiceType = 'Select type';
  bool _isVisibleInTracker = true;
  bool _isTrigger = false;
  final List<String> _triggers = [];
  String _note = '';
  List<String> _practiceTypeList = ['Select type', "Restorative", "Regulating", "Emotional care", "Nourishing", "Relational", "Creative", "Reclaiming", "Spiritual"];

  final List<String> _triggersList = ['Pain', 'Energy', 'Mood', 'Stress', 'Headache', 'Nausea', 'Fatigue', 'Bloating', 'Brain fog', 'Bowel movement', 'Urination', 'Exercise', 'Sleep'];

  // Holds the model currently being edited, if any.
  UserSelfCareResponseModel? _editingSelfCare;

  // UI-related objects moved to the provider.`
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emojiController = TextEditingController();

  // Getters used for UI.
  String get practiceName => _practiceName;
  String get emoji => _emoji;
  String get note => _note;
  String get practiceType => _practiceType;
  List<String> get practiceTypeList => _practiceTypeList;
  bool get isVisibleInTracker => _isVisibleInTracker;
  bool get isTrigger => _isTrigger;
  List<String> get triggers => _triggers;
  List<String> get triggersList => _triggersList;

  // Collection for listing existing painkillers.
  List<UserSelfCareResponseModel> _currentPractices = [];
  List<UserSelfCareResponseModel> get currentPractices => _currentPractices.where((practice) => practice.isVisibleInTracker).toList();
  List<UserSelfCareResponseModel> get allPractices => _currentPractices.toList();
  List<UserSelfCareResponseModel> get previousPractices => _currentPractices.where((practice) => !practice.isVisibleInTracker).toList();
  void setPracticeName(String value) {
    _practiceName = value;
    notifyListeners();
  }

  void setEmoji(String value) {
    _emoji = value;
    notifyListeners();
  }

  void setActiveIngredient(List<String> value) {
    _practiceTypeList = value;
    notifyListeners();
  }

  setSelectedType(String value) {
    _practiceType = value;
    notifyListeners();
  }

  void setIsVisibleInTracker(bool value) {
    _isVisibleInTracker = value;
    notifyListeners();
  }

  void setIsTrigger(bool value) {
    _isTrigger = value;
    if (!value) {
      _triggers.clear();
    }
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

  /// Initialise fields and controllers based on the [model]. This will only be done once.
  void initialiseFields({UserSelfCareResponseModel? model, bool notify = false}) {
    _editingSelfCare = model;
    if (model == null) {
      _practiceName = '';
      _emoji = '⭐️';
      _isVisibleInTracker = true;
      _isTrigger = false;
      _triggers.clear();
      _note = '';
      _practiceType = 'Select type';
    } else {
      _practiceName = model.name;
      _emoji = model.emoji;
      _isVisibleInTracker = model.isVisibleInTracker;
      _isTrigger = model.isTrigger;
      _triggers
        ..clear()
        ..addAll(model.triggers);
      _note = model.note;
      _practiceType = model.type;
    }
    // Populate the controllers with current values.
    nameController.text = _practiceName;
    emojiController.text = _emoji;
    if (notify) notifyListeners();
  }

  // Dispose controllers when the provider is disposed.
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  bool validateSelfcareData(BuildContext context, bool isShow) {
    if (_practiceName.isEmpty || _emoji.isEmpty || _practiceType.isEmpty || (_practiceType == 'Select type')) {
      isShow ? HelperFunctions.showNotification(context, "Please fill the required fields") : null;
      return false;
    }
    return true;
  }

  /// Handles submission of painkiller data: creates a new record or updates an existing one.
  Future<void> submitPracticeData(BuildContext context) async {
    if (!validateSelfcareData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

    try {
      if (_editingSelfCare != null) {
        UserSelfCareResponseModel updatedData = _editingSelfCare!.copyWith(
          userId: userId!,
          name: _practiceName,
          emoji: _emoji,
          type: practiceType,
          isVisibleInTracker: _isVisibleInTracker,
          isTrigger: _isTrigger,
          triggers: List<String>.from(_triggers),
          note: _note,
        );
        final result = await SelfcareService.updatePracticeRecord(_editingSelfCare!.id!, updatedData);
        result.fold(
          (l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
            CustomLoading.hideLoadingIndicator();
          },
          (updatedPill) {
            int index = _currentPractices.indexWhere((p) => p.id == updatedPill.id);
            if (index != -1) {
              _currentPractices[index] = updatedPill;
            }
            CustomLoading.hideLoadingIndicator();
            notifyListeners();
            AppNavigation.goBack();
          },
        );
      } else {
        // Save new record.
        UserSelfCareResponseModel data = UserSelfCareResponseModel(
          userId: userId!,
          name: _practiceName,
          type: _practiceType,
          emoji: _emoji,
          isVisibleInTracker: _isVisibleInTracker,
          isTrigger: _isTrigger,
          triggers: _triggers,
          note: _note,
        );

        Either<dynamic, void> result = await SelfcareService.savePracticeRecord(data);
        result.fold(
          (l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
            CustomLoading.hideLoadingIndicator();
          },
          (r) async {
            CustomLoading.hideLoadingIndicator();
            AppNavigation.goBack();
            fetchSelfcarePractices();
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
    CustomLoading.showLoadingIndicator();
    try {
      final result = await SelfcareService.deletePracticeRecord(_editingSelfCare!.id!);
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
          CustomLoading.hideLoadingIndicator();
        },
        (r) {
          _currentPractices.removeWhere((p) => p.id == _editingSelfCare!.id);
          _editingSelfCare = null;
          notifyListeners();
          CustomLoading.hideLoadingIndicator();
          HelperFunctions.showNotification(AppNavigation.currentContext!, "Practice deleted successfully.");
          AppNavigation.goBack();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> fetchSelfcarePractices({bool showLoader = true}) async {
    if (showLoader) CustomLoading.showLoadingIndicator();
    try {
      Either<dynamic, List<UserSelfCareResponseModel>> result = await SelfcareService.getPractices();
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

  Future<void> toggleVisibility(UserSelfCareResponseModel practice, bool newVisibility) async {
    int index = _currentPractices.indexWhere((p) => p.id == practice.id);
    if (index == -1) return;
    _currentPractices[index] = practice.copyWith(isVisibleInTracker: newVisibility);
    notifyListeners();
    var result = await SelfcareService.updatePracticeRecord(practice.id!, _currentPractices[index]);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (updatedPill) {
        _currentPractices[index] = updatedPill;
        notifyListeners();
      },
    );
  }
}
