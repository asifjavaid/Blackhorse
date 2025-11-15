// package_option_widget.dart
import 'package:ekvi/Models/InAppPurchase/iap_model.dart';
import 'package:ekvi/Utils/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PackageOptionWidget extends StatelessWidget {
  final PackageOfferInfo packageOfferInfo;
  final bool isSelected;
  final VoidCallback onTap;

  const PackageOptionWidget({
    super.key,
    required this.packageOfferInfo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Package package = packageOfferInfo.package;
    final OfferType offerType = packageOfferInfo.offerType;
    final TextTheme textTheme = Theme.of(context).textTheme;

    String subscriptionPeriod = _getSubscriptionPeriod(package);

    switch (offerType) {
      case OfferType.freeTrial:
        return _buildFreeTrialUI(package, textTheme, subscriptionPeriod);
      case OfferType.discountedIntroOffer:
        return _buildDiscountedOfferUI(package, textTheme, subscriptionPeriod);
      case OfferType.regular:
      default:
        return _buildRegularPackageUI(package, textTheme, subscriptionPeriod);
    }
  }

  Widget _buildFreeTrialUI(Package package, TextTheme textTheme, String subscriptionPeriod) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: isSelected ? AppColors.secondaryColor400 : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? AppColors.secondaryColor600 : Colors.white,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                package.storeProduct.title.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.neutralColor500,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Start your ${package.storeProduct.introductoryPrice?.cycles}-week free trial',
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.neutralColor600,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Then ${package.storeProduct.priceString}/$subscriptionPeriod after the trial ends.',
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.neutralColor500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountedOfferUI(Package package, TextTheme textTheme, String subscriptionPeriod) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: isSelected ? AppColors.secondaryColor400 : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? AppColors.secondaryColor600 : Colors.white,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plan Type and Discount Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    package.storeProduct.title.toUpperCase(),
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.neutralColor500,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    alignment: Alignment.centerRight,
                    decoration: ShapeDecoration(
                      color: AppColors.actionColor400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: Text(
                      "${HelperFunctions.calculatePercentageDiscount(package.storeProduct.price, package.storeProduct.introductoryPrice!.price).toStringAsFixed(0)}% off your first $subscriptionPeriod",
                      textAlign: TextAlign.center,
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.actionColor600,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Price with Strikethrough and Introductory Price
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: package.storeProduct.priceString,
                      style: textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.neutralColor400,
                      ),
                    ),
                    TextSpan(
                      text: " ${package.storeProduct.introductoryPrice?.priceString}",
                      style: textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutralColor600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Introductory Price Details
              Text(
                "${package.storeProduct.introductoryPrice?.priceString}/$subscriptionPeriod for the first $subscriptionPeriod. "
                "Renews at ${package.storeProduct.priceString}/$subscriptionPeriod after.",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.neutralColor500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegularPackageUI(Package package, TextTheme textTheme, String subscriptionPeriod) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: isSelected ? AppColors.secondaryColor400 : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? AppColors.secondaryColor600 : Colors.white,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                package.storeProduct.title.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.neutralColor500,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                package.storeProduct.priceString,
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.neutralColor600,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${package.storeProduct.priceString}/$subscriptionPeriod",
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.neutralColor500,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSubscriptionPeriod(Package package) {
    return package.packageType.name == "monthly" ? 'month' : 'year';
  }
}
