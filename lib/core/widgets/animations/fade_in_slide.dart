import 'package:flutter/material.dart';

class FadeInSlide extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset offset;
  final bool animate;

  const FadeInSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
    this.offset = const Offset(0, 20),
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!animate) return child;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: offset * (1 - value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class StaggeredAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration startDelay;
  final Duration interval;
  final Curve curve;

  const StaggeredAnimation({
    super.key,
    required this.children,
    this.startDelay = const Duration(milliseconds: 100),
    this.interval = const Duration(milliseconds: 100),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.asMap().entries.map((entry) {
        final child = entry.value;
        
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          curve: curve,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: child,
        );
      }).toList(),
    );
  }
}

// Optional: Add a version with delay support
class DelayedFadeInSlide extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset offset;

  const DelayedFadeInSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.offset = const Offset(0, 20),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: duration,
          curve: curve,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: offset * (1 - value),
                child: child,
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}