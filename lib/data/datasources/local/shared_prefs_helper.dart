import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _keyFirstLaunch = 'first_launch';
  static const String _keyUserSession = 'user_session';
  static const String _keyAdminSession = 'admin_session';
  
  static late SharedPreferences _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // First launch check
  static Future<bool> isFirstLaunch() async {
    final isFirst = _prefs.getBool(_keyFirstLaunch) ?? true;
    if (isFirst) {
      await setFirstLaunchDone();
    }
    return isFirst;
  }
  
  static Future<void> setFirstLaunchDone() async {
    await _prefs.setBool(_keyFirstLaunch, false);
  }
  
  // User session (Karyawan)
  static Future<void> saveUserSession({
    required String id,
    required String email,
    required String name,
    required String? photoUrl,
  }) async {
    await _prefs.setString('user_id', id);
    await _prefs.setString('user_email', email);
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_photo', photoUrl ?? '');
    await _prefs.setBool('is_logged_in', true);
  }
  
  static bool isUserLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }
  
  static Future<void> clearUserSession() async {
    await _prefs.remove('user_id');
    await _prefs.remove('user_email');
    await _prefs.remove('user_name');
    await _prefs.remove('user_photo');
    await _prefs.setBool('is_logged_in', false);
  }
  
  // Admin session
  static Future<void> saveAdminSession({
    required String id,
    required String email,
    required String name,
    required String orgId,
    required String orgName,
  }) async {
    await _prefs.setString('admin_id', id);
    await _prefs.setString('admin_email', email);
    await _prefs.setString('admin_name', name);
    await _prefs.setString('admin_org_id', orgId);
    await _prefs.setString('admin_org_name', orgName);
    await _prefs.setBool('is_admin_logged_in', true);
  }
  
  static bool isAdminLoggedIn() {
    return _prefs.getBool('is_admin_logged_in') ?? false;
  }
  
  static Future<void> clearAdminSession() async {
    await _prefs.remove('admin_id');
    await _prefs.remove('admin_email');
    await _prefs.remove('admin_name');
    await _prefs.remove('admin_org_id');
    await _prefs.remove('admin_org_name');
    await _prefs.setBool('is_admin_logged_in', false);
  }
  
  // Clear all
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}