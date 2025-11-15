import 'dart:developer';

import 'package:ekvi/Core/di/user_singleton.dart';
import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Models/InAppPurchase/iap_model.dart';
import 'package:ekvi/Models/Notifications/ekvipedia_notification_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Services/Notifications/notifications_service.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/constants/config.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Utils/helpers/intercom_helper.dart';
import 'package:ekvi/Utils/helpers/purchase_helper.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionProvider with ChangeNotifier {
  final PurchasesHelper _purchasesHelper = PurchasesHelper();
  final UserManager _userManager = UserManager();

  Package? _selectedPackage;
  Package get selectedPackage =>
      _selectedPackage ??
      (_availablePackages.isNotEmpty ? _availablePackages.first : null)!;

  Package? _currentPackage;
  Package? get currentPackage => _currentPackage;

  EntitlementInfo? _currentEntitlement;
  EntitlementInfo? get currentEntitlement => _currentEntitlement;

  List<Package> _availablePackages = [];
  List<Package> get availablePackages => _availablePackages;

  List<PackageOfferInfo> _packageOfferInfos = [];
  List<PackageOfferInfo> get packageOfferInfos => _packageOfferInfos;

  bool get isFreeTrialUI => packageOfferInfos.every(
      (packageOfferInfo) => packageOfferInfo.offerType == OfferType.freeTrial);

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _showBillingIssueBanner = false;
  bool get showBillingIssueBanner => _showBillingIssueBanner;

  Future<void> initializeSubscription() async {
    try {
      await _fetchAndInitializePackages();
      _setCustomerInfoUpdateListener();
    } catch (e) {
      _handleError("Failed to initialize purchases: ${e.toString()}");
    }
  }

  void _setCustomerInfoUpdateListener() {
    Purchases.addCustomerInfoUpdateListener(_onCustomerInfoUpdated);
  }

  void _onCustomerInfoUpdated(CustomerInfo customerInfo) {
    _handleCustomerInfoUpdate(customerInfo);
  }

  Future<void> _handleCustomerInfoUpdate(CustomerInfo customerInfo) async {
    log("Customer Info Updated: ${customerInfo.entitlements.toJson()}");
    try {
      await _checkProStatus(customerInfo);
      await _initializeCurrentPackage(customerInfo);
      await _initializeEntitlement(customerInfo);
      _checkForBillingIssue();
      await _updateUserIntercomInformation();
      notifyListeners();
    } catch (e) {
      _handleError("Error handling customer info update: ${e.toString()}");
    }
  }

  void _checkForBillingIssue() {
    if (_currentEntitlement != null && _currentEntitlement!.isActive) {
      _showBillingIssueBanner =
          _currentEntitlement!.billingIssueDetectedAt != null;
    } else {
      _showBillingIssueBanner = false;
    }
  }

  Future<void> _checkProStatus(CustomerInfo customerInfo) async {
    bool proStatus =
        customerInfo.entitlements.all[Config.empower]?.isActive ?? false;
    await _userManager.updatePremiumStatus(isPremium: proStatus);
  }

  Future<void> _initializeCurrentPackage(CustomerInfo customerInfo) async {
    if (_availablePackages.isNotEmpty) {
      String? activeSubscriptionId = customerInfo.activeSubscriptions.isNotEmpty
          ? customerInfo.activeSubscriptions.first
          : null;

      _currentPackage = activeSubscriptionId != null
          ? _availablePackages.firstWhere(
              (package) =>
                  package.storeProduct.identifier == activeSubscriptionId,
              orElse: () => _availablePackages.first,
            )
          : null;
    }
  }

  Future<void> _initializeEntitlement(CustomerInfo customerInfo) async {
    _currentEntitlement = customerInfo.entitlements.all[Config.empower];
  }

  Future<void> _updateUserIntercomInformation() async {
    try {
      await IntercomHelper.updateUserProfileWithSubscription(
        package: currentPackage,
        entitlement: currentEntitlement,
      );
    } catch (e) {
      _errorMessage =
          "Error updating user information through Intercom: ${e.toString()}";
      log(_errorMessage!);
    }
  }

  Future<void> _fetchAndInitializePackages() async {
    try {
      List<PackageWithEligibility> packagesWithEligibility =
          await _purchasesHelper.fetchPackagesWithEligibility();

      _packageOfferInfos = packagesWithEligibility
          .map(_purchasesHelper.getPackageOfferInfo)
          .toList();

      _availablePackages =
          _packageOfferInfos.map((poi) => poi.package).toList();
      if (_availablePackages.isNotEmpty) {
        _selectedPackage = _availablePackages.first;
      }
    } catch (e) {
      _handleError("Error fetching and initializing packages: ${e.toString()}");
    }
  }

  Future<void> packageSelection(Package package) async {
    _selectedPackage = package;
    notifyListeners();
  }

  Future<void> purchasePackage(VoidCallback? navigationCallback) async {
    try {
      CustomLoading.showLoadingIndicator();
      if (_selectedPackage != null) {
        PurchaseStartedEvent(productId: selectedPackage.identifier).log();
        await _purchasesHelper.purchasePackage(_selectedPackage!);
        PurchaseSuccessfulEvent(productId: selectedPackage.identifier).log();
        CustomLoading.hideLoadingIndicator();
        AppNavigation.navigateTo(AppRoutes.subscriptionWelcome,
            arguments: ScreenArguments(navigationCallback: navigationCallback));
      } else {
        CustomLoading.hideLoadingIndicator();
        String errorMessage =
            "Please select a package to proceed with purchase.";
        _handleError(errorMessage);
      }
    } on Exception catch (e) {
      CustomLoading.hideLoadingIndicator();
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      _handleError(errorMessage);
    } catch (e) {
      CustomLoading.hideLoadingIndicator();
      String errorMessage = "An unexpected error occurred: ${e.toString()}";
      _handleError(errorMessage);
    }
  }

  Future<void> restorePurchases() async {
    try {
      CustomerInfo? customerInfo = await _purchasesHelper.restorePurchases();

      if (customerInfo != null &&
          customerInfo.entitlements.all[Config.empower]?.isActive == true) {
        await _handleCustomerInfoUpdate(customerInfo);
        AppNavigation.navigateTo(AppRoutes.subscriptionWelcome);
      } else {
        _notifyUser("No previous purchases were found to restore.");
      }
    } on Exception catch (e) {
      String errorMessage = e.toString().replaceFirst('Exception: ', '');
      _handleError(errorMessage);
    } catch (e) {
      String errorMessage = "An unexpected error occurred: ${e.toString()}";
      _handleError(errorMessage);
    }
  }

  void _handleError(String? message) {
    _errorMessage = message;
    log(message ?? "Unknown error");

    notifyListeners();
  }

  void _notifyUser(String message) {
    HelperFunctions.showNotification(
      AppNavigation.currentContext!,
      message,
    );
  }

  Future<void> setPurchaseReminders(bool allow) async {
    final userManager = UserManager();
    final email = userManager.email;
    final userId = userManager.userId;

    if (email == null || userId == null) {
      return;
    }

    CustomLoading.showLoadingIndicator();
    try {
      final preferences = NotificationPreferences(
        subscriptionRenewal: allow,
        trialPeriodEnding: allow,
      );

      final userPrefs = UserNotificationPreferences(
        email: email,
        notificationPreferences: preferences,
      );

      final result =
          await NotificationsService.updateNotificationApi(userPrefs, userId);

      result.fold(
        (error) {
          HelperFunctions.showNotification(
              AppNavigation.currentContext!, AppConstant.exceptionMessage);
          AppNavigation.goBack();
        },
        (data) {
          AppNavigation.goBack();
        },
      );
    } catch (e) {
      // Handle any unexpected exceptions
      log('An exception occurred while updating purchase reminder preferences: $e');
    } finally {
      CustomLoading.hideLoadingIndicator();
    }
  }

  void allowSendingPurchaseReminders() {
    setPurchaseReminders(true);
  }

  void disAllowSendingPurchaseReminders() {
    setPurchaseReminders(false);
  }

  @override
  void dispose() {
    Purchases.removeCustomerInfoUpdateListener(_onCustomerInfoUpdated);
    super.dispose();
  }
}
