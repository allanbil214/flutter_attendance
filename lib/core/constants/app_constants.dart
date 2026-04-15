import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'SmartPresensi';
  static const String appVersion = '1.0.0';
  
  // SharedPreferences keys
  static const String keyFirstLaunch = 'first_launch';
  static const String keyUserSession = 'user_session';
  static const String keyAdminSession = 'admin_session';
  
  // Animation durations
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 400);
  static const Duration animSlow = Duration(milliseconds: 600);
  
  // Animation curves - these are static getters since Curves values aren't const
  static Curve get curvePrimary => Curves.easeOutCubic;
  static Curve get curveBounce => Curves.easeOutBack;
  static Curve get curveSpring => Curves.elasticOut;
  
  // API endpoints (will be updated in Phase 2)
  static const String baseUrl = 'https://barateknologi.com/presensi/';
  
  // Date formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
}