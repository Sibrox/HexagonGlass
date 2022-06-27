import 'package:flutter/material.dart';

class AnimatedPop extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final RelativeRect begin;
  final RelativeRect stop;
  const AnimatedPop({
    Key? key,
    required this.duration,
    required this.child,
    required this.begin,
    required this.stop,
  }) : super(key: key);

  @override
  _AnimatedPopState createState() => _AnimatedPopState();
}

class _AnimatedPopState extends State<AnimatedPop>
    with TickerProviderStateMixin {
  late final AnimationController _controllerPlanet = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  @override
  void dispose() {
    _controllerPlanet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerPlanet.reset();
    _controllerPlanet.forward();

    return PositionedTransition(
        rect: RelativeRectTween(begin: widget.begin, end: widget.stop).animate(
            CurvedAnimation(
                parent: _controllerPlanet, curve: Curves.elasticIn)),
        child: widget.child);
  }
}
