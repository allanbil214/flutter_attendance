import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpresensi/core/themes/app_theme.dart';
import 'app_router.dart';
import '../core/constants/colors.dart';

class SmartPresensiApp extends ConsumerStatefulWidget {
  const SmartPresensiApp({super.key});

  @override
  ConsumerState<SmartPresensiApp> createState() => _SmartPresensiAppState();
}

class _SmartPresensiAppState extends ConsumerState<SmartPresensiApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SmartPresensi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _appRouter.router,
      builder: (context, child) {
        // Add SafeArea to prevent overflow from status bar and notch
        return SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background,
                  AppColors.backgroundLight,
                ],
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}