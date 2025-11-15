### iOS Platform

Back to README: [../README.md](../README.md)

### Deployment target and pods

- iOS deployment target 15.0 in `ios/Podfile`.

```1:6:ios/Podfile
platform :ios, '15.0'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'
```

Post-install enforces 15.0:

```38:45:ios/Podfile
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
```

### Info.plist

- App metadata, permissions (Camera, Photo Library, Face ID, Microphone), background modes (`fetch`, `remote-notification`), product IDs.

```31:49:ios/Runner/Info.plist
<key>NSCameraUsageDescription</key>
<string>Need to access camera for user profile picture</string>
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
  <string>remote-notification</string>
</array>
```

### Entitlements

- APNs environment is set to development in `ios/Runner/Runner.entitlements`.

```5:11:ios/Runner/Runner.entitlements
<key>aps-environment</key>
<string>development</string>
```

### Signing

- Configure team, bundle identifier, and provisioning profiles in Xcode.

### Build

```bash
cd ios && pod install && cd ..
flutter build ios --release
```

### App Store Connect

- Upload via Xcode Organizer or `flutter build ipa` (if configured).
