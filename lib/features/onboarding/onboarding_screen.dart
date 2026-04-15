import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartpresensi/data/datasources/local/shared_prefs_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/animations/fade_in_slide.dart';
import 'widgets/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Smart Attendance',
      description: 'Check-in and check-out with GPS verification and selfie authentication',
      icon: Icons.fingerprint,
      color: AppColors.primary,
    ),
    OnboardingData(
      title: 'Real-time Tracking',
      description: 'Monitor your team\'s location in real-time with live updates',
      icon: Icons.location_on,
      color: AppColors.adminPrimary,
    ),
    OnboardingData(
      title: 'Activity Reports',
      description: 'Upload photos and document field activities with ease',
      icon: Icons.assignment,
      color: AppColors.personalPrimary,
    ),
    OnboardingData(
      title: 'Get Started',
      description: 'Join your organization and start tracking attendance today',
      icon: Icons.rocket_launch,
      color: AppColors.success,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  AppColors.background,
                ],
              ),
            ),
          ),
          
          // Main content
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return FadeInSlide(
                      duration: const Duration(milliseconds: 500),
                      offset: const Offset(0, 30),
                      child: OnboardingItem(
                        title: page.title,
                        description: page.description,
                        icon: page.icon,
                        color: page.color,
                      ),
                    );
                  },
                ),
              ),
              
              // Page indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: _pages[_currentPage].color,
                  dotColor: Colors.grey.shade300,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                  spacing: 8,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    if (_currentPage == _pages.length - 1)
                      FadeInSlide(
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Save first launch flag
                            SharedPrefsHelper.setFirstLaunchDone();
                            context.go('/login-method');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _pages[_currentPage].color,
                            minimumSize: const Size(double.infinity, 56),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    else
                      FadeInSlide(
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // TODO: Save first launch flag
                                  SharedPrefsHelper.setFirstLaunchDone();
                                  context.go('/login-method');
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(color: _pages[_currentPage].color),
                                ),
                                child: const Text('Skip'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOutCubic,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _pages[_currentPage].color,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text('Next'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}