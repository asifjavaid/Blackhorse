import 'package:ekvi/Components/InAppPurchases/subscribe_package_option_widget.dart';
import 'package:ekvi/Providers/InAppPurchaseProvider/subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscribePackageOptionsWidget extends StatelessWidget {
  const SubscribePackageOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var subscriptionProvider = Provider.of<SubscriptionProvider>(context);

    return Column(
        children: subscriptionProvider.packageOfferInfos.map((packageOfferInfo) {
      return PackageOptionWidget(
        packageOfferInfo: packageOfferInfo,
        isSelected: subscriptionProvider.selectedPackage.storeProduct.identifier == packageOfferInfo.package.storeProduct.identifier,
        onTap: () {
          subscriptionProvider.packageSelection(packageOfferInfo.package);
        },
      );
    }).toList());
  }
}
