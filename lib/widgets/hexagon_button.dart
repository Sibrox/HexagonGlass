import 'package:flutter/cupertino.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter/material.dart';

class HexagonButton extends StatefulWidget {
  final double width;
  final Function changeColor;
  final Color color;
  final int num;

  const HexagonButton(
      {Key? key,
      required this.width,
      required this.changeColor,
      required this.color,
      required this.num})
      : super(key: key);

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
    hexagonWidthAnimated = hexagonWidthFixed = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (tapDetails) {
        setState(() {
          hexagonWidthAnimated *= 1.2;
          textScale = 15;
        });
        widget.changeColor();
      },
      onTapDown: (tapDetails) {
        setState(() {
          hexagonWidthAnimated /= 1.2;
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
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceOut,
              child: ClipPolygon(
                sides: 6,
                borderRadius: 0,
                rotate: 60,
                child: Container(
                  color: widget.color,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(fontSize: textScale),
                      child: Stack(
                    children: [
                          // The text border
                          Text(
                          '${widget.num}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = Colors.black,
                            ),
                          ),
                          // The text inside
                           Text(
                            '${widget.num}',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
