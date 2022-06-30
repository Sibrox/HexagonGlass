import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/game_logic.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/hexagon_grid.dart';
import 'package:hexagon_glass/widgets/square_button.dart';
import 'package:hexagon_glass/widgets/square_grid.dart';

class GameGrid extends StatefulWidget {
  final GameLogic gameLogic;
  final PlanetTheme currentTheme;
  final Function(int, int) onClick;

  const GameGrid({Key? key,
    required this.gameLogic,
    required this.currentTheme,
    required this.onClick, required gameGrid
  })
      : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  late GameLogic gameLogic;

  @override
  void initState() {
    super.initState();
    gameLogic = widget.gameLogic;
  }

  @override
  Widget build(BuildContext context) {
    return gameLogic.type == GridType.hexagon ?
      HexagonGrid(
          grid: gameLogic.status,
          currentTheme: widget.currentTheme,
          onClick: widget.onClick,
      ) :
      SquareGrid(
          grid: gameLogic.status,
          currentTheme: widget.currentTheme,
          onClick: widget.onClick,
      );
  }
}
