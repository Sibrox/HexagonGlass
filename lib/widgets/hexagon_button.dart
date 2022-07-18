import 'package:flutter/material.dart';

import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:hexagon_glass/core/block.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/ui/stroke_text.dart';

class HexagonButton extends StatefulWidget {
  final double width;
  final Function onClick;
  final Block block;
  final PlanetTheme currentTheme;

  const HexagonButton({Key? key,
    required this.width,
    required this.onClick,
    required this.block,
    required this.currentTheme
  }): super(key: key);

  @override
  _HexagonButtonState createState() => _HexagonButtonState();
}

class _HexagonButtonState extends State<HexagonButton>
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
    hexagonWidthAnimated = widget.width * 0.87;
    hexagonWidthFixed = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (tapDetails) {
        if(widget.block.isEnabled){
          setState(() {
            hexagonWidthAnimated *= 5;
            textScale = 15;
          });
          widget.onClick();
        }
      },
      onTapDown: (tapDetails) {

        if(widget.block.isEnabled){
          setState(() {
            hexagonWidthAnimated /= 5;
            //TODO: change hardcode
            textScale = 10;
          });
        }
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
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceOut,
              child: ClipPolygon(
                sides: 6,
                borderRadius: 0,
                rotate: 60,
                boxShadows: [
                  PolygonBoxShadow(
                      color: Colors.black,
                      elevation: widget.block.isVisible ? 5.0 : 0)
                ],
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
                        style: TextStyle(
                            fontSize: textScale, fontFamily: 'Rowdies'),
                        child: StrokeText(
                          text: widget.block.isVisible
                            ? '${widget.block.value}'
                            : ""
                        )
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
