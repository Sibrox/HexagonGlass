import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/ui/pulse.dart';

import '../core/hexagon_core.dart';
import '../widgets/hexagon_grid.dart';

class Level extends StatefulWidget {
  HexagonTheme currentTheme;
  Level({Key? key, required this.currentTheme}) : super(key: key);

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> with TickerProviderStateMixin {
  HexagonGame hexagonGrid = HexagonGame.create(6, 10);

  var animationTime = const Duration(milliseconds: 1000);

  late final AnimationController _controllerIdle = AnimationController(
    duration: animationTime,
    vsync: this,
    lowerBound: 0.8,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controllerIdle,
    curve: Curves.easeOut,
  );

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
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.currentTheme.gradient_1,
            widget.currentTheme.gradient_2,
          ],
        )),
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        image: AssetImage(widget.currentTheme.background_path),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 8,
                child: Grid(
                  gameGrid: hexagonGrid,
                  currentTheme: widget.currentTheme,
                )),
            Flexible(
                flex: 1,
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              //TODO: it is an error -> How use navigator outside build?
                              Navigator.pop(context);
                            },
                            child: Pulse (
                              child: Image.asset(
                                (widget.currentTheme.planet_path),
                                fit: BoxFit.contain,
                              ),
                              duration: const Duration(milliseconds: 800),
                            )
                          )),
                      const DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Rowdies',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text("5 / 10")),
                      Flexible(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                  child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Image.asset("images/refresh_icon.png"),
                              ))))
                    ],
                  ),
                ))
          ],
        ));
  }
}
