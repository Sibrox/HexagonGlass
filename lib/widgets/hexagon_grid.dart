import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';

class Grid extends StatefulWidget {
  final HexagonGame gameGrid;
  final HexagonTheme currentTheme;

  const Grid({Key? key, required this.gameGrid, required this.currentTheme})
      : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  late HexagonGame gameLogic;

  @override
  void initState() {
    super.initState();
    gameLogic = widget.gameGrid;
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
            widget.gameGrid.nRows(),
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
                      widget.gameGrid.nColumns(),
                      (j) => HexagonButton(
                            width: hexagonWidth,
                            changeColor: () => {
                              if (gameLogic.gameGrid[i][j].value != -1)
                                {
                                  setState(() {
                                    gameLogic.changeColor(i, j);
                                  })
                                }
                            },
                            block: gameLogic.statusGrid[i][j],
                            currentTheme: widget.currentTheme,
                          )),
                )),
          ));
    });
  }
}
