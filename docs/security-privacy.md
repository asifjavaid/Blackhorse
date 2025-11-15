### Security & Privacy

Back to README: [../README.md](../README.md)

### Secrets management

- Some keys exist in `lib/Utils/constants/app_constant.dart` (Intercom, OneSignal). For production, move to secure storage/remote config.

### Data storage

- Tokens stored via `SharedPreferences` (`lib/Utils/helpers/shared_preferences.dart`) and accessed in `HelperFunctions.getAccessToken()`.
- User data cached in `lib/core/di/user_singleton.dart` and `SharedPreferences`.

### Permissions

- iOS: camera, photos, microphone, Face ID, location when in use, background fetch/remote notifications (see `ios/Runner/Info.plist`).
- Android: camera, internet, exact alarms, billing, boot completed, biometrics (see `android/app/src/main/AndroidManifest.xml`).

### Push notifications

- OneSignal integrated via `lib/core/di/one_signal_singleton.dart`.

### In-app purchases

- Uses `purchases_flutter` and Google Billing; ensure compliance with store policies.

### Network security

- All requests use HTTPS to `AppConstant.appBaseURL` (`https://prod.ekvi.io`).
- Errors are surfaced via custom exceptions; avoid exposing raw backend messages.
