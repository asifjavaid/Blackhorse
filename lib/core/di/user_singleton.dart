import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  String? _userId;
  String? _email;
  bool _isPremium = false;

  factory UserManager() => _instance;

  UserManager._internal();

  /// Initialize user data and verify premium status
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _email = prefs.getString('userEmail');
  }

  /// Save user data to SharedPreferences and update instance fields
  Future<void> saveUserData({
    required String userId,
    required String username,
    required String email,
    required bool isLoggedIn,
    required String token,
    required bool isPremium,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('userEmail', email);
    await prefs.setBool('isPremium', isPremium);

    _userId = userId;
    _email = email;
    _isPremium = isPremium;
  }

  /// Update premium status
  Future<void> updatePremiumStatus({required bool isPremium}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPremium', isPremium);
    _isPremium = isPremium;
  }

  /// Getters for user data
  String? get userId => _userId;
  String? get email => _email;
  bool get isPremium => _isPremium;

  /// Clear user data from SharedPreferences
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _userId = null;
    _email = null;
    _isPremium = false;
  }
}
