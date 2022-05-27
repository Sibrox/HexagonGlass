import 'package:flutter/cupertino.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';


class HexagonBottom extends StatefulWidget {

  final double width;
  final Function changeColor;
  final Color color;
  final int num;

  const HexagonBottom({
    Key? key,
    required this.width,
    required this.changeColor,
    required this.color,
    required this.num
  }) : super(key: key);

  @override
  _HexagonBottomState createState() => _HexagonBottomState();
}

class _HexagonBottomState extends State<HexagonBottom> with TickerProviderStateMixin {
  @override

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

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _controller.forward();
    hexagonWidthAnimated = hexagonWidthFixed = widget.width;
  }

  Widget build(BuildContext context) {

    return GestureDetector(
        onTapUp: (tapDetails) {
            setState(() {
              hexagonWidthAnimated *= 1.2;
            });
            widget.changeColor();
        },
        onTapDown: (tapDetails){
          setState(() {
            hexagonWidthAnimated /= 1.2;
          });
        },
        child: SizedBox(
            width: hexagonWidthFixed,
            child: Center(
              child: Stack(
                children: <Widget>[
                ScaleTransition(
                  scale: _animation,
                  child: AnimatedContainer(
                    width: hexagonWidthAnimated,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.bounceOut,
                    child: ClipPolygon(
                      sides: 6,
                      borderRadius: 5,
                      rotate: 0,
                      child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          color: widget.color
                      ),
                    ),
                  ),
                ),
                  Positioned(
                      left: hexagonWidthFixed / 2 * -1,
                      top: hexagonWidthFixed / 2 * -1,
                      child: Text('${widget.num}',
                      ),
                  )
                ],
              )
            ),
          ),
      );
  }
}