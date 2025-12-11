import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:ekvi/Models/DailyTracker/PainRelief/user_pain_relief_model.dart';
import 'package:ekvi/Providers/DailyTracker/PainRelief/pain_relief_vault_provider.dart';
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

class PainReliefPracticesScreen extends StatefulWidget {
  const PainReliefPracticesScreen({super.key});

  @override
  State<PainReliefPracticesScreen> createState() => _PainReliefPracticesScreenState();
}

class _PainReliefPracticesScreenState extends State<PainReliefPracticesScreen> {
  @override
  void initState() {
    super.initState();
    _fetchPainReliefPractices();
  }

  Future<void> _fetchPainReliefPractices() async {
    final provider = Provider.of<PainReliefVaultProvider>(context, listen: false);
    await provider.fetchPainReliefPractices();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PainReliefVaultProvider>(context);

    return RefreshIndicator(
      onRefresh: _fetchPainReliefPractices,
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
                    AppNavigation.navigateTo(AppRoutes.addPainReliefPracticesScreen);
                  },
                ),
                const SizedBox(height: 24),
                if (provider.currentPractices.isNotEmpty) ...[
                  _buildPracticeSection(
                    context: context,
                    title: "Active practices",
                    practices: provider.currentPractices,
                  ),
                  const SizedBox(height: 16),
                ],
                if (provider.previousPractices.isNotEmpty) ...[
                  _buildPracticeSection(
                    context: context,
                    title: "Inactive practices",
                    practices: provider.previousPractices,
                  ),
                  const SizedBox(height: 16),
                ],
                if (provider.currentPractices.isEmpty && provider.previousPractices.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text(
                        "No pain relief practices found. Please add a new one.",
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

  Widget _buildPracticeSection({
    required BuildContext context,
    required String title,
    required List<UserPainReliefResponseModel> practices,
  }) {
    return Container(
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
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.neutralColor600),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: practices.length,
            itemBuilder: (context, index) {
              return PainReliefPracticeTile(practice: practices[index]);
            },
          ),
        ],
      ),
    );
  }
}

class PainReliefPracticeTile extends StatelessWidget {
  final UserPainReliefResponseModel practice;

  const PainReliefPracticeTile({super.key, required this.practice});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PainReliefVaultProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: Theme.of(context).copyWith(listTileTheme: const ListTileThemeData(shape: null)),
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
              style: const TextStyle(fontSize: 18.45, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
            ),
          ),
        ),
        title: Text(practice.name, style: textTheme.bodySmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (practice.isTrigger)
              Text(
                '⚠️',
                style: textTheme.bodySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              ),
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
              onPressed: () => AppNavigation.navigateTo(
                AppRoutes.updatePainReliefPracticesScreen,
                arguments: ScreenArguments(painReliefPractice: practice),
              ),
            ),
          ],
        ),
        onTap: () => AppNavigation.navigateTo(
          AppRoutes.updatePainReliefPracticesScreen,
          arguments: ScreenArguments(painReliefPractice: practice),
        ),
      ),
    );
  }
}
