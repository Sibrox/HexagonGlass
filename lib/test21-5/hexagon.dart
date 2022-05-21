import 'package:flutter/cupertino.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter/material.dart';

class HexagonBottom extends StatefulWidget {
  const HexagonBottom({Key? key}) : super(key: key);

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

  var deviceWidth = WidgetsBinding.instance?.window.physicalSize.width;
  var marginPerc = 0.1;
  var marginSpace = 0.0;
  var hexagonBox = 0.0;
  var hexagonNumber = 8;
  var hexagonLength = 0.0;

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _controller.forward();
    marginSpace = deviceWidth!*marginPerc;
    hexagonBox = deviceWidth!-marginSpace;
    hexagonLength = hexagonBox/hexagonNumber;
  }

  Widget build(BuildContext context) {

    return GestureDetector(
        onTapUp: (tapDetails) {
            setState(() {
              hexagonLength *= 1.2;
            });
        },
        onTapDown: (tapDetails){

          setState(() {
            hexagonLength = hexagonLength/1.2;
          });
        },
        child: ScaleTransition(
          scale: _animation,
          child: AnimatedContainer(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            height: hexagonLength,
            width: hexagonLength,
            duration: const Duration(milliseconds: 400),
            curve: Curves.bounceOut,
            child: ClipPolygon(
              sides: 6,
              borderRadius: 5,
              rotate: 0,
              child: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff1f005c),
                      Color(0xff5b0060),
                      Color(0xff870160),
                      Color(0xffac255e),
                      Color(0xffca485c),
                      Color(0xffe16b5c),
                      Color(0xfff39060),
                      Color(0xffffb56b),
                    ], // Gradient from https://learnui.design/tools/gradient-generator.html
                    tileMode: TileMode.mirror,
                  ),
                ),
              ),
            ),
          ),
        )
      );
  }
}
