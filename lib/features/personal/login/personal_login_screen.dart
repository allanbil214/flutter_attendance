import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/animations/fade_in_slide.dart';
import '../../../core/widgets/animations/scale_animation.dart';
import '../../../data/datasources/local/shared_prefs_helper.dart';

class PersonalLoginScreen extends StatefulWidget {
  const PersonalLoginScreen({super.key});

  @override
  State<PersonalLoginScreen> createState() => _PersonalLoginScreenState();
}

class _PersonalLoginScreenState extends State<PersonalLoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    
    // Simulate Google Sign-In delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Save personal session (Phase 1 dummy data)
    await SharedPrefsHelper.saveUserSession(
      id: 'personal_001',
      email: 'user@gmail.com',
      name: 'Personal User',
      photoUrl: null,
    );
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      context.go('/personal-home');
    }
  }

  void _switchAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Switch account - Google Sign-In (Phase 2)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              
              // Logo
              ScaleAnimation(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.personalGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.personalPrimary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              const FadeInSlide(
                offset: Offset(0, 20),
                child: Column(
                  children: [
                    Text(
                      'Personal Mode',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.personalPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Track your individual activities',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Google Sign-In Button
              FadeInSlide(
                offset: const Offset(0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.textPrimary,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.personalPrimary),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                width: 24,
                                height: 24,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.g_mobiledata, size: 24),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Switch account button
              TextButton(
                onPressed: _switchAccount,
                child: const Text(
                  'Ganti Akun',
                  style: TextStyle(color: AppColors.personalPrimary),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.personalSoft,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.personalPrimary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Personal mode allows you to track your own activities without being part of an organization.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.personalPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}