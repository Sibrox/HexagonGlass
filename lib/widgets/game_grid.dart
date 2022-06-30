import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/game_logic.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';

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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrain) {
      var deviceWidth = constrain.biggest.width;
      var deviceWHeight = constrain.biggest.height;

      var margin = deviceWidth * 0.05;
      deviceWidth = deviceWidth - margin;
      var rowWidth = deviceWidth - 0;
      var hexagonWidth = rowWidth / gameLogic.nColumns();
      var apothem = hexagonWidth / 2 * sqrt(3) / 2;

      return Stack(
          alignment: Alignment.center,
          children: List.generate(
            widget.gameLogic.nRows(),
            (i) => Positioned(
                left: i % 2 != 0 ? 3 / 2 * apothem : apothem / 2,
                top: (i * (3 / 4 * hexagonWidth) +
                        (apothem * gameLogic.nRows() / 4)) +
                    ((deviceWHeight - (hexagonWidth * gameLogic.nRows())) / 2),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  spacing: -(hexagonWidth - (apothem * 2)),
                  children: List.generate(
                      widget.gameLogic.nColumns(),
                      (j) => HexagonButton(
                            width: hexagonWidth,
                            onClick: () {
                              setState(() {
                                widget.onClick(i,j);
                              });
                            },
                            block: gameLogic.status.grid[i][j],
                            currentTheme: widget.currentTheme,
                          )),
                )),
          ));
    });
  }
}
