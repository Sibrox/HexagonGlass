import 'package:flutter/material.dart';

import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:hexagon_glass/core/block.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/ui/stroke_text.dart';

class SquareButton extends StatefulWidget {
  final double width;
  final Function onClick;
  final Block block;
  final PlanetTheme currentTheme;

  const SquareButton(
      {Key? key,
      required this.width,
      required this.onClick,
      required this.block,
      required this.currentTheme})
      : super(key: key);

  @override
  _HexagonButtonState createState() => _HexagonButtonState();
}

class _HexagonButtonState extends State<SquareButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutBack,
  );

  double hexagonWidthAnimated = 0.0;
  double hexagonWidthFixed = 0.0;
  double textScale = 15;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.forward();
    hexagonWidthAnimated = widget.width * 0.85;
    hexagonWidthFixed = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (tapDetails) {
        setState(() {
          hexagonWidthAnimated *= 5;
          textScale = 15;
        });
        widget.onClick();
      },
      onTapDown: (tapDetails) {
        setState(() {
          hexagonWidthAnimated /= 5;
          textScale = 10;
        });
      },
      child: SizedBox(
        width: hexagonWidthFixed,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: AnimatedContainer(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: hexagonWidthAnimated,
              height: hexagonWidthAnimated,
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceOut,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.block.color != BlockColor.color_1
                      ? widget.block.color != BlockColor.color_2
                          ? !widget.block.isVisible
                              ? Colors.transparent
                              : widget.currentTheme.no_color
                          : widget.currentTheme.color_2
                      : widget.currentTheme.color_1,
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style:
                          TextStyle(fontSize: textScale, fontFamily: 'Rowdies'),
                      child: StrokeText(
                          text: widget.block.isVisible
                              ? '${widget.block.value}'
                              : "")),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
