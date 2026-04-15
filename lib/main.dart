import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'data/datasources/local/shared_prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  await SharedPrefsHelper.init();
  
  runApp(
    const ProviderScope(
      child: SmartPresensiApp(),
    ),
  );
}