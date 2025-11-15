import 'package:ekvi/Models/Amplitude/amplitude_event.dart';

class UserLoginAmplitudeEvent extends BaseEvent {
  final String loginMethod;
  final String userSegment;
  final String userId;

  UserLoginAmplitudeEvent({
    required this.loginMethod,
    required this.userSegment,
    required this.userId,
  });

  @override
  String get eventName => 'UserLogin';

  @override
  String get description => 'User logs in';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'loginMethod': loginMethod,
        'userSegment': userSegment,
        'userId': userId,
      };
}

class UserLogoutAmplitudeEvent extends BaseEvent {
  final String userId;

  UserLogoutAmplitudeEvent({
    required this.userId,
  });

  @override
  String get eventName => 'UserLogout';

  @override
  String get description => 'User logs out or session ends';

  @override
  Future<Map<String, dynamic>> get properties async => {
        'description': description,
        'userId': userId,
      };
}
