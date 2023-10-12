import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPulse extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const AnimatedPulse({
    Key? key,
    required this.child,
    required this.duration,
  }) : super(key: key);

  @override
  _AnimatedPulseState createState() => _AnimatedPulseState();
}

class _AnimatedPulseState extends State<AnimatedPulse>
    with TickerProviderStateMixin {
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controllerIdle,
    curve: Curves.easeOut,
  );

  late final AnimationController _controllerIdle = AnimationController(
    duration: widget.duration,
    vsync: this,
    lowerBound: 0.8,
  )..repeat(reverse: true);

  late final AnimationController _controllerRotation =
      AnimationController(vsync: this, duration: const Duration(seconds: 100))
        ..repeat();

  @override
  void dispose() {
    _controllerIdle.dispose();
    _controllerRotation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation,
        child: AnimatedBuilder(
            animation: _controllerRotation,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controllerRotation.value * 2 * pi,
                child: child,
              );
            },
            child: widget.child));
  }
}
