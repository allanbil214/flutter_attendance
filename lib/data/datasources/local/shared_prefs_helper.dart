import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _keyFirstLaunch = 'first_launch';
  static const String _keyUserSession = 'user_session';
  static const String _keyAdminSession = 'admin_session';
  static const String _keyPersonalSession = 'personal_session';
  
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
  
  // ============ KARYAWAN SESSION ============
  static Future<void> saveUserSession({
    required int userId,
    required String email,
    required String name,
    required String role,
    String? organizationId,
    String? organizationName,
    String? phone,
    String? photoPath,
  }) async {
    await _prefs.setInt('user_id', userId);
    await _prefs.setString('user_email', email);
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_role', role);
    await _prefs.setString('user_organization_id', organizationId ?? '');
    await _prefs.setString('user_organization_name', organizationName ?? '');
    await _prefs.setString('user_phone', phone ?? '');
    await _prefs.setString('user_photo_path', photoPath ?? '');
    await _prefs.setString('user_session_type', 'karyawan');
    await _prefs.setBool('is_logged_in', true);
  }
  
  static bool isUserLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }
  
  static String getUserRole() {
    return _prefs.getString('user_role') ?? '';
  }
  
  static String getUserName() {
    return _prefs.getString('user_name') ?? '';
  }
  
  static String getUserEmail() {
    return _prefs.getString('user_email') ?? '';
  }
  
  static int getUserId() {
    return _prefs.getInt('user_id') ?? 0;
  }
  
  static String getUserOrganizationId() {
    return _prefs.getString('user_organization_id') ?? '';
  }
  
  static String getUserOrganizationName() {
    return _prefs.getString('user_organization_name') ?? '';
  }
  
  static Future<void> clearUserSession() async {
    await _prefs.remove('user_id');
    await _prefs.remove('user_email');
    await _prefs.remove('user_name');
    await _prefs.remove('user_role');
    await _prefs.remove('user_organization_id');
    await _prefs.remove('user_organization_name');
    await _prefs.remove('user_phone');
    await _prefs.remove('user_photo_path');
    await _prefs.remove('user_session_type');
    await _prefs.setBool('is_logged_in', false);
  }
  
  // ============ ADMIN SESSION (same as karyawan but different role) ============
  static Future<void> saveAdminSession({
    required int userId,
    required String email,
    required String name,
    required String role,
    required String organizationId,
    required String organizationName,
    String? phone,
    String? photoPath,
  }) async {
    await _prefs.setInt('admin_id', userId);
    await _prefs.setString('admin_email', email);
    await _prefs.setString('admin_name', name);
    await _prefs.setString('admin_role', role);
    await _prefs.setString('admin_organization_id', organizationId);
    await _prefs.setString('admin_organization_name', organizationName);
    await _prefs.setString('admin_phone', phone ?? '');
    await _prefs.setString('admin_photo_path', photoPath ?? '');
    await _prefs.setString('user_session_type', 'admin');
    await _prefs.setBool('is_admin_logged_in', true);
  }
  
  static bool isAdminLoggedIn() {
    return _prefs.getBool('is_admin_logged_in') ?? false;
  }
  
  static String getAdminName() {
    return _prefs.getString('admin_name') ?? '';
  }
  
  static String getAdminOrganizationId() {
    return _prefs.getString('admin_organization_id') ?? '';
  }
  
  static String getAdminOrganizationName() {
    return _prefs.getString('admin_organization_name') ?? '';
  }
  
  static Future<void> clearAdminSession() async {
    await _prefs.remove('admin_id');
    await _prefs.remove('admin_email');
    await _prefs.remove('admin_name');
    await _prefs.remove('admin_role');
    await _prefs.remove('admin_organization_id');
    await _prefs.remove('admin_organization_name');
    await _prefs.remove('admin_phone');
    await _prefs.remove('admin_photo_path');
    await _prefs.remove('user_session_type');
    await _prefs.setBool('is_admin_logged_in', false);
  }
  
  // ============ PERSONAL SESSION ============
  static Future<void> savePersonalSession({
    required int userId,
    required String email,
    required String name,
    String? phone,
    String? photoPath,
  }) async {
    await _prefs.setInt('personal_id', userId);
    await _prefs.setString('personal_email', email);
    await _prefs.setString('personal_name', name);
    await _prefs.setString('personal_phone', phone ?? '');
    await _prefs.setString('personal_photo_path', photoPath ?? '');
    await _prefs.setString('user_session_type', 'personal');
    await _prefs.setBool('is_personal_logged_in', true);
  }
  
  static bool isPersonalLoggedIn() {
    return _prefs.getBool('is_personal_logged_in') ?? false;
  }
  
  static Future<void> clearPersonalSession() async {
    await _prefs.remove('personal_id');
    await _prefs.remove('personal_email');
    await _prefs.remove('personal_name');
    await _prefs.remove('personal_phone');
    await _prefs.remove('personal_photo_path');
    await _prefs.remove('user_session_type');
    await _prefs.setBool('is_personal_logged_in', false);
  }
  
  // ============ CLEAR ALL ============
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
  
  // ============ GET SESSION TYPE ============
  static String getSessionType() {
    return _prefs.getString('user_session_type') ?? 'none';
  }
}