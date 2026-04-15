import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/animations/fade_in_slide.dart';
import '../../core/widgets/animations/scale_animation.dart';

class LoginMethodScreen extends StatefulWidget {
  const LoginMethodScreen({super.key});

  @override
  State<LoginMethodScreen> createState() => _LoginMethodScreenState();
}

class _LoginMethodScreenState extends State<LoginMethodScreen>
    with SingleTickerProviderStateMixin {
  RoleType _selectedRole = RoleType.karyawan;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                
                // Back button
                ScaleAnimation(
                  child: IconButton(
                    onPressed: () => context.go('/onboarding'),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Title
                const FadeInSlide(
                  offset: Offset(0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose Your',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        'Role',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                const FadeInSlide(
                  offset: Offset(0, 20),
                  child: Text(
                    'Select how you want to use the app',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Role cards
                Column(
                  children: [
                    _buildRoleCard(
                      title: 'Karyawan',
                      subtitle: 'Employee attendance & activities',
                      icon: Icons.badge_outlined,
                      color: AppColors.primary,
                      role: RoleType.karyawan,
                      gradient: AppColors.primaryGradient,
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      title: 'Perusahaan',
                      subtitle: 'Admin dashboard & reports',
                      icon: Icons.business_outlined,
                      color: AppColors.adminPrimary,
                      role: RoleType.perusahaan,
                      gradient: AppColors.adminGradient,
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      title: 'Personal',
                      subtitle: 'Individual activity logging',
                      icon: Icons.person_outline,
                      color: AppColors.personalPrimary,
                      role: RoleType.personal,
                      gradient: AppColors.personalGradient,
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Continue button - FIXED: Now uses selected role directly
                FadeInSlide(
                  offset: const Offset(0, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleRoleSelection();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getSelectedColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Continue as ${_selectedRole.value}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Footer links
                const FadeInSlide(
                  offset: Offset(0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _FooterButton(text: 'Tutorial'),
                      SizedBox(width: 8),
                      Text('|'),
                      SizedBox(width: 8),
                      _FooterButton(text: 'Tentang Aplikasi'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      
      // Debug shortcut
      floatingActionButton: _buildDebugFAB(),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required RoleType role,
    required Gradient gradient,
  }) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: AppConstants.animNormal,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withValues(alpha: 0.2) : color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: isSelected ? Colors.white : color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: isSelected ? Colors.white.withValues(alpha: 0.9) : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSelectedColor() {
    switch (_selectedRole) {
      case RoleType.karyawan:
        return AppColors.primary;
      case RoleType.perusahaan:
        return AppColors.adminPrimary;
      case RoleType.personal:
        return AppColors.personalPrimary;
    }
  }

  void _handleRoleSelection() {
    switch (_selectedRole) {
      case RoleType.karyawan:
        context.push('/login-karyawan');
        break;
      case RoleType.perusahaan:
        context.push('/login-perusahaan');
        break;
      case RoleType.personal:
        context.push('/personal-login');
        break;
    }
  }

  void _showTutorialDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.school, size: 48, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                'Tutorial',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Video tutorials will be available here'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDebugFAB() {
    return FloatingActionButton.small(
      onPressed: () {
        _showDebugMenu();
      },
      backgroundColor: Colors.black54,
      child: const Icon(Icons.developer_mode, size: 20),
    );
  }

  void _showDebugMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Debug Shortcuts',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDebugButton('Karyawan Home', () {
              Navigator.pop(context);
              context.push('/karyawan-home');
            }),
            const SizedBox(height: 8),
            _buildDebugButton('Admin Home', () {
              Navigator.pop(context);
              context.push('/admin-home');
            }),
            const SizedBox(height: 8),
            _buildDebugButton('Personal Home', () {
              Navigator.pop(context);
              context.push('/personal-home');
            }),
            const SizedBox(height: 16),
            Text(
              '⚠️ For development only',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugButton(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.chevron_right, size: 20),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String text;
  const _FooterButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (text == 'Tentang Aplikasi') {
          context.push('/about');
        } else {
          // Show tutorial dialog
          final state = context.findAncestorStateOfType<_LoginMethodScreenState>();
          state?._showTutorialDialog();
        }
      },
      child: Text(text),
    );
  }
}

enum RoleType {
  karyawan,
  perusahaan,
  personal,
}

extension RoleTypeExtension on RoleType {
  String get value {
    switch (this) {
      case RoleType.karyawan:
        return 'Karyawan';
      case RoleType.perusahaan:
        return 'Perusahaan';
      case RoleType.personal:
        return 'Personal';
    }
  }
}