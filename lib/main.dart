import 'package:ekvi/Providers/LocaleProvider/locale_provider.dart';
import 'package:ekvi/Providers/app_providers.dart';
import 'package:ekvi/Routes/app_navigation.dart';
import 'package:ekvi/Routes/app_routes.dart';
import 'package:ekvi/Routes/route_generator.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/helper_functions.dart';
import 'package:ekvi/Core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ekvi/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HelperFunctions.initializeApplication();

  runApp(
    MultiProvider(
      providers: appProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) =>
          Consumer<LocaleProvider>(builder: (context, value, child) {
        return MaterialApp(
          title: AppConstant.appName,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.defaultTheme,
          routes: AppRoutes.getRoutes(),
          locale: value.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorKey: AppNavigation.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }),
    );
  }
}
