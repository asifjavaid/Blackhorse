import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdaterProvider extends ChangeNotifier {
  bool _showBanner = false;
  String _latestVersion = '';
  String _updateMessage = '';
  Uri _storeURL = Uri.parse('https://en.ekvi.io/terms/');

  bool get showBanner => _showBanner;
  String get latestVersion => _latestVersion;
  String get updateMessage => _updateMessage;

  Future<void> checkForAppUpdate() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ));

      await remoteConfig.fetchAndActivate();

      String env = AppConstant.appEnvironment;
      String latestVersionJson = Platform.isAndroid ? remoteConfig.getString('app_version_${env}_android') : remoteConfig.getString('app_version_$env');
      String updateUrl = Platform.isIOS ? remoteConfig.getString('update_url_ios') : remoteConfig.getString('update_url_android');

      _storeURL = Uri.parse(updateUrl);
      final versionData = jsonDecode(latestVersionJson);
      String latestVersion = versionData['version'];
      String updateMessage = versionData['message'];

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final currentBuild = packageInfo.buildNumber;

      String latestMainVersion = latestVersion.split('+')[0];
      String latestBuildVersion = latestVersion.contains('+') ? latestVersion.split('+')[1] : '0';

      if (_compareVersions(latestMainVersion, currentVersion, latestBuildVersion, currentBuild)) {
        _latestVersion = latestVersion;
        _updateMessage = updateMessage;
        _showBanner = true;
      } else {
        _showBanner = false;
      }
      notifyListeners();
    } catch (e) {
      log('Failed to fetch latest version from Remote Config: $e');
    }
  }

  bool _compareVersions(String latest, String current, String latestBuild, String currentBuild) {
    List<String> latestParts = latest.split('.');
    List<String> currentParts = current.split('.');

    for (int i = 0; i < latestParts.length; i++) {
      int latestPart = int.tryParse(latestParts[i]) ?? 0;
      int currentPart = int.tryParse(currentParts.length > i ? currentParts[i] : '0') ?? 0;

      if (latestPart > currentPart) {
        return true;
      } else if (latestPart < currentPart) {
        return false;
      }
    }

    int latestBuildNumber = _parseBuildNumber(latestBuild);
    int currentBuildNumber = _normalizeBuildNumber(currentBuild);

    return latestBuildNumber > currentBuildNumber;
  }

  int _parseBuildNumber(String build) {
    return int.parse(build.replaceAll(".", ""));
  }

  int _normalizeBuildNumber(String build) {
    if (int.tryParse(build) != null) {
      return int.parse(build);
    }
    return _parseBuildNumber(build);
  }

  Future<void> launchStoreUrl() async {
    try {
      if (!await launchUrl(_storeURL)) {
        throw Exception('Could not launch $_storeURL');
      }
    } catch (e) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.exceptionMessage);
    }
  }

  void dismissBanner() {
    _showBanner = false;
    notifyListeners();
  }
}
