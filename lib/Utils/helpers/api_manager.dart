import 'package:dartz/dartz.dart';
import 'package:ekvi/Network/api_exception.dart';
import 'package:ekvi/Providers/Login/login_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/api_circuit_breaker_helper.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Widgets/Dialogs/custom_loader.dart';

class ApiManager {
  static final CircuitBreaker _circuitBreaker = CircuitBreaker(
    failureThreshold: 1,
    resetTimeout: const Duration(seconds: 10),
  );

  static Future<void> _handleUnauthorisedException(UnauthorisedException e) async {
    _circuitBreaker.recordFailure();
    if (!_circuitBreaker.canProceed()) {
      HelperFunctions.showNotification(AppNavigation.currentContext!, AppConstant.unAuthorizedExceptionMessage, seconds: 2);
      await Future.delayed(const Duration(seconds: 2));
      await LoginProvider().handleLogout();
    }
  }

  static Future<Either<dynamic, T>> safeApiCall<T>(Future<T> Function() apiCall, {bool showLoader = true}) async {
    if (!_circuitBreaker.canProceed()) {
      throw CircuitBreakerOpenException('Circuit Breaker is open due to too many failures.');
    }
    if (showLoader) CustomLoading.showLoadingIndicator();

    try {
      var response = await apiCall();
      _circuitBreaker.reset();
      if (showLoader) CustomLoading.hideLoadingIndicator();
      return Right(response);
    } on UnauthorisedException catch (e) {
      if (showLoader) CustomLoading.hideLoadingIndicator();
      await _handleUnauthorisedException(e);
      return Left(e);
    } catch (e) {
      if (showLoader) CustomLoading.hideLoadingIndicator();
      return Left(e);
    }
  }
}
