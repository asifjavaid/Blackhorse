import 'package:ekvi/Models/EditProfle/user_profile_model.dart';

class UserNotificationPreferences {
  String email;
  NotificationPreferences notificationPreferences;

  UserNotificationPreferences({
    required this.email,
    required this.notificationPreferences,
  });

  // Factory constructor to create an instance from JSON
  factory UserNotificationPreferences.fromJson(Map<String, dynamic> json) {
    return UserNotificationPreferences(
      email: json['email'] as String,
      notificationPreferences: NotificationPreferences.fromJson(json['notificationPreferences']),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'notificationPreferences': notificationPreferences.toJson(),
    };
  }
}
