import 'package:dartz/dartz.dart';
import 'package:ekvi/Models/DailyTracker/PainKillers/user_pain_killer_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DailyTracker/PainKillers/pain_killer_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';

class PainKillersVaultProvider extends ChangeNotifier {
  String _painkillerName = '';
  String _painkillerIngredient = '';
  String _dosage = '';
  String _dosageEntity = 'mg';
  bool _isVisibleInTracker = true;
  bool _isPrescription = false;
  bool _isTrigger = false;
  final List<String> _triggers = [];
  String _note = '';
  List<String> _listPainKillerIngredients = [
    'Ibuprofen',
    'Naproxen',
    'Diclofenac',
    'Celecoxib',
    'Ketoprofen',
    'Meloxicam',
    'Piroxicam',
    'Etoricoxib',
    'Indomethacin',
    'Mefenamic Acid',
    'Nabumetone',
    'Sulindac',
    'Tenoxicam',
    'Aspirin',
    'Dexketoprofen',
    'Flurbiprofen',
    'Paracetamol',
    'Paracetamol with Codeine',
    'Soluble Paracetamol',
    'Codeine',
    'Tramadol',
    'Morphine',
    'Oxycodone',
    'Hydromorphone',
    'Fentanyl',
    'Buprenorphine',
    'Tapentadol',
    'Methadone',
    'Gabapentin',
    'Pregabalin',
    'Amitriptyline',
    'Nortriptyline',
    'Duloxetine',
  ];

  // Holds the model currently being edited, if any.
  UserPainKillerResponseModel? _editingPainkiller;

  // UI-related objects moved to the provider.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();

  // Getters used for UI.
  String get painkillerName => _painkillerName;
  String get painkillerIngredient => _painkillerIngredient;
  List<String> get listPainKillerIngredients => _listPainKillerIngredients;
  String get dosage => _dosage;
  String get dosageEntity => _dosageEntity;
  bool get isVisibleInTracker => _isVisibleInTracker;
  bool get isPrescription => _isPrescription;
  bool get isTrigger => _isTrigger;
  List<String> get triggers => _triggers;
  String get note => _note;

  // Collection for listing existing painkillers.
  List<UserPainKillerResponseModel> _userPainKillers = [];
  List<UserPainKillerResponseModel> get currentPills => _userPainKillers.where((pill) => pill.isVisibleInTracker).toList();
  List<UserPainKillerResponseModel> get allPills => _userPainKillers.toList();
  List<UserPainKillerResponseModel> get previousPills => _userPainKillers.where((pill) => !pill.isVisibleInTracker).toList();

  // Setters that update business state and notify listeners.
  void setPainkillerName(String value) {
    _painkillerName = value;
    notifyListeners();
  } // Setters that update business state and notify listeners.

  void setActiveIngredient(List<String> value) {
    _listPainKillerIngredients = value;
    notifyListeners();
  }

  void setPainkillerIngredient(String value) {
    _painkillerIngredient = value;
    notifyListeners();
  }

  void setDosage(String value) {
    _dosage = value;
    notifyListeners();
  }

  void setDosageEntity(String value) {
    _dosageEntity = value;
    notifyListeners();
  }

  void setIsVisibleInTracker(bool value) {
    _isVisibleInTracker = value;
    notifyListeners();
  }

  void setIsPrescription(bool value) {
    _isPrescription = value;
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
  void initialiseFields({UserPainKillerResponseModel? model, bool notify = false}) {
    _editingPainkiller = model;
    if (model == null) {
      _painkillerName = '';
      _painkillerIngredient = '';
      _dosage = '';
      _dosageEntity = 'mg';
      _isVisibleInTracker = true;
      _isPrescription = false;
      _isTrigger = false;
      _triggers.clear();
      _note = '';
    } else {
      _painkillerName = model.name;
      _painkillerIngredient = model.ingredient;
      _dosage = model.dosage.toString();
      _dosageEntity = model.dosageEntity;
      _isVisibleInTracker = model.isVisibleInTracker;
      _isPrescription = model.isPrescription;
      _isTrigger = model.isTrigger;
      _triggers
        ..clear()
        ..addAll(model.triggers);
      _note = model.note;
    }
    // Populate the controllers with current values.
    nameController.text = _painkillerName;
    dosageController.text = _dosage;
    if (notify) notifyListeners();
  }

  // Dispose controllers when the provider is disposed.
  @override
  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  /// Validate the data.
  bool validatePainkillerData(BuildContext context, bool isShow) {
    if (_painkillerName.isEmpty || _painkillerIngredient.isEmpty || _dosage.isEmpty || _dosageEntity.isEmpty || int.tryParse(_dosage) == null) {
      isShow ? HelperFunctions.showNotification(context, "Please provide all required details.") : null;
      return false;
    }
    return true;
  }

  /// Handles submission of painkiller data: creates a new record or updates an existing one.
  Future<void> submitPainkillerData(BuildContext context) async {
    if (!validatePainkillerData(context, true)) return;

    CustomLoading.showLoadingIndicator();
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");

    try {
      if (_editingPainkiller != null) {
        // Update the record.
        UserPainKillerResponseModel updatedData = _editingPainkiller!.copyWith(
          userId: userId!,
          name: _painkillerName,
          isVisibleInTracker: _isVisibleInTracker,
          isPrescription: _isPrescription,
          isTrigger: _isTrigger,
          triggers: List<String>.from(_triggers),
          note: _note,
        );
        final result = await PainkillerService.updatePainkillerRecord(_editingPainkiller!.id!, updatedData);
        result.fold(
          (l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
            CustomLoading.hideLoadingIndicator();
          },
          (updatedPill) {
            int index = _userPainKillers.indexWhere((p) => p.id == updatedPill.id);
            if (index != -1) {
              _userPainKillers[index] = updatedPill;
            }
            CustomLoading.hideLoadingIndicator();
            notifyListeners();
            AppNavigation.goBack();
          },
        );
      } else {
        // Save new record.
        UserPainKillerResponseModel data = UserPainKillerResponseModel(
          userId: userId!,
          name: _painkillerName,
          ingredient: _painkillerIngredient,
          dosage: int.parse(_dosage),
          dosageEntity: _dosageEntity,
          isVisibleInTracker: _isVisibleInTracker,
          isPrescription: _isPrescription,
          isTrigger: _isTrigger,
          triggers: _triggers,
          note: _note,
        );

        Either<dynamic, void> result = await PainkillerService.savePainkillerRecord(data);
        result.fold(
          (l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
            CustomLoading.hideLoadingIndicator();
          },
          (r) async {
            CustomLoading.hideLoadingIndicator();
            AppNavigation.goBack();
            fetchPainkillers();
            notifyListeners();
          },
        );
      }
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> deletePainkillerData() async {
    CustomLoading.showLoadingIndicator();
    try {
      final result = await PainkillerService.deletePainkillerRecord(_editingPainkiller!.id!);
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
          CustomLoading.hideLoadingIndicator();
        },
        (r) {
          _userPainKillers.removeWhere((p) => p.id == _editingPainkiller!.id);
          _editingPainkiller = null;
          notifyListeners();
          CustomLoading.hideLoadingIndicator();
          HelperFunctions.showNotification(AppNavigation.currentContext!, "Painkiller deleted successfully.");
          AppNavigation.goBack();
        },
      );
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> fetchPainkillers({bool showLoader = true}) async {
    if (showLoader) CustomLoading.showLoadingIndicator();
    try {
      Either<dynamic, List<UserPainKillerResponseModel>> result = await PainkillerService.getPainkillers();
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
          if (showLoader) CustomLoading.hideLoadingIndicator();
        },
        (r) {
          _userPainKillers = r;
          if (showLoader) CustomLoading.hideLoadingIndicator();
          notifyListeners();
        },
      );
    } catch (e) {
      if (showLoader) CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  Future<void> toggleVisibility(UserPainKillerResponseModel pill, bool newVisibility) async {
    int index = _userPainKillers.indexWhere((p) => p.id == pill.id);
    if (index == -1) return;
    _userPainKillers[index] = pill.copyWith(isVisibleInTracker: newVisibility);
    notifyListeners();
    var result = await PainkillerService.updatePainkillerVisibility(pill.id!, newVisibility);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, l.toString());
      },
      (updatedPill) {
        _userPainKillers[index] = updatedPill;
        notifyListeners();
      },
    );
  }
}
