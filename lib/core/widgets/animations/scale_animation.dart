import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class ScaleAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double beginScale;
  final double endScale;

  const ScaleAnimation({
    super.key,
    required this.child,
    this.duration = AppConstants.animNormal,
    this.curve = Curves.easeOutBack,
    this.beginScale = 0.8,
    this.endScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: beginScale, end: endScale),
      duration: duration,
      curve: curve,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: child,
    );
  }
}

class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}