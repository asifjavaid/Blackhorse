import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart' as dartz;
import 'package:ekvi/Models/DailyTracker/categories_by_date.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_amplitude_events.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_models.dart';
import 'package:ekvi/Models/DailyTracker/daily_tracker_notes.dart';
import 'package:ekvi/Models/DailyTracker/Headache/headache_model.dart';
import 'package:ekvi/Models/DailyTracker/options_model.dart';
import 'package:ekvi/Models/DailyTracker/symptom_categories_model.dart';
import 'package:ekvi/Providers/DailyTracker/Alcohol/alcohol_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Bleeding/bleeding_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Bloating/bloating_provider.dart';
import 'package:ekvi/Providers/DailyTracker/BowelMovement/bowel_movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/BrainFog/brain_fog_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Energy/energy_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Fatigue/fatigue_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Headache/headache_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Hormones/hormones_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Initmacy/intimacy_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Mood/mood_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Nausea/nausea_provider.dart';
import 'package:ekvi/Providers/DailyTracker/OvulationTest/ovulation_test_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainKillers/pain_killers_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/PregnancyTest/pregnancy_test_provider.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_provider.dart';
import 'package:ekvi/Providers/DailyTracker/SelfCare/selfcare_vault_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Stress/stress_provider.dart';
import 'package:ekvi/Providers/DailyTracker/Urination/urination_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Services/DailyTracker/Alcohol/alcohol_service.dart';
import 'package:ekvi/Services/DailyTracker/Bleeding/bleeding_service.dart';
import 'package:ekvi/Services/DailyTracker/Bloating/bloating_service.dart';
import 'package:ekvi/Services/DailyTracker/BowelMovements/bowel_movements_service.dart';
import 'package:ekvi/Services/DailyTracker/BrainFog/brain_fog_service.dart';
import 'package:ekvi/Services/DailyTracker/Energy/energy_service.dart';
import 'package:ekvi/Services/DailyTracker/Fatigue/fatigue_service.dart';
import 'package:ekvi/Services/DailyTracker/Headache/headache_service.dart';
import 'package:ekvi/Services/DailyTracker/Hormones/hormones_service.dart';
import 'package:ekvi/Services/DailyTracker/Initmacy/intimacy_service.dart';
import 'package:ekvi/Services/DailyTracker/Mood/mood_service.dart';
import 'package:ekvi/Services/DailyTracker/Movement/movement_service.dart';
import 'package:ekvi/Services/DailyTracker/Nausea/nausea_service.dart';
import 'package:ekvi/Services/DailyTracker/OvulationTest/ovulation_test_service.dart';
import 'package:ekvi/Services/DailyTracker/PainKillers/pain_killer_service.dart';
import 'package:ekvi/Services/DailyTracker/PainRelief/pain_relief_service.dart';
import 'package:ekvi/Services/DailyTracker/PregnancyTest/pregnancy_test_service.dart';
import 'package:ekvi/Services/DailyTracker/SelfCare/selfcare_service.dart';
import 'package:ekvi/Services/DailyTracker/Stress/stress_service.dart';
import 'package:ekvi/Services/DailyTracker/Urination/urination_service.dart';
import 'package:ekvi/Services/DailyTracker/daily_tracker_service.dart';
import 'package:ekvi/Services/EditProfile/edit_profile_service.dart' show EditProfileService;
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/constants/ui_data_initializations.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Models/DailyTracker/TrackingSettings/TrackingCategory.dart';
import '../../Models/DailyTracker/TrackingSettings/TrackingItem.dart';
import '../../Models/EditProfle/user_profile_model.dart';

class DailyTrackerProvider extends ChangeNotifier {
  bool? _dailyTrackerViewMode;
  SelectedDateOfUserForTracking selectedDateOfUserForTracking =
      SelectedDateOfUserForTracking(date: DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, 1)));
  DateTime focusedDate = DateTime.now();
  PanelController panelController = PanelController();
  bool isDeleteMode = false;
  Map<SymptomCategory, List<String?>> toBeDeletedCategory = {};
  int toBeDeleteCategoriesCount = 0;
  late Future<dartz.Either<String, CompletedCategoriesByDate>> filledCategoriesByDate;
  SymptomCategory _selectedCategory = SymptomCategory.Bleeding;
  PainEventsCategory _selectedPainEventCategory = PainEventsCategory.Existing;
  bool isBodyPoseFront = true;
  DailyTrackerNotes categoriestNotes = DailyTrackerNotes();

  final List<TrackingCategory> categories = [
    TrackingCategory(
      title: 'Things I experience',
      items: [
        TrackingItem(title: 'Pain'),
        TrackingItem(title: 'Bleeding'),
        TrackingItem(title: 'Headache'),
        TrackingItem(title: 'Mood'),
        TrackingItem(title: 'Stress'),
        TrackingItem(title: 'Energy'),
      ],
    ),
    // ... all other categories remain the same as in the previous response
    TrackingCategory(
      title: 'Symptoms',
      items: [
        TrackingItem(title: 'Nausea'),
        TrackingItem(title: 'Fatigue'),
        TrackingItem(title: 'Bloating'),
        TrackingItem(title: 'Brain fog'),
      ],
    ),
    TrackingCategory(
      title: 'Things I put in my body',
      items: [
        TrackingItem(title: 'Painkillers'),
        TrackingItem(title: 'Hormones'),
        TrackingItem(title: 'Alcohol'),
      ],
    ),
    TrackingCategory(
      title: 'Bathroom habits',
      items: [
        TrackingItem(title: 'Bowel movement'),
        TrackingItem(title: 'Urination'),
      ],
    ),
    TrackingCategory(
      title: 'Wellbeing',
      items: [
        TrackingItem(title: 'Movement'),
        TrackingItem(title: 'Self-care'),
        TrackingItem(title: 'Pain relief'),
      ],
    ),
    TrackingCategory(
      title: 'Intimacy & Fertility',
      items: [
        TrackingItem(title: 'Intimacy'),
        TrackingItem(title: 'Ovulation test'),
        TrackingItem(title: 'Pregnancy test'),
      ],
    ),
  ];

  Map<String, Data?> filledCategoryTimes = {};

  get getDailyTrackerViewMode => _dailyTrackerViewMode;

  set setDailyTrackerViewMode(bool? mode) {
    _dailyTrackerViewMode = mode;
    if (mode != null) {
      notifyListeners();
    }
  }

  void setCategoriesNotes(String notes) async {
    categoriestNotes.text = notes;
    await handleSaveCategoryData(SymptomCategory.Notes);
    notifyListeners();
  }

  void togglePanel({bool? openPanelNeeded = false, bool? closePanelNeeded = false}) async {
    if (panelController.isPanelOpen) {
      await panelController.close();
    } else {
      panelController.open();
    }
    notifyListeners();
  }

  void toggleIsEditingBodyPartsEnabled() async {
    categoriesData.bodyPain.editingBodyPartsEnabled = !categoriesData.bodyPain.editingBodyPartsEnabled;
    notifyListeners();
  }

  void switchToDeleteMode(bool mode, {List<String?>? categoryIDs, SymptomCategory? categoryType}) {
    isDeleteMode = mode;
    notifyListeners();

    togglePanel(openPanelNeeded: true);

    if (categoryIDs != null) {
      handleCategoryDelete(categoryIDs: categoryIDs, categoryType: categoryType!);
    }
  }

  void handleCategoryDelete({List<String?>? categoryIDs, required SymptomCategory categoryType}) {
    if (categoryIDs != null) {
      List<String> nonNullCategoryIDs = categoryIDs.whereType<String>().toList();
      bool containsAll = nonNullCategoryIDs.every((item) => toBeDeletedCategory[categoryType]?.contains(item) ?? false);

      if (containsAll) {
        toBeDeletedCategory[categoryType]?.removeWhere((item) => nonNullCategoryIDs.contains(item));
        if (toBeDeletedCategory[categoryType]?.isEmpty ?? true) {
          toBeDeletedCategory.remove(categoryType);
        }
        toBeDeleteCategoriesCount -= 1;
      } else {
        toBeDeletedCategory.putIfAbsent(categoryType, () => []).addAll(nonNullCategoryIDs);
        toBeDeleteCategoriesCount += 1;
      }
    }
    if (toBeDeletedCategory.values.every((list) => list.isEmpty)) {
      isDeleteMode = false;
      notifyListeners();
      togglePanel(closePanelNeeded: true);
    }
    notifyListeners();
  }

  void updateSelectedDateOfUserForTracking(String date, {bool? notify, bool? showLoader}) {
    selectedDateOfUserForTracking = SelectedDateOfUserForTracking(date: date);
    focusedDate = DateTime.parse(date);

    if (notify != null && notify) {
      notifyListeners();
    }
    consultBackendForCompletedCategories(showLoader: showLoader);
  }

  void addSelectedBodyPart(BodyPart? bodyPart) {
    if (bodyPart != null) {
      categoriesData.bodyPain.selectedBodyParts.add(bodyPart);
      notifyListeners();
    }
  }

  void removeSelectedBodyPart(BodyPart? bodyPart) {
    if (bodyPart != null) {
      categoriesData.bodyPain.selectedBodyParts.remove(bodyPart);
      notifyListeners();
    }
  }

  void eraseAllBodyParts() {
    categoriesData.bodyPain.selectedBodyParts = [];
    notifyListeners();
  }

  void setBodyPose(bool isFront) {
    isBodyPoseFront = isFront;
    notifyListeners();
  }

  set setSelectedPainEventCategory(PainEventsCategory painEventsCategory) {
    _selectedPainEventCategory = painEventsCategory;
    notifyListeners();
  }

  set setSelectedCategory(SymptomCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  PainEventsCategory get selectedPainEventCategory => _selectedPainEventCategory;

  SymptomCategory get selectedCategory => _selectedCategory;

  Future<void> handleSaveCategoryData(SymptomCategory category, {String? painKillerName, String? painKillerType}) async {
    switch (category) {
      case SymptomCategory.Notes:
        CustomLoading.showLoadingIndicator();
        String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
        categoriestNotes.userId = userId!;
        categoriestNotes.date = selectedDateOfUserForTracking.date;
        var result = await DailyTrackerService.saveNotes(categoriestNotes, notesId: categoriestNotes.id);
        result.fold(
          (l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
            CustomLoading.hideLoadingIndicator();
          },
          (r) async {
            consultBackendForCompletedCategories();

            AppNavigation.goBack();
            CustomLoading.hideLoadingIndicator();
            notifyListeners();
          },
        );
        break;
      case SymptomCategory.Pain_Killers:
        break;

      case SymptomCategory.Bleeding:
        break;
      case SymptomCategory.Hormones:
        break;
      case SymptomCategory.Alcohol:
        break;
      case SymptomCategory.Ovulation_test:
        break;
      case SymptomCategory.Pregnancy_test:
        break;

      case SymptomCategory.Intimacy:
        break;
      case SymptomCategory.Body_Pain:
        break;
      case SymptomCategory.Dr_Visit:
        break;
      case SymptomCategory.Mood:
        break;
      case SymptomCategory.Stress:
        break;
      case SymptomCategory.Energy:
        break;
      case SymptomCategory.Fatigue:
        break;
      case SymptomCategory.Bloating:
        break;
      case SymptomCategory.Nausea:
        break;
      case SymptomCategory.Brain_Fog:
        break;
      case SymptomCategory.Bowel_movement:
        break;
      case SymptomCategory.Movement:
        break;
      case SymptomCategory.Self_Care:
        break;
      case SymptomCategory.Pain_Relief:
        break;
      case SymptomCategory.Headache:
        break;
      case SymptomCategory.Urination:
        break;
    }
  }

  Future<void> handleSaveEventData(PainEventsCategory event) async {
    switch (event) {
      case PainEventsCategory.Existing:
        try {
          categoriesData.bodyPain.justExisting.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.justExisting.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();
          final result = await DailyTrackerService.saveEvent(data, PainEventsCategory.Existing);
          result.fold((l) {
            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Eating:
        try {
          categoriesData.bodyPain.eating.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.eating.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);

          CustomLoading.showLoadingIndicator();

          final result = await DailyTrackerService.saveEvent(
            data,
            PainEventsCategory.Eating,
          );
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();
            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Toilet:
        try {
          categoriesData.bodyPain.toilet.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.toilet.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();

          final result = await DailyTrackerService.saveEvent(
            data,
            PainEventsCategory.Toilet,
          );
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();

            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Travel:
        try {
          categoriesData.bodyPain.travel.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.travel.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();

          final result = await DailyTrackerService.saveEvent(data, PainEventsCategory.Travel);
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();

            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Exercise:
        try {
          categoriesData.bodyPain.exercise.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.exercise.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();

          final result = await DailyTrackerService.saveEvent(data, PainEventsCategory.Exercise);
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();

            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Sleep:
        try {
          categoriesData.bodyPain.sleep.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.sleep.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();

          final result = await DailyTrackerService.saveEvent(
            data,
            PainEventsCategory.Sleep,
          );
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();

            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Intimacy:
        try {
          categoriesData.bodyPain.sex.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.sex.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();
          final result = await DailyTrackerService.saveEvent(data, PainEventsCategory.Intimacy);
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();

            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;

      case PainEventsCategory.Work:
        try {
          categoriesData.bodyPain.work.validate();
          DailyTrackerEvent data =
              await categoriesData.bodyPain.work.convertTo(categoriesData.bodyPain.selectedBodyParts, selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();
          final result = await DailyTrackerService.saveEvent(data, PainEventsCategory.Work);
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();
            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;

      case PainEventsCategory.Headache:
        try {
          categoriesData.bodyPain.headache.validate();
          HeadacheRequestModel data = await categoriesData.bodyPain.headache.convertTo(selectedDateOfUserForTracking.date);
          CustomLoading.showLoadingIndicator();
          final result = await HeadacheService.saveHeadacheAnswers(data);
          result.fold((l) {
            CustomLoading.hideLoadingIndicator();
            HelperFunctions.showNotification(AppNavigation.currentContext!, l);
          }, (r) {
            CustomLoading.hideLoadingIndicator();
            consultBackendForCompletedCategories();
            AppNavigation.popUntil(AppRoutes.sideNavManager);
          });
        } catch (e) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, e.toString());
        }
        break;
      case PainEventsCategory.Urination:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  Future<void> _deleteCategory(SymptomCategory category, List<String?> ids) async {
    switch (category) {
      case SymptomCategory.Body_Pain:
        await DailyTrackerService.deleteBatchEvents(ids);
        break;
      case SymptomCategory.Bleeding:
        await BleedingService.deleteBatchBleeding(ids);
        break;
      case SymptomCategory.Stress:
        await StressService.deleteStressData(ids);
        break;
      case SymptomCategory.Mood:
        await MoodService.deleteMoodData(ids);
        break;
      case SymptomCategory.Energy:
        await EnergyService.deleteEnergyData(ids);
        break;

      case SymptomCategory.Nausea:
        await NauseaService.deleteNauseaData(ids);
        break;

      case SymptomCategory.Fatigue:
        await FatigueService.deleteFatigueData(ids);
        break;

      case SymptomCategory.Bloating:
        await BloatingService.deleteBloatingData(ids);
        break;
      case SymptomCategory.Brain_Fog:
        await BrainFogService.deleteBrainFogData(ids);
        break;
      case SymptomCategory.Bowel_movement:
        await BowelMovementService.deleteBowelMovData(ids);
        break;
      case SymptomCategory.Urination:
        await UrinationUrgencyService.deleteUrinationData(ids);
        break;
      case SymptomCategory.Alcohol:
        await AlcoholService.deleteAlcoholData(ids);
        break;
      case SymptomCategory.Hormones:
        await HormonesService.deleteHormonesData(ids);
        break;
      case SymptomCategory.Intimacy:
        await IntimacyService.deleteIntimacyData(ids);
        break;
      case SymptomCategory.Ovulation_test:
        await OvulationTestService.deleteOvulationTestData(ids);
        break;
      case SymptomCategory.Pregnancy_test:
        await PregnancyTestService.deletePregnancyTestData(ids);
        break;

      case SymptomCategory.Pain_Killers:
        await PainkillerService.deletePainKillerTrackingData(ids);
        break;

      case SymptomCategory.Movement:
        await MovementService.deleteMovementTrackingData(ids);
        break;

      case SymptomCategory.Self_Care:
        await SelfcareService.deleteSelfCareTrackingData(ids);
        break;
      case SymptomCategory.Pain_Relief:
        await PainReliefService.deletePainReliefTrackingData(ids);
        break;
      case SymptomCategory.Headache:
        await HeadacheService.deleteHeadacheData(ids);
        break;
      default:
        await DailyTrackerService.deleteBatchCategories(ids);
        break;
    }
  }

  Future<void> handleDeleteCategoryData() async {
    List<Future> deletionTasks = [];

    for (var entry in toBeDeletedCategory.entries) {
      if (entry.value.isNotEmpty) {
        deletionTasks.add(_deleteCategory(entry.key, entry.value));
      }
    }
    try {
      CustomLoading.showLoadingIndicator();
      await Future.wait(deletionTasks);
      revertDeleteMode();
      consultBackendForCompletedCategories();
      notifyListeners();
      CustomLoading.hideLoadingIndicator();
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  void revertDeleteMode() {
    isDeleteMode = false;
    toBeDeletedCategory = {};
    toBeDeleteCategoriesCount = 0;
    togglePanel(closePanelNeeded: true);
    notifyListeners();
  }

  void handleSelectedCategory(String title, {CategoryPanelMode? mode, String? timeOfDay, EventData? eventData}) async {
    SymptomTrackingStarted(
            startTime: DateTime.now(), symptomCategory: title, userId: (await SharedPreferencesHelper.getStringPrefValue(key: "userId"))!)
        .log();
    SymptomCategory category = HelperFunctions.getSymptomCategoryFromString(title);
    switch (category) {
      case SymptomCategory.Body_Pain:
        if (mode != null && mode == CategoryPanelMode.edit) {
        } else {
          eraseAllBodyParts();
          setSelectedCategory = SymptomCategory.Body_Pain;
          categoriesData.bodyPain.isEditing = false;
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }

        break;
      case SymptomCategory.Bleeding:
        var bleedingProvider = Provider.of<BleedingProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Bleeding;
          await bleedingProvider.fetchBleedingData(selectedDateOfUserForTracking.date, timeOfDay!);
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
        } else {
          setSelectedCategory = SymptomCategory.Bleeding;
          bleedingProvider.resetBleedingSelection();
          categoriesData.bleeding = DataInitializations.categoriesData().bleeding;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }

        break;

      case SymptomCategory.Dr_Visit:
        break;

      case SymptomCategory.Hormones:
        var hormonesProvider = Provider.of<HormonesProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Hormones;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          hormonesProvider.fetchHormonesData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Hormones;
          hormonesProvider.resetHormonesSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Pain_Killers:
        var painKillerProvider = Provider.of<PainKillersProvider>(AppNavigation.currentContext!, listen: false);
        var painKillerVaultProvider = Provider.of<PainKillersVaultProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Pain_Killers;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          painKillerVaultProvider.fetchPainkillers(showLoader: false);
          painKillerProvider.fetchPainKillerData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Pain_Killers;
          painKillerProvider.resetPainKillerSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          painKillerVaultProvider.fetchPainkillers(showLoader: false);
          notifyListeners();
        }

        break;

      case SymptomCategory.Alcohol:
        var alcoholProvider = Provider.of<AlcoholProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Alcohol;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          alcoholProvider.fetchAlcoholData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Alcohol;
          alcoholProvider.resetAlcoholSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Ovulation_test:
        var ovulationTestProvider = Provider.of<OvulationTestProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Ovulation_test;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          ovulationTestProvider.fetchOvulationTestData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Ovulation_test;
          ovulationTestProvider.resetOvulationTestSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Pregnancy_test:
        var pregnancyTestProvider = Provider.of<PregnancyTestProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Pregnancy_test;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          pregnancyTestProvider.fetchPregnancyTestData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Pregnancy_test;
          pregnancyTestProvider.resetPregnancyTestSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Intimacy:
        var intimacyProvider = Provider.of<IntimacyProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Intimacy;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          intimacyProvider.fetchIntimacyData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Intimacy;
          intimacyProvider.resetIntimacySelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Notes:
        break;
      case SymptomCategory.Mood:
        var moodProvider = Provider.of<MoodProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Mood;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          moodProvider.fetchMoodData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Mood;
          moodProvider.resetMoodSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;
      case SymptomCategory.Energy:
        var energyProvider = Provider.of<EnergyProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Energy;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          energyProvider.fetchEnergyData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Energy;
          energyProvider.resetEnergySelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }

        break;
      case SymptomCategory.Stress:
        var stressProvider = Provider.of<StressProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Stress;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          stressProvider.fetchStressData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Stress;
          stressProvider.resetStressSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Nausea:
        var nauseaProvider = Provider.of<NauseaProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Nausea;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          nauseaProvider.fetchNauseaData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Nausea;
          nauseaProvider.resetNauseaSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Fatigue:
        var fatigueProvider = Provider.of<FatigueProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Fatigue;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          fatigueProvider.fetchFatigueData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Fatigue;
          fatigueProvider.resetFatigueSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;
      case SymptomCategory.Bowel_movement:
        var bowelProvider = Provider.of<BowelMovementProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Bowel_movement;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          bowelProvider.fetchBowelMovData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Bowel_movement;
          bowelProvider.resetBowelMovSeletion();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;
      case SymptomCategory.Urination:
        var urinationProvider = Provider.of<UrinationProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Urination;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          urinationProvider.fetchUrinationData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Urination;
          urinationProvider.resetUrinationSeletion();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;
      case SymptomCategory.Bloating:
        var bloatingProvider = Provider.of<BloatingProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Bloating;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          bloatingProvider.fetchBloatingData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Bloating;
          bloatingProvider.resetBloatingSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Brain_Fog:
        var brainFogProvider = Provider.of<BrainFogProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Brain_Fog;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          brainFogProvider.fetchBrainFogData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Brain_Fog;
          brainFogProvider.resetBrainFogSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;

      case SymptomCategory.Movement:
        var movementProvider = Provider.of<MovementProvider>(AppNavigation.currentContext!, listen: false);
        var movementsVaultProvider = Provider.of<MovementVaultProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Movement;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          movementsVaultProvider.fetchMovementPractices(showLoader: false);
          movementProvider.fetchCategoryMovement(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Movement;
          movementProvider.resetMovementSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          movementsVaultProvider.fetchMovementPractices(showLoader: false);
          notifyListeners();
        }
        break;

      case SymptomCategory.Self_Care:
        var selfCareProvider = Provider.of<SelfcareProvider>(AppNavigation.currentContext!, listen: false);
        var selfCareVaultProvider = Provider.of<SelfcareVaultProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Self_Care;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          selfCareVaultProvider.fetchSelfcarePractices(showLoader: false);
          selfCareProvider.fetchCategorySelfcare(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Self_Care;
          selfCareProvider.resetSelfCareSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          selfCareVaultProvider.fetchSelfcarePractices(showLoader: false);
          notifyListeners();
        }

        break;

      case SymptomCategory.Pain_Relief:
        var painReliefProvider = Provider.of<PainReliefProvider>(AppNavigation.currentContext!, listen: false);
        var painReliefVaultProvider = Provider.of<PainReliefVaultProvider>(AppNavigation.currentContext!, listen: false);

        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Pain_Relief;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          painReliefVaultProvider.fetchPainReliefPractices(showLoader: false);
          painReliefProvider.fetchCategoryPainRelief(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Pain_Relief;
          painReliefProvider.resetPainReliefSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          painReliefVaultProvider.fetchPainReliefPractices(showLoader: false);
          notifyListeners();
        }
        break;

      case SymptomCategory.Headache:
        var headacheProvider = Provider.of<HeadacheProvider>(AppNavigation.currentContext!, listen: false);
        if (mode != null && mode == CategoryPanelMode.edit) {
          setSelectedCategory = SymptomCategory.Headache;
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          headacheProvider.fetchHeadacheData(selectedDateOfUserForTracking.date, timeOfDay!);
        } else {
          setSelectedCategory = SymptomCategory.Headache;
          headacheProvider.resetHeadacheSelection();
          AppNavigation.navigateTo(AppRoutes.categoryEdit);
          notifyListeners();
        }
        break;
    }
  }

  void handleSelectedPainEvent(String title, {EventPanelMode? mode, String? timeOfDay, EventData? eventData}) async {
    PainEventsCategory category = HelperFunctions.getPainEventsCategoryFromString(title);

    switch (category) {
      case PainEventsCategory.Eating:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Eating;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;
          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.eating.updateFrom(eventData);
          AppNavigation.navigateTo(AppRoutes.painEventEdit);

          notifyListeners();
        } else {
          setSelectedPainEventCategory = PainEventsCategory.Eating;
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;

          categoriesData.bodyPain.eating = DataInitializations.categoriesData().bodyPain.eating;
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        }

        break;
      case PainEventsCategory.Existing:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Existing;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;
          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.justExisting.updateFrom(eventData);
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        } else {
          setSelectedPainEventCategory = PainEventsCategory.Existing;
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;

          categoriesData.bodyPain.justExisting = DataInitializations.categoriesData().bodyPain.justExisting;
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        }

        break;
      case PainEventsCategory.Exercise:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Exercise;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;

          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.exercise.updateFrom(eventData);
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        } else {
          setSelectedPainEventCategory = PainEventsCategory.Exercise;
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;

          categoriesData.bodyPain.exercise = DataInitializations.categoriesData().bodyPain.exercise;
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        }

        break;
      case PainEventsCategory.Toilet:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Toilet;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;

          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.toilet.updateFrom(eventData);
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        } else {
          setSelectedPainEventCategory = PainEventsCategory.Toilet;
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;

          categoriesData.bodyPain.toilet = DataInitializations.categoriesData().bodyPain.toilet;
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        }

        break;

      case PainEventsCategory.Travel:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Travel;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;

          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.travel.updateFrom(eventData);
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        } else {
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;

          setSelectedPainEventCategory = PainEventsCategory.Travel;
          categoriesData.bodyPain.travel = DataInitializations.categoriesData().bodyPain.travel;
          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        }

        break;

      case PainEventsCategory.Sleep:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Sleep;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;
          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.sleep.updateFrom(eventData);
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        } else {
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;

          setSelectedPainEventCategory = PainEventsCategory.Sleep;
          categoriesData.bodyPain.sleep = DataInitializations.categoriesData().bodyPain.sleep;
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        }
        break;

      case PainEventsCategory.Intimacy:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Intimacy;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;
          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.sex.updateFrom(eventData);
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        } else {
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;
          setSelectedPainEventCategory = PainEventsCategory.Intimacy;
          categoriesData.bodyPain.sex = DataInitializations.categoriesData().bodyPain.sex;

          AppNavigation.navigateTo(
            AppRoutes.painEventEdit,
          );
          notifyListeners();
        }

        break;

      case PainEventsCategory.Work:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Work;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;
          categoriesData.bodyPain.selectedBodyParts = HelperFunctions.getMatchingBodyParts(eventData!, availableBodyParts);
          categoriesData.bodyPain.work.updateFrom(eventData);
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        } else {
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;
          setSelectedPainEventCategory = PainEventsCategory.Work;
          categoriesData.bodyPain.work = DataInitializations.categoriesData().bodyPain.work;
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        }

        break;

      case PainEventsCategory.Headache:
        if (mode != null && mode == EventPanelMode.edit) {
          setSelectedPainEventCategory = PainEventsCategory.Headache;
          categoriesData.bodyPain.editingBodyPartsEnabled = false;
          categoriesData.bodyPain.isEditing = true;
          // categoriesData.bodyPain.headache.updateFrom(eventData!);
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        } else {
          categoriesData.bodyPain.editingBodyPartsEnabled = true;
          categoriesData.bodyPain.isEditing = false;
          setSelectedPainEventCategory = PainEventsCategory.Headache;
          categoriesData.bodyPain.headache = DataInitializations.categoriesData().bodyPain.headache;
          AppNavigation.navigateTo(AppRoutes.painEventEdit);
          notifyListeners();
        }

        break;
      case PainEventsCategory.Urination:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void handleEventOptionSelection(PainEventsCategory event, OptionModel selectedOption, [int? subCategoryIndex, int? impactLevel]) {
    switch (event) {
      case PainEventsCategory.Existing:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.justExisting.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();
            break;
          case 1:
            categoriesData.bodyPain.justExisting.painLevel = int.parse(selectedOption.text);
            notifyListeners();
            break;
          case 2:
            for (var option in categoriesData.bodyPain.justExisting.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 3:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.justExisting.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.justExisting.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.justExisting.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.justExisting.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Toilet:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.toilet.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();

            break;
          case 1:
            for (var option in categoriesData.bodyPain.toilet.conditions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;

          case 2:
            categoriesData.bodyPain.toilet.painLevel = int.parse(selectedOption.text);
            notifyListeners();

            break;
          case 3:
            for (var option in categoriesData.bodyPain.toilet.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.toilet.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.toilet.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.toilet.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.toilet.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Travel:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.travel.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();

            break;
          case 1:
            for (var option in categoriesData.bodyPain.travel.conditions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 2:
            categoriesData.bodyPain.travel.painLevel = int.parse(selectedOption.text);
            notifyListeners();

            break;
          case 3:
            for (var option in categoriesData.bodyPain.travel.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.travel.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.travel.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.travel.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.travel.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Exercise:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.exercise.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();

            break;
          case 1:
            categoriesData.bodyPain.exercise.painLevel = int.parse(selectedOption.text);
            notifyListeners();

            break;
          case 2:
            for (var option in categoriesData.bodyPain.exercise.cardio) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 3:
            for (var option in categoriesData.bodyPain.exercise.strengthTraining) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;

          case 4:
            for (var option in categoriesData.bodyPain.exercise.flexibilityAndBalance) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;

          case 5:
            for (var option in categoriesData.bodyPain.exercise.sports) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;

          case 6:
            for (var option in categoriesData.bodyPain.exercise.others) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;

          case 7:
            for (var option in categoriesData.bodyPain.exercise.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 8:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.exercise.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.exercise.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.exercise.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.exercise.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Sleep:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.sleep.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();

            break;
          case 1:
            for (var option in categoriesData.bodyPain.sleep.conditions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 2:
            categoriesData.bodyPain.sleep.painLevel = int.parse(selectedOption.text);
            notifyListeners();

            break;
          case 3:
            for (var option in categoriesData.bodyPain.sleep.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.sleep.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.sleep.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.sleep.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.sleep.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Intimacy:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.sex.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();
            break;
          case 1:
            for (var option in categoriesData.bodyPain.sex.experience) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();
            break;

          case 2:
            for (var option in categoriesData.bodyPain.sex.activity) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 3:
            categoriesData.bodyPain.sex.painLevel = int.parse(selectedOption.text);
            notifyListeners();

            break;
          case 4:
            for (var option in categoriesData.bodyPain.sex.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 5:
            for (var option in categoriesData.bodyPain.sex.intimacyType) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 6:
            for (var option in categoriesData.bodyPain.sex.toolType) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 7:
            for (var option in categoriesData.bodyPain.sex.climaxType) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 8:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.sex.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.sex.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.sex.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.sex.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;
      case PainEventsCategory.Eating:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.eating.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();

            break;
          case 1:
            for (var option in categoriesData.bodyPain.eating.conditions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 2:
            categoriesData.bodyPain.eating.painLevel = int.parse(selectedOption.text);
            notifyListeners();
            break;
          case 3:
            for (var option in categoriesData.bodyPain.eating.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.eating.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.eating.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.eating.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.eating.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Work:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.work.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();
            break;
          case 1:
            for (var option in categoriesData.bodyPain.work.describeWorkDay) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 2:
            categoriesData.bodyPain.work.painLevel = int.parse(selectedOption.text);
            notifyListeners();

            break;
          case 3:
            for (var option in categoriesData.bodyPain.work.feelsLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.work.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.work.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.work.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.work.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;

      case PainEventsCategory.Headache:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.bodyPain.headache.painTimeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();
            break;
          case 1:
            categoriesData.bodyPain.headache.painLevel = int.parse(selectedOption.text);
            notifyListeners();
            break;
          case 2:
            for (var option in categoriesData.bodyPain.headache.feltLikeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 3:
            for (var option in categoriesData.bodyPain.headache.locationOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            for (var option in categoriesData.bodyPain.headache.typeOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 5:
            for (var option in categoriesData.bodyPain.headache.onsetOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = true;
              } else {
                option.isSelected = false;
              }
            }
            notifyListeners();
            break;
          case 6:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.headache.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social life":
                categoriesData.bodyPain.headache.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.headache.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of life":
                categoriesData.bodyPain.headache.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;
      case PainEventsCategory.Urination:
        switch (subCategoryIndex) {
          case 0:
            for (var option in categoriesData.urinationUrgency.sensationOptions) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 1:
            categoriesData.urinationUrgency.urinationUrgencyLevel = int.parse(selectedOption.text);
            notifyListeners();
            break;
          case 2:
            for (var option in categoriesData.urinationUrgency.complications) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 3:
            for (var option in categoriesData.urinationUrgency.complications) {
              if (option.text == selectedOption.text) {
                option.isSelected = !option.isSelected;
              }
            }
            notifyListeners();
            break;
          case 4:
            switch (selectedOption.text) {
              case "Work":
                categoriesData.bodyPain.urination.impactGrid.workValue = impactLevel!;
                notifyListeners();
                break;
              case "Social Life":
                categoriesData.bodyPain.urination.impactGrid.socialLifeValue = impactLevel!;
                notifyListeners();
                break;
              case "Sleep":
                categoriesData.bodyPain.urination.impactGrid.sleepValue = impactLevel!;
                notifyListeners();
                break;
              case "Quality of Life":
                categoriesData.bodyPain.urination.impactGrid.qualityOfLifeValue = impactLevel!;
                notifyListeners();
                break;
            }
        }
        break;
    }
  }

  Future<void> consultBackendForCompletedCategories({bool? showLoader}) async {
    if (showLoader ?? true) CustomLoading.showLoadingIndicator();
    final result = await DailyTrackerService.fetchAllCompletedCategoriesByDate(selectedDateOfUserForTracking.date);

    result.fold(
      (l) {
        if (showLoader ?? true) CustomLoading.hideLoadingIndicator();
      },
      (r) {
        List<Data?> categories = [r.thingsExperience, r.symptoms, r.thingsPutInBody, r.intimacyAndFertility, r.bathroomHabits, r.wellbeing];
        setDailyTrackerViewMode = categories.any((field) => field != null);
        categoriestNotes = r.notes ?? DailyTrackerNotes();
        filledCategoryTimes = {
          "Things I’m experiencing": r.thingsExperience,
          "Symptoms": r.symptoms,
          "Things I put in my body": r.thingsPutInBody,
          "Intimacy & fertility": r.intimacyAndFertility,
          "Bathroom habits": r.bathroomHabits,
          "Wellbeing": r.wellbeing,
        }.entries.where((entry) => entry.value != null).fold<Map<String, Data?>>({}, (acc, entry) {
          acc[entry.key] = entry.value;
          return acc;
        });

        if (showLoader ?? true) CustomLoading.hideLoadingIndicator();

        notifyListeners();
      },
    );
    notifyListeners();
  }

  SymptomCategoriesModel categoriesData = DataInitializations.categoriesData();
  final List<CategoriesData> eventsAndThingsIdo = DataInitializations.eventsAndThingsIdo;

  List<CategoriesData> painAndBleedingCategories = DataInitializations.painAndBleedingCategories;
  List<CategoriesData> symptomsCategories = DataInitializations.symptomsCategories;
  List<CategoriesData> thingsPutinBody = DataInitializations.thingsPutinBody;
  List<CategoriesData> bathroomHabits = DataInitializations.bathroomHabits;
  List<CategoriesData> fertilityAndPregnancy = DataInitializations.fertilityAndPregnancy;
  List<CategoriesData> eventCategories = DataInitializations.eventCategories;
  List<CategoriesData> wellbeing = DataInitializations.wellbeing;

  Future<UserProfileModel> fetchUserProfile({bool? showLoader}) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    if (showLoader ?? true) CustomLoading.showLoadingIndicator();
    final completer = Completer<UserProfileModel>();
    var result = await EditProfileService.fetchUserProfileFromApi(userId!);
    result.fold(
          (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        if (showLoader ?? true) CustomLoading.hideLoadingIndicator();
        completer.completeError(l);
      },
          (r) async {
        if (showLoader ?? true) CustomLoading.hideLoadingIndicator();
        UserProfileModel userData = r;

        painAndBleedingCategories =
            List.from(DataInitializations.painAndBleedingCategories);
        symptomsCategories =
            List.from(DataInitializations.symptomsCategories);
        thingsPutinBody =
            List.from(DataInitializations.thingsPutinBody);
        bathroomHabits =
            List.from(DataInitializations.bathroomHabits);
        fertilityAndPregnancy =
            List.from(DataInitializations.fertilityAndPregnancy);
        eventCategories =
            List.from(DataInitializations.eventCategories);
        wellbeing =
            List.from(DataInitializations.wellbeing);

        if (userData.symptomTrackingPreferences != null) {
          userData.symptomTrackingPreferences!.forEach((key, isEnabled) {

            switch (key) {
              case "pain":
              // Handle pain
                if(!isEnabled)
                  {
                    painAndBleedingCategories.removeWhere((cat) {
                      return cat.title == "Body Pain";
                    });
                  }

                setTrackingItemState(isEnabled, "Pain");

                break;

              case "bleeding":
              // Handle bleeding
                if(!isEnabled)
                {
                  painAndBleedingCategories.removeWhere((cat) {
                    return cat.title == "Bleeding";
                  });
                }
                setTrackingItemState(isEnabled, "Bleeding");
                break;

              case "headache":
              // Handle headache
                if(!isEnabled)
                {
                  painAndBleedingCategories.removeWhere((cat) {
                    return cat.title == "Headache";
                  });
                }
                setTrackingItemState(isEnabled, "Headache");
                break;

              case "mood":
              // Handle mood
                if(!isEnabled)
                {
                  painAndBleedingCategories.removeWhere((cat) {
                    return cat.title == "Mood";
                  });
                }
                setTrackingItemState(isEnabled, "Mood");
                break;

              case "stress":
              // Handle stress
                if(!isEnabled)
                {
                  painAndBleedingCategories.removeWhere((cat) {
                    return cat.title == "Stress";
                  });
                }
                setTrackingItemState(isEnabled, "Stress");
                break;

              case "energy":
              // Handle energy
                if(!isEnabled)
                {
                  painAndBleedingCategories.removeWhere((cat) {
                    return cat.title == "Energy";
                  });
                }
                setTrackingItemState(isEnabled, "Energy");
                break;

              case "nausea":
              // Handle nausea
                if(!isEnabled)
                {
                  symptomsCategories.removeWhere((cat) {
                    return cat.title == "Nausea";
                  });
                }
                setTrackingItemState(isEnabled, "Nausea");
                break;

              case "fatigue":
              // Handle fatigue
                if(!isEnabled)
                {
                  symptomsCategories.removeWhere((cat) {
                    return cat.title == "Fatigue";
                  });
                }
                setTrackingItemState(isEnabled, "Fatigue");
                break;

              case "bloating":
              // Handle bloating
                if(!isEnabled)
                {
                  symptomsCategories.removeWhere((cat) {
                    return cat.title == "Bloating";
                  });
                }
                setTrackingItemState(isEnabled, "Bloating");
                break;

              case "brainfog":
              // Handle brain fog
                if(!isEnabled)
                {
                  symptomsCategories.removeWhere((cat) {
                    return cat.title == "Brain fog";
                  });
                }
                setTrackingItemState(isEnabled, "Brain fog");
                break;

              case "painkillers":
              // Handle painkiller
                if(!isEnabled)
                {
                  thingsPutinBody.removeWhere((cat) {
                    return cat.title == "Painkillers";
                  });
                }
                setTrackingItemState(isEnabled, "Painkillers");
                break;

              case "hormones":
              // Handle hormone
                if(!isEnabled)
                {
                  thingsPutinBody.removeWhere((cat) {
                    return cat.title == "Hormones";
                  });
                }
                setTrackingItemState(isEnabled, "Hormones");
                break;

              case "alcohol":
              // Handle alcohol
                if(!isEnabled)
                {
                  thingsPutinBody.removeWhere((cat) {
                    return cat.title == "Alcohol";
                  });
                }
                setTrackingItemState(isEnabled, "Alcohol");
                break;

              case "bowelmovement":
              // Handle bowel movement
                if(!isEnabled)
                {
                  bathroomHabits.removeWhere((cat) {
                    return cat.title == "Bowel movement";
                  });
                }
                setTrackingItemState(isEnabled, "Bowel movement");
                break;

              case "urination":
              // Handle urination
                if(!isEnabled)
                {
                  bathroomHabits.removeWhere((cat) {
                    return cat.title == "Urination";
                  });
                }
                setTrackingItemState(isEnabled, "Urination");
                break;

              case "movement":
              // Handle movement
                if(!isEnabled)
                {
                  wellbeing.removeWhere((cat) {
                    return cat.title == "Movement";
                  });
                }
                setTrackingItemState(isEnabled, "Movement");
                break;

              case "selfcare":
              // Handle self care
                if(!isEnabled)
                {
                  wellbeing.removeWhere((cat) {
                    return cat.title == "Self-care";
                  });
                }
                setTrackingItemState(isEnabled, "Self-care");
                break;

              case "painrelief":
              // Handle pain relief
                if(!isEnabled)
                {
                  wellbeing.removeWhere((cat) {
                    return cat.title == "Pain relief";
                  });
                }
                setTrackingItemState(isEnabled, "Pain relief");
                break;

              case "intimacy":
              // Handle intimacy
                if(!isEnabled)
                {
                  fertilityAndPregnancy.removeWhere((cat) {
                    return cat.title == "Intimacy";
                  });
                }
                setTrackingItemState(isEnabled, "Intimacy");
                break;

              case "ovulationtest":
              // Handle ovulation test
                if(!isEnabled)
                {
                  fertilityAndPregnancy.removeWhere((cat) {
                    return cat.title == "Ovulation test";
                  });
                }
                setTrackingItemState(isEnabled, "Ovulation test");
                break;

              case "pregnancytest":
              // Handle pregnancy test
                if(!isEnabled)
                {
                  fertilityAndPregnancy.removeWhere((cat) {
                    return cat.title == "Pregnancy test";
                  });
                }

                setTrackingItemState(isEnabled, "Pregnancy test");
                break;

              default:
              // Unknown or new symptom (safe fallback)
                break;
            }
          });
        }


        completer.complete(r);
        notifyListeners();
      },
    );

    return completer.future;
  }

  void setTrackingItemState(bool isEnabled, String title) {
    final TrackingItem? item = categories
        .expand((category) => category.items)
        .firstWhere(
          (ti) => ti.title == title,
    );

    if (item != null) {
      item.isEnabled = isEnabled;
    }
  }


  Future<void> patchSaveUserTrackingPreferences(BuildContext context) async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    String? userProfileJson = await SharedPreferencesHelper.getStringPrefValue(key: "userProfile");
    if (userProfileJson != null) {
      UserProfileModel userProfile = UserProfileModel.fromJson(jsonDecode(userProfileJson));
      userProfile.symptomTrackingPreferences = buildSymptomTrackingPreferences(categories);
      // CustomLoading.showLoadingIndicator();
      var result = await EditProfileService.updateUserProfileFromApi(
          UserProfileModel(
              firstName: userProfile.firstName,
              lastName: userProfile.lastName,
              email: userProfile.email,
              phoneNum: userProfile.phoneNum,
              dob: userProfile.dob,
              symptomTrackingPreferences: userProfile.symptomTrackingPreferences),
          userId!);
      result.fold(
        (l) {
          HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
          // CustomLoading.hideLoadingIndicator();
        },
        (r) async {
          // CustomLoading.hideLoadingIndicator();
          //await HelperFunctions.showNotification(AppNavigation.currentContext!, "Profile Updated Successfully");
        },
      );
    }
  }

  Map<String, bool> buildSymptomTrackingPreferences(
    List<TrackingCategory> categories,
  ) {
    final Map<String, bool> result = {};

    for (final category in categories) {
      for (final item in category.items) {
        final key = item.title.toLowerCase().replaceAll(' ', '').replaceAll('&', '').replaceAll(RegExp(r'[^a-z0-9]'), '');

        result[key] = item.isEnabled;
      }
    }

    return result;
  }
}

class CategoryTracker {
  String name;
  bool filled;
  String image;
  CategoryTracker({required this.name, required this.filled, required this.image});
}
