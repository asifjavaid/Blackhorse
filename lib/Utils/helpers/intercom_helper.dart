import 'dart:developer';
import 'package:ekvi/Models/EditProfle/user_profile_model.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

class IntercomHelper {
  static void loadIntercom() async {
    await Intercom.instance.initialize(AppConstant.intercomApplicationID, iosApiKey: AppConstant.intercomIOSApiKey, androidApiKey: AppConstant.intercomAndroidApiKey);
  }

  static Future<void> initializeIntercomUser(UserProfileModel userProfile) async {
    if (userProfile.id != null) {
      await Intercom.instance.loginIdentifiedUser(userId: userProfile.id);
      await Intercom.instance.updateUser(email: userProfile.email);
    } else {
      await Intercom.instance.loginUnidentifiedUser();
    }
  }

  static Future<void> updateUserProfileWithSubscription({
    required Package? package,
    required EntitlementInfo? entitlement,
  }) async {
    try {
      if (entitlement != null) {
        final Map<String, dynamic> entitlementMap = entitlement.toJson();

        final Map<String, dynamic> customAttributes = {
          "Entitlement Identifier": entitlementMap["identifier"],
          "Has Entitlement Access": entitlementMap["isActive"],
          "Will Subscription Renew": entitlementMap["willRenew"],
          "Latest Purchase Date": entitlementMap["latestPurchaseDate"],
          "First Purchase Date": entitlementMap["originalPurchaseDate"],
          "Purchased Product Identifier": entitlementMap["productIdentifier"],
          "Purchase Ownership Type": entitlementMap["ownershipType"],
          "Current Store": entitlementMap["store"],
          "Current Period Type": entitlementMap["periodType"],
          "Purchase Expiration Date": entitlementMap["expirationDate"],
          "Unsubscribed On": entitlementMap["unsubscribeDetectedAt"],
          "Billing Issue Detected At": entitlementMap["billingIssueDetectedAt"],
        };

        await Intercom.instance.updateUser(
          customAttributes: customAttributes,
        );
      } else {
        log("Entitlement is null, skipping update.");
      }
    } catch (e) {
      log("Error updating user profile with subscription: $e");
    }
  }

  static logOutIntercom() async {
    await Intercom.instance.logout();
  }

  static displayHelpCenter() async {
    await Intercom.instance.displayHelpCenter();
  }
}
