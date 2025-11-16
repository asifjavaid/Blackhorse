import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/Movement/user_movements_model.dart';
import 'package:ekvi/Providers/DailyTracker/Movement/movement_vault_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/screen_arguments.dart';
import 'package:ekvi/Screens/Notifications/notification_preferences_screen.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/helpers/app_custom_icons.dart';
import 'package:ekvi/Widgets/Buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/assets.dart';

class MovementPracticesScreen extends StatefulWidget {
  const MovementPracticesScreen({super.key});

  @override
  MovementPracticesScreenState createState() => MovementPracticesScreenState();
}

class MovementPracticesScreenState extends State<MovementPracticesScreen> {
  @override
  void initState() {
    super.initState();
    _fetchMovementPractices();
  }

  Future<void> _fetchMovementPractices() async {
    final provider = Provider.of<MovementVaultProvider>(context, listen: false);
    await provider.fetchMovementPractices();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovementVaultProvider>(context);
    return RefreshIndicator(
      onRefresh: _fetchMovementPractices,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                CustomButton(
                  title: "Add new practice",
                  onPressed: () {
                    AppNavigation.navigateTo(AppRoutes.addMovementPracticeScreen);
                  },
                ),
                const SizedBox(height: 24),
                if (provider.currentPractices.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [AppThemes.shadowDown],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Active practices",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.currentPractices.length,
                          itemBuilder: (context, index) {
                            final practice = provider.currentPractices[index];
                            return PracticeTile(practice: practice);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (provider.previousPractices.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [AppThemes.shadowDown],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inactive practices",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.previousPractices.length,
                          itemBuilder: (context, index) {
                            final practice = provider.previousPractices[index];
                            return PracticeTile(practice: practice);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (provider.currentPractices.isEmpty && provider.previousPractices.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        "No movements found. Please add a new one.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PracticeTile extends StatelessWidget {
  final UserMovementsResponseModel practice;

  const PracticeTile({super.key, required this.practice});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovementVaultProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: const ListTileThemeData(shape: null),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        minVerticalPadding: 0,
        dense: true,
        leading: Container(
          decoration: const ShapeDecoration(
            color: Color(0xFFFEF5FF),
            shape: OvalBorder(),
          ),
          width: 36,
          height: 36,
          child: Center(
            child: Text(
              practice.emoji,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.45,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        title: Text(
          practice.name,
          style: textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            practice.isTrigger
                ? Text(
                    '⚠️',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                  )
                : const SizedBox(),
            const SizedBox(width: 16),
            CustomSwitch(
              value: practice.isVisibleInTracker,
              onChanged: (bool newValue) {
                provider.toggleVisibility(practice, newValue);
              },
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: SvgPicture.asset(Assets.customiconsArrowRight, color: AppColors.actionColor600, height: 18, width: 18,),
              onPressed: () => AppNavigation.navigateTo(AppRoutes.updateMovementPracticeScreen, arguments: ScreenArguments(movementPractice: practice)),
            ),
          ],
        ),
        onTap: () {
          AppNavigation.navigateTo(AppRoutes.updateMovementPracticeScreen, arguments: ScreenArguments(movementPractice: practice));
        },
      ),
    );
  }
}
