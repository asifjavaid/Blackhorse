import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PackageWithEligibility {
  final Package package;
  final IntroEligibility? eligibility;

  PackageWithEligibility({required this.package, this.eligibility});
}

class PackageOfferInfo {
  final Package package;
  final IntroEligibility? eligibility;
  final OfferType offerType;

  PackageOfferInfo({
    required this.package,
    required this.eligibility,
    required this.offerType,
  });
}
