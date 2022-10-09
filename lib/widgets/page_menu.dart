import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexagon_glass/animated/animated_pop.dart';
import 'package:hexagon_glass/animated/animated_pulse.dart';
import 'package:hexagon_glass/core/block_grid.dart';
import 'package:hexagon_glass/screens/level.dart';
import 'package:hexagon_glass/ui/stroke_text.dart';
import 'package:hexagon_glass/widgets/hexagon_grid.dart';

import '../core/game_logic.dart';
import '../core/player_status.dart';
import '../ui/hexagon_theme.dart';
import 'game_grid.dart';

class PageMenu extends StatefulWidget {
  PlanetTheme currentTheme;

  PageMenu({Key? key, required this.currentTheme}) : super(key: key);

  @override
  _PageMenuState createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  late BlockGrid menuGrid =
      BlockGrid.fromString(widget.currentTheme.gridMenu, isMenu: true);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext contextText, BoxConstraints constraints) {
      var planetFlex = 2;
      var boxLevelFlex = 8;
      var boxPlanetFlex = 3;
      var total = planetFlex + boxLevelFlex + boxPlanetFlex;
      var unit = constraints.biggest.height / total;

      var planetDim = unit * planetFlex;
      var boxLevelDim = unit * boxLevelFlex;
      var boxPlanetDim = unit * boxPlanetFlex;

      return Stack(
        children: [
          // Box levels
          Positioned(
            height: boxLevelDim,
            width: constraints.biggest.width,
            child: Container(
                margin:
                    EdgeInsets.only(top: planetDim / 2, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black.withOpacity(0.25)),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: HexagonGrid(
                      currentTheme: widget.currentTheme,
                      grid: menuGrid,
                      onClick: (i, j) {
                        Navigator.of(context)
                            .push(
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 800),
                                reverseTransitionDuration:
                                    Duration(milliseconds: 500),
                                pageBuilder: (_, __, ___) => Level(
                                  currentTheme: widget.currentTheme,
                                  level: menuGrid.matrix[i][j].value,
                                ),
                                transitionsBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    Widget child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            )
                            .then((value) => {
                                  setState(() {
                                    menuGrid = BlockGrid.fromString(
                                        widget.currentTheme.gridMenu,
                                        isMenu: true);
                                  })
                                });
                      }),
                )),
          ),
          Positioned(
            top: 30,
            left: 40,
            child: StrokeText(
              text: widget.currentTheme.difficult,
              fontSize: 40,
            ),
          ),
          // Box levels
          AnimatedPop(
              begin: RelativeRect.fromSize(
                  Rect.fromLTWH(constraints.biggest.width / 2,
                      boxLevelDim + planetDim / 6, 0, 0),
                  constraints.biggest),
              stop: RelativeRect.fromSize(
                  Rect.fromLTWH(0, boxLevelDim + planetDim / 6,
                      constraints.biggest.width, boxPlanetDim),
                  constraints.biggest),
              duration: Duration(milliseconds: 1000),
              child: Hero(
                tag: "background",
                child: Container(
                  margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.black.withOpacity(0.25),
                    image: DecorationImage(
                      image: AssetImage(widget.currentTheme.background_path),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0,
                            3), // changes position of shadow // changes position of shadow
                      ),
                    ],
                  ),
                ),
              )),
          // Box levels
          AnimatedPop(
              begin: RelativeRect.fromSize(
                  Rect.fromLTWH(
                      constraints.biggest.width / 2 - planetDim / 2 * 1.6,
                      boxLevelDim - planetDim / 6 * 1.6,
                      planetDim * 1.6,
                      planetDim * 1.6),
                  constraints.biggest),
              stop: RelativeRect.fromSize(
                  Rect.fromLTWH(constraints.biggest.width / 2 - planetDim / 2,
                      boxLevelDim - planetDim / 6, planetDim, planetDim),
                  constraints.biggest),
              duration: Duration(milliseconds: 1000),
              child: Hero(
                  tag: "planet",
                  child: AnimatedPulse(
                    child: Image.asset(
                      (widget.currentTheme.planet_path),
                      fit: BoxFit.contain,
                    ),
                    duration: const Duration(milliseconds: 800),
                  ))),
        ],
      );
    });
  }
}

class Planet extends StatelessWidget {
  final String planet_path;
  const Planet({Key? key, required this.planet_path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            )
          ],
        ),
        child: ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Image.asset(planet_path))));
  }
}
