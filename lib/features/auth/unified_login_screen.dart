import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/animations/fade_in_slide.dart';
import '../../core/widgets/animations/scale_animation.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/datasources/local/shared_prefs_helper.dart';

class UnifiedLoginScreen extends StatefulWidget {
  final String? roleHint; // 'karyawan', 'perusahaan', 'personal' - just for UI hint
  const UnifiedLoginScreen({super.key, this.roleHint});

  @override
  State<UnifiedLoginScreen> createState() => _UnifiedLoginScreenState();
}

class _UnifiedLoginScreenState extends State<UnifiedLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiClient _apiClient = ApiClient();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _roleDisplay {
    switch (widget.roleHint) {
      case 'karyawan':
        return 'Karyawan';
      case 'perusahaan':
        return 'Admin Perusahaan';
      case 'personal':
        return 'Personal';
      default:
        return '';
    }
  }

  Color get _accentColor {
    switch (widget.roleHint) {
      case 'karyawan':
        return AppColors.primary;
      case 'perusahaan':
        return AppColors.adminPrimary;
      case 'personal':
        return AppColors.personalPrimary;
      default:
        return AppColors.primary;
    }
  }

  Gradient get _gradient {
    switch (widget.roleHint) {
      case 'karyawan':
        return AppColors.primaryGradient;
      case 'perusahaan':
        return AppColors.adminGradient;
      case 'personal':
        return AppColors.personalGradient;
      default:
        return AppColors.primaryGradient;
    }
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Email dan password wajib diisi');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _apiClient.login(email, password);

      if (!mounted) return;

      if (response['success'] == true) {
        final userData = response['data'];
        final role = userData['role'] as String;

        // Handle different roles
        switch (role) {
          case 'karyawan':
            await SharedPrefsHelper.saveUserSession(
              userId: userData['user_id'],
              email: userData['email'],
              name: userData['name'],
              role: role,
              organizationId: userData['organization_id'],
              organizationName: userData['organization_name'],
              phone: userData['phone'],
              photoPath: userData['photo_path'],
            );
            
            if (mounted) {
              _showSuccessAndNavigate('/karyawan-home', 'Selamat datang, ${userData['name']}!');
            }
            break;

          case 'admin':
          case 'owner':
            await SharedPrefsHelper.saveAdminSession(
              userId: userData['user_id'],
              email: userData['email'],
              name: userData['name'],
              role: role,
              organizationId: userData['organization_id'],
              organizationName: userData['organization_name'],
              phone: userData['phone'],
              photoPath: userData['photo_path'],
            );
            
            if (mounted) {
              _showSuccessAndNavigate('/admin-home', 'Selamat datang, Admin ${userData['name']}!');
            }
            break;

          case 'personal':
            await SharedPrefsHelper.savePersonalSession(
              userId: userData['user_id'],
              email: userData['email'],
              name: userData['name'],
              phone: userData['phone'],
              photoPath: userData['photo_path'],
            );
            
            if (mounted) {
              _showSuccessAndNavigate('/personal-home', 'Selamat datang, ${userData['name']}!');
            }
            break;

          case 'super_admin':
            _showWebOnlyDialog();
            break;

          default:
            _showErrorDialog('Role tidak dikenal: $role');
        }
      } else {
        _showErrorDialog(response['message'] ?? 'Login gagal');
      }
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan. Periksa koneksi internet Anda.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessAndNavigate(String route, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.go(route);
      }
    });
  }

  void _showWebOnlyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Akses Khusus Web'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.computer, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Akun super admin hanya dapat diakses melalui web dashboard.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Silakan gunakan komputer Anda untuk login ke sistem.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _emailController.clear();
              _passwordController.clear();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Login Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Masukkan email Anda untuk menerima link reset password'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Link reset password akan dikirim (Fitur menyusul)'),
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Back button
              ScaleAnimation(
                child: IconButton(
                  onPressed: () => context.go('/login-method'),
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

              // Header
              FadeInSlide(
                offset: const Offset(0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _roleDisplay.isEmpty ? 'Welcome Back' : _roleDisplay,
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _accentColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _roleDisplay.isEmpty 
                          ? 'Sign in to continue'
                          : 'Sign in as $_roleDisplay',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Email field
              FadeInSlide(
                offset: const Offset(0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'email@company.com',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Password field
              FadeInSlide(
                offset: const Offset(0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _showForgotPasswordDialog,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: _accentColor),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Login button
              FadeInSlide(
                offset: const Offset(0, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Google Sign In (disabled for now)
              FadeInSlide(
                offset: const Offset(0, 20),
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Google Sign-In akan tersedia di update berikutnya'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.g_mobiledata, size: 24),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: BorderSide(color: Colors.grey.shade300),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // // Demo accounts hint (only in debug mode)
              // if (kDebugMode)
              //   Container(
              //     padding: const EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade100,
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           'Demo Accounts:',
              //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              //         ),
              //         const SizedBox(height: 4),
              //         Text(
              //           'Karyawan: budi.santoso@gmail.com / password\nAdmin: admin.alfitrah@gmail.com / password',
              //           style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              //         ),
              //       ],
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}