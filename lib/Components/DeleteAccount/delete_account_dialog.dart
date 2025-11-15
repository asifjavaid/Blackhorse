import 'package:ekvi/Providers/DeleteAccountProvider/delete_account_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<DeleteAccountProvider>(context, listen: false);

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: const Icon(Icons.close),
                    onTap: () {
                      AppNavigation.goBack();
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text("Are you sure you want to say goodbye?", textAlign: TextAlign.center, style: textTheme.displayMedium),
                const SizedBox(
                  height: 16,
                ),
                Text("You will not be able to restore or see your data when your account is deleted.", textAlign: TextAlign.center, style: textTheme.bodyMedium),
                const SizedBox(
                  height: 32,
                ),
                CustomButton(
                  title: "Delete Account",
                  onPressed: () => provider.deleteUserProfile(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
