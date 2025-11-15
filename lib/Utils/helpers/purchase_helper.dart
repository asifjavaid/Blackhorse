import 'dart:developer';
import 'dart:io' show Platform;
import 'package:ekvi/Models/InAppPurchase/iap_amplitude_events.dart';
import 'package:ekvi/Models/InAppPurchase/iap_model.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:ekvi/Utils/constants/config.dart';
import 'package:ekvi/Core/di/user_singleton.dart';

class PurchasesHelper {
  static final PurchasesHelper _instance = PurchasesHelper._internal();

  factory PurchasesHelper() => _instance;

  PurchasesHelper._internal();

  final UserManager _userManager = UserManager();
  List<Package> _availablePackages = [];

  Future<void> initialize() async {
    try {
      await _initializeSDK();
    } on PlatformException catch (e) {
      _handlePurchasesError(e);
    }
  }

  Future<void> _initializeSDK() async {
    String? userId = _userManager.userId;
    if (userId == null) {
      log("Preventing Initialization of SDK as the userID is null");
      return;
    }

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setLogHandler((level, text) {
      log("$level $text");
    });
    PurchasesConfiguration configuration;
    log("Initializing SDK with userID $userId");

    if (Platform.isIOS) {
      configuration = PurchasesConfiguration(Config.revenuecatIOSApiKey)
        ..appUserID = userId
        ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat();
    } else if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(Config.revenuecatAndroidApiKey)
        ..appUserID = userId
        ..purchasesAreCompletedBy = const PurchasesAreCompletedByRevenueCat();
    } else {
      throw PlatformException(
        code: "UnsupportedPlatform",
        message: "The current platform is not supported for RevenueCat purchases.",
      );
    }

    await Purchases.configure(configuration);
  }

  Future<List<Package>> fetchAvailablePackages() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        _availablePackages = offerings.current!.availablePackages;
      } else {
        _availablePackages = [];
      }
      return _availablePackages;
    } catch (e) {
      return [];
    }
  }

  Future<List<PackageWithEligibility>> fetchPackagesWithEligibility() async {
    try {
      List<Package> availablePackages = await fetchAvailablePackages();

      // Get product identifiers
      List<String> productIdentifiers = availablePackages.map((package) => package.storeProduct.identifier).toList();

      // Check eligibility
      Map<String, IntroEligibility> eligibilityMap = await checkTrialOrIntroEligibility(productIdentifiers);

      // Create list of packages with eligibility
      List<PackageWithEligibility> packagesWithEligibility = availablePackages.map((package) {
        IntroEligibility? eligibility = eligibilityMap[package.storeProduct.identifier];
        return PackageWithEligibility(package: package, eligibility: eligibility);
      }).toList();

      return packagesWithEligibility;
    } catch (e) {
      _handleError("Error fetching packages with eligibility: $e");
      return [];
    }
  }

  Future<Map<String, IntroEligibility>> checkTrialOrIntroEligibility(List<String> productIdentifiers) async {
    try {
      return await Purchases.checkTrialOrIntroductoryPriceEligibility(productIdentifiers);
    } catch (e) {
      _handleError("Error checking trial or introductory eligibility: $e");
      return {};
    }
  }

  Future<CustomerInfo?> purchasePackage(Package package) async {
    try {
      return await Purchases.purchasePackage(package);
    } on PlatformException catch (e) {
      _handlePurchasesError(e);
      rethrow;
    }
  }

  Future<CustomerInfo?> restorePurchases() async {
    try {
      return await Purchases.restorePurchases();
    } on PlatformException catch (e) {
      _handlePurchasesError(e);
      rethrow;
    }
  }

  Future<CustomerInfo> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } on PlatformException catch (e) {
      _handlePurchasesError(e);
      rethrow;
    }
  }

  Future<EntitlementInfo?> getCurrentEntitlement() async {
    try {
      CustomerInfo customerInfo = await getCustomerInfo();
      if (customerInfo.entitlements.active.isNotEmpty) {
        return customerInfo.entitlements.all[Config.empower];
      }
      return null;
    } catch (e) {
      _handleError("Error retrieving current entitlement: ${e.toString()}");
      rethrow;
    }
  }

  void _handleError(String? message) {
    if (message != null) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, message);
    }
  }

  String _handlePurchasesError(PlatformException e) {
    PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
    String errorMessage;
    switch (errorCode) {
      case PurchasesErrorCode.unknownError:
      case PurchasesErrorCode.unknownBackendError:
      case PurchasesErrorCode.unknownNonNativeError:
        errorMessage = "An unknown error occurred. Please try again later.";
        break;
      case PurchasesErrorCode.purchaseCancelledError:
        errorMessage = "Purchase was cancelled.";
        break;
      case PurchasesErrorCode.storeProblemError:
        errorMessage = "There was a problem with the App Store or Play Store. Please try again later.";
        break;
      case PurchasesErrorCode.purchaseNotAllowedError:
        errorMessage = "Purchases are not allowed on this device.";
        break;
      case PurchasesErrorCode.purchaseInvalidError:
        errorMessage = "Purchase invalid. Please check your payment method or try again.";
        break;
      case PurchasesErrorCode.productNotAvailableForPurchaseError:
        errorMessage = "This product is not available for purchase.";
        break;
      case PurchasesErrorCode.productAlreadyPurchasedError:
        errorMessage = "This product has already been purchased.";
        break;
      case PurchasesErrorCode.receiptAlreadyInUseError:
      case PurchasesErrorCode.receiptInUseByOtherSubscriberError:
        errorMessage = "This purchase is already associated with another account.";
        break;
      case PurchasesErrorCode.invalidReceiptError:
        errorMessage = "Invalid purchase receipt. Please try restoring purchases.";
        break;
      case PurchasesErrorCode.missingReceiptFileError:
        errorMessage = "Purchase receipt is missing. Please try restoring purchases.";
        break;
      case PurchasesErrorCode.networkError:
      case PurchasesErrorCode.apiEndpointBlocked:
        errorMessage = "Network error. Please check your internet connection and try again.";
        break;
      case PurchasesErrorCode.invalidCredentialsError:
        errorMessage = "Invalid credentials. Please contact support.";
        break;
      case PurchasesErrorCode.unexpectedBackendResponseError:
        errorMessage = "Unexpected response from the server. Please try again later.";
        break;
      case PurchasesErrorCode.invalidAppUserIdError:
        errorMessage = "Invalid user ID. Please contact support.";
        break;
      case PurchasesErrorCode.operationAlreadyInProgressError:
        errorMessage = "Another operation is already in progress. Please wait and try again.";
        break;
      case PurchasesErrorCode.invalidAppleSubscriptionKeyError:
        errorMessage = "Invalid Apple subscription key. Please contact support.";
        break;
      case PurchasesErrorCode.ineligibleError:
        errorMessage = "You are not eligible for this purchase.";
        break;
      case PurchasesErrorCode.insufficientPermissionsError:
        errorMessage = "The app does not have sufficient permissions to make purchases.";
        break;
      case PurchasesErrorCode.paymentPendingError:
        errorMessage = "Payment is pending. Please wait until the payment is completed.";
        break;
      case PurchasesErrorCode.invalidSubscriberAttributesError:
        errorMessage = "Invalid subscriber attributes. Please contact support.";
        break;
      case PurchasesErrorCode.logOutWithAnonymousUserError:
        errorMessage = "Cannot log out anonymous user.";
        break;
      case PurchasesErrorCode.configurationError:
        errorMessage = "Configuration error. Please contact support.";
        break;
      case PurchasesErrorCode.unsupportedError:
        errorMessage = "This operation is not supported.";
        break;
      case PurchasesErrorCode.emptySubscriberAttributesError:
        errorMessage = "No subscriber attributes found.";
        break;
      case PurchasesErrorCode.productDiscountMissingIdentifierError:
        errorMessage = "Product discount identifier is missing.";
        break;
      case PurchasesErrorCode.productDiscountMissingSubscriptionGroupIdentifierError:
        errorMessage = "Product is missing a subscription group identifier.";
        break;
      case PurchasesErrorCode.customerInfoError:
        errorMessage = "There was a problem retrieving customer information.";
        break;
      case PurchasesErrorCode.systemInfoError:
        errorMessage = "A system error occurred. Please try again later.";
        break;
      case PurchasesErrorCode.beginRefundRequestError:
        errorMessage = "Error initiating refund request.";
        break;
      case PurchasesErrorCode.productRequestTimeout:
        errorMessage = "Product request timed out. Please try again.";
        break;
      case PurchasesErrorCode.invalidPromotionalOfferError:
        errorMessage = "Invalid promotional offer. Please contact support.";
        break;
      case PurchasesErrorCode.offlineConnectionError:
        errorMessage = "No internet connection. Please check your connection and try again.";
        break;
      default:
        errorMessage = "An unknown error occurred. Please try again later.";
        break;
    }

    PurchaseErrorEvent(errorMessage: errorMessage).log();
    _handleError(errorMessage);
    return errorMessage;
  }

  PackageOfferInfo getPackageOfferInfo(PackageWithEligibility pwe) {
    final Package package = pwe.package;
    final IntroEligibility? eligibility = pwe.eligibility;
    final IntroductoryPrice? introPrice = package.storeProduct.introductoryPrice;

    OfferType offerType = OfferType.regular;

    bool isEligibleForIntroOffer = eligibility != null && eligibility.status == IntroEligibilityStatus.introEligibilityStatusEligible && introPrice != null;

    if (isEligibleForIntroOffer) {
      if (introPrice.price == 0.0) {
        offerType = OfferType.freeTrial;
      } else if (introPrice.price > 0.0) {
        offerType = OfferType.discountedIntroOffer;
      }
    }

    return PackageOfferInfo(
      package: package,
      eligibility: eligibility,
      offerType: offerType,
    );
  }
}
