// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
// import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } on PlatformException catch (_) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      return <BiometricType>[];
    }
  }

  static Future<Either<String, bool>> authenticate() async {
    // return Right(true);
    final List availableBiometrics = await getBiometrics();
    if (!await hasBiometrics()) return const Left("Hardware Support not available");
    if (availableBiometrics.isEmpty) return const Left("No Biometrics are enrolled");
    try {
      return Right(await _auth.authenticate(authMessages: const <AuthMessages>[
        AndroidAuthMessages(
          signInTitle: 'Biometric Authentication',
          cancelButton: 'No thanks',
        ),

        // IOSAuthMessages(
        //   cancelButton: 'No thanks',
        // ),
      ], localizedReason: 'Please Scan to Authenticate', options: const AuthenticationOptions(useErrorDialogs: true, sensitiveTransaction: true, stickyAuth: true, biometricOnly: true)));
    } on PlatformException catch (_) {
      return const Right(false);
    }
  }
}
