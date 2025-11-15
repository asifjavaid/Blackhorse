### Features

Back to README: [../README.md](../README.md)

This catalog maps major features to screens, providers, and services.

### Authentication and Onboarding

- Screens: `lib/Screens/Login/**`, `lib/Screens/Register/**`, `lib/Screens/Onboarding/onboarding_screen.dart`
- Providers: `lib/Providers/Login/login_provider.dart`, `lib/Providers/Register/register_provider.dart`, `lib/Providers/Onboarding/onboarding_provider.dart`
- Services: `lib/Services/Login/login_service.dart`, `lib/Services/Registration/registration_service.dart`, `lib/Services/Onboarding/onboarding_service.dart`
- Routes: see `lib/Routes/app_routes.dart` for `loginRoute`, `registerRoute`, `onboarding`

### Dashboard & Insights

- Screens: `lib/Screens/Dashboard/dashboard.dart`, `lib/Screens/Insights/insights_screen.dart`
- Providers: `lib/Providers/Dashboard/dashboard_provider.dart`, `lib/Providers/Insights/**`
- Services: `lib/Services/Dashboard/dashboard_service.dart`, `lib/Services/Insights/**`

### Daily Symptom Tracker

- Screens: `lib/Screens/DailyTrackerCategory/**`
- Providers: `lib/Providers/DailyTracker/**` (Bleeding, Mood, Stress, Energy, Nausea, Fatigue, BrainFog, Alcohol, Hormones, Intimacy, OvulationTest, PregnancyTest, BowelMovement, Headache)
- Services: `lib/Services/DailyTracker/**`
- Models: `lib/Models/DailyTracker/**`

API links reference for tracking (sample):

```1:15:lib/Network/api_links.dart
class ApiLinks {
  static const String dailyTracker = "/daily-tracker";
  static const String saveBleeding = "/bleeding";
  // ...
}
```

### Pain Management

- Screens: `lib/Screens/DailyTrackerCategory/PanelScreens/Pain-Relief/**`, `lib/Screens/DailyTrackerCategory/PanelScreens/PainKillers/**`
- Providers: `lib/Providers/DailyTracker/PainRelief/**`, `lib/Providers/DailyTracker/PainKillers/**`
- Services: `lib/Services/DailyTracker/PainRelief/**`, `lib/Services/DailyTracker/PainKillers/**`

### Movement & Self-care

- Screens: `lib/Screens/DailyTrackerCategory/PanelScreens/Movement/**`, `lib/Screens/DailyTrackerCategory/PanelScreens/Selfcare/**`
- Providers: `lib/Providers/DailyTracker/Movement/**`, `lib/Providers/DailyTracker/SelfCare/**`
- Services: `lib/Services/DailyTracker/Movement/movement_service.dart`, `lib/Services/DailyTracker/SelfCare/selfcare_service.dart`

### Reminders

- Screens: `lib/Screens/Reminders/**`
- Providers: `lib/Providers/Reminders/**`
- Services: `lib/Services/Reminders/reminders_service.dart`
- Notifications: local notifications helper `lib/Utils/helpers/local_notification_helper.dart`

### Ekvipedia & Ekvi Journeys

- Screens: `lib/Screens/Ekvipedia/**`
- Providers: `lib/Providers/Ekvipedia/**`
- Services: `lib/Services/Ekvipedia/**`
- Media players: `just_audio`, `video_player`

### Subscriptions / Purchases

- Provider: `lib/Providers/InAppPurchaseProvider/subscription_provider.dart`
- Helper: `lib/Utils/helpers/purchase_helper.dart`
- iOS products: see `Products` array in `ios/Runner/Info.plist`

### Navigation entry points

Primary routes defined in `lib/Routes/app_routes.dart` and `lib/Routes/route_generator.dart`.

```121:131:lib/Routes/app_routes.dart
static Map<String, WidgetBuilder> getRoutes() {
  return {
    AppRoutes.initial: (context) => const SplashScreen(),
    AppRoutes.welcomeRoute: (context) => const WelcomeScreen(),
    AppRoutes.registerRoute: (context) => const RegisterLandingScreen(),
    // ...
  };
}
```
