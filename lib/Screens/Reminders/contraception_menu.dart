import 'package:ekvi/Providers/Reminders/reminders_provider.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Widgets/Bars/custom_back_navigation_bar.dart';
import 'package:ekvi/Widgets/CustomWidgets/curved_white_content_box.dart';
import 'package:ekvi/Widgets/Gradient/gradient_background.dart';
import 'package:ekvi/Widgets/CustomWidgets/listile_bottom_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

class ContraceptionMenu extends StatefulWidget {
  const ContraceptionMenu({super.key});

  @override
  State<ContraceptionMenu> createState() => _ContraceptionMenuState();
}

class _ContraceptionMenuState extends State<ContraceptionMenu> {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackNavigation(
                    title: localizations.contraceptions,
                    callback: () {
                      AppNavigation.goBack();
                      var provider = Provider.of<RemindersProvider>(
                          AppNavigation.currentContext!,
                          listen: false);
                      provider.getAllReminders();
                    }),
                ContentBox(
                  width: 92.w,
                  contentHorizontalAlignment: CrossAxisAlignment.start,
                  listView: false,
                  children: [
                    Text(
                      localizations.addNewReminder,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),
                    ListTileBottomBorder(
                      child: ListTile(
                        leading: Text(
                          localizations.oral,
                          style: textTheme.bodySmall,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.actionColor600,
                        ),
                        onTap: () => AppNavigation.navigateTo(
                            AppRoutes.oralContraceptionReminder),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ListTileBottomBorder(
                        child: ListTile(
                      leading: Text(
                        localizations.ring,
                        style: textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.actionColor600,
                      ),
                      onTap: () => AppNavigation.navigateTo(
                          AppRoutes.vaginalRingReminder),
                    )),
                    SizedBox(height: 2.h),
                    ListTileBottomBorder(
                        child: ListTile(
                      leading: Text(
                        localizations.patch,
                        style: textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.actionColor600,
                      ),
                      onTap: () => AppNavigation.navigateTo(
                          AppRoutes.contraceptivePatchReminder),
                    )),
                    SizedBox(height: 2.h),
                    ListTileBottomBorder(
                        child: ListTile(
                      leading: Text(
                        localizations.injection,
                        style: textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.actionColor600,
                      ),
                      onTap: () => AppNavigation.navigateTo(
                          AppRoutes.contraceptiveInjectionReminder),
                    )),
                    SizedBox(height: 2.h),
                    ListTileBottomBorder(
                        child: ListTile(
                      leading: Text(
                        localizations.iud,
                        style: textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.actionColor600,
                      ),
                      onTap: () =>
                          AppNavigation.navigateTo(AppRoutes.iudReminder),
                    )),
                    SizedBox(height: 2.h),
                    ListTile(
                      leading: Text(
                        localizations.implant,
                        style: textTheme.bodySmall,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.actionColor600,
                      ),
                      onTap: () => AppNavigation.navigateTo(
                          AppRoutes.contraceptiveImplantReminder),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
