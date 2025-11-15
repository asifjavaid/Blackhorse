import 'dart:async';

import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/EditProfile/edit_profile_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  UserProfileModel userData = UserProfileModel();
  DateTime userDateOfBirth = DateTime.now();
  bool enableButton = false;

  void setDateOfBirth(DateTime date) {
    userDateOfBirth = date;
    enableButton = true;

    notifyListeners();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (firstNameController.text != (userData.firstName ?? "") ||
        lastNameController.text != (userData.lastName ?? "") ||
        emailController.text != (userData.email ?? "") ||
        phoneController.text != (userData.phoneNum ?? "")) {
      enableButton = true;
    } else {
      enableButton = false;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void clear() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
  }

  void addListenersToForm() {
    firstNameController.addListener(_onTextChanged);
    lastNameController.addListener(_onTextChanged);
    emailController.addListener(_onTextChanged);
    phoneController.addListener(_onTextChanged);
    enableButton = false;
    notifyListeners();
  }

  void removeListenersFromForm() {
    firstNameController.removeListener(_onTextChanged);
    lastNameController.removeListener(_onTextChanged);
    emailController.removeListener(_onTextChanged);
    phoneController.removeListener(_onTextChanged);
    enableButton = false;
    clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> setAll(String? firstName, String? lastName, String? email, String? phone, String? dateOfBirth) async {
    firstNameController.text = firstName ?? "";
    lastNameController.text = lastName ?? "";
    emailController.text = email ?? "";
    phoneController.text = phone ?? "";
    userDateOfBirth = (dateOfBirth != null && dateOfBirth.isNotEmpty) ? DateFormat('dd/MM/yy').parse(dateOfBirth) : userDateOfBirth;
    notifyListeners();
  }

  String get firstName => firstNameController.text;
  String get lastName => lastNameController.text;
  String get email => emailController.text;
  String get phone => phoneController.text;
  String get dateOfBirth => DateFormat("dd/MM/yy").format(userDateOfBirth);

  Future<void> saveUserProfileToStorage(UserProfileModel profile) async {
    await SharedPreferencesHelper.setMapPrefValue(key: "userProfile", value: profile.toJson());
  }

  // fetch User Profile from API
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
        await setAll(r.firstName, r.lastName, r.email, r.phoneNum, r.dob);
        userData = r;
        await saveUserProfileToStorage(r);
        addListenersToForm();
        completer.complete(r);
        notifyListeners();
      },
    );

    return completer.future;
  }

  // update User Profile from API
  Future<void> updateUserProfile() async {
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    CustomLoading.showLoadingIndicator();
    var result = await EditProfileService.updateUserProfileFromApi(
        UserProfileModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNum: phone,
          dob: dateOfBirth,
        ),
        userId!);
    result.fold(
      (l) {
        HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
        CustomLoading.hideLoadingIndicator();
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();
        await HelperFunctions.showNotification(AppNavigation.currentContext!, "Profile Updated Successfully");
        var sideNavManagerProvider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);
        sideNavManagerProvider.onSelected(MenuItems(AppNavigation.currentContext!).bottomNavManager);
        await fetchUserProfile(showLoader: false);
      },
    );
  }
}
