import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon_glass/core/game_logic.dart';
import 'package:hexagon_glass/game/bloc/game_bloc.dart';
import 'package:hexagon_glass/game/game.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/animated/animated_pulse.dart';

import 'package:hexagon_glass/game/view/game_grid.dart';

import '../core/player_status.dart';

class Level extends StatefulWidget {
  final int level;
  final PlanetTheme currentTheme;

  const Level({
    Key? key,
    required this.currentTheme,
    required this.level,
  }) : super(key: key);

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> with TickerProviderStateMixin {
  late GameLogic gameLogic;

  var animationTime = const Duration(milliseconds: 1000);

  late final AnimationController _controllerRotation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  bool completed = false;

  @override
  void initState() {
    super.initState();
    gameLogic = GameLogic(GridType.hexagon,
        width: widget.currentTheme.levelDimension[0],
        height: widget.currentTheme.levelDimension[1]);
  }

  @override
  void dispose() {
    _controllerRotation.dispose();
    super.dispose();
  }

  void onGameClick(int i, int j) {
    setState(() {
      gameLogic.status.changeColor(i, j);
      completed = gameLogic.checkGame();
      if (completed) {
        Status.instance.updateLvlStatus(widget.currentTheme.difficult,
            widget.level, widget.currentTheme.position);
        Navigator.of(context).pop();
      }
    });
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
                child: Hero(
                  tag: "background",
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image:
                              AssetImage(widget.currentTheme.background_path),
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
                  ),
                )),
            Flexible(flex: 8, child: GameGrid(theme: widget.currentTheme)),
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
                            child: Hero(
                                tag: "planet",
                                child: AnimatedPulse(
                                  child: Image.asset(
                                    (widget.currentTheme.planet_path),
                                    fit: BoxFit.contain,
                                  ),
                                  duration: const Duration(milliseconds: 800),
                                ))),
                      ),
                      DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Rowdies',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(widget.level == 0
                              ? "Level ∞"
                              : "Level " + widget.level.toString())),
                      Flexible(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                  onTap: () {
                                    _controllerRotation.reset();
                                    _controllerRotation.forward();

                                    BlocProvider.of<GameBloc>(context).add(const GameReloadEvent());
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: AnimatedBuilder(
                                          animation: _controllerRotation,
                                          builder: (_, child) {
                                            return Transform.rotate(
                                              angle: _controllerRotation.value *
                                                  2 *
                                                  pi,
                                              child: child,
                                            );
                                          },
                                          child: Image.asset(
                                              "images/icons/refresh_icon.png"))))))
                    ],
                  ),
                ))
          ],
        ));
  }
}
