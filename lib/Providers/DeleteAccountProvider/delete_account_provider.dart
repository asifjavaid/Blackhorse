import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Providers/SideNavManager/side_nav_manager_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Services/DeleteAccount/delete_account_service.dart';
import 'package:ekvi/Utils/helpers/shared_preferences.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteAccountProvider extends ChangeNotifier {
  Future<void> deleteUserProfile() async {
    CustomLoading.showLoadingIndicator();
    String? userId = await SharedPreferencesHelper.getStringPrefValue(key: "userId");
    var result = await DeleteAccountService.deleteUserProfileFromApi(userId!);
    result.fold(
      (l) {
        CustomLoading.hideLoadingIndicator();
      },
      (r) async {
        CustomLoading.hideLoadingIndicator();

        var provider = Provider.of<SideNavManagerProvider>(AppNavigation.currentContext!, listen: false);
        provider.onSelected(MenuItems(AppNavigation.currentContext!).bottomNavManager, notify: false);
        await LoginProvider().handleLogout();
      },
    );
  }
}
