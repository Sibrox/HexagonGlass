import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/block_grid.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';
import 'package:hexagon_glass/ui/hexagon_theme.dart';
import '../core/player_status.dart';

class HexagonGrid extends StatefulWidget {
  final BlockGrid grid;
  final PlanetTheme currentTheme;
  final Function(int, int) onClick;

  const HexagonGrid({
    Key? key,
    required this.grid,
    required this.currentTheme,
    required this.onClick,
  }) : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

bool isOdd(int num) {
  return num % 2 != 0;
}

class _GameGridState extends State<HexagonGrid> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrain) {
      var widgetGridWidth = constrain.biggest.width;
      var widgetGridHeight = constrain.biggest.height;

      //          Hexagon
      //        ___________
      //      /             \
      //     /               \
      //    /   r             \
      //    ---------.         -
      //    \       /|\       /
      //     \    / a| \     / L
      //      \ /    |   \  /
      //        -----------

      // a = (r  * (sqrt(3)) / 2
      // r = (2 * apothem) / sqrt(3)

      // N.B: hexagon is drawn ROTATED respected the screen
      double hexagonSide; // r = L
      double hexagonApothem; // a

      // This means:
      // - 'nRow' is the constrain if widgetGridWidth < widgetGridHeight
      // - 'nCol' is the constrain if widgetGridHeight < widgetGridWidth
      var nHexesPerRow = widget.grid.nCol;
      var availableSpace = widgetGridWidth;

      hexagonSide = availableSpace / (nHexesPerRow);
      hexagonApothem = (hexagonSide * sqrt(3)) / 2;

      // every hex is built in a widget square of hexagonSide
      // rightSide and leftSide are distant 2 * hexagonApothem
      // this means that every time I render an hex
      // it takes clippedValue empty space on the right and on the left
      var clippedValue = hexagonSide - hexagonApothem;
      return Stack(
          alignment: Alignment.center,
          children: List.generate(
            widget.grid.nRow,
            (nRow) => Positioned(
                left: ((isOdd(nRow) ? hexagonApothem / 2 : 0)) +
                    clippedValue * (widget.grid.nCol - 1) / 2,
                top: ((hexagonSide - clippedValue * 2) * nRow)
                    + (widgetGridHeight - ((hexagonSide / 2 + clippedValue) * (widget.grid.nRow + 1))) / 2
                    ,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  spacing: -clippedValue,
                  children: List.generate(
                      widget.grid.nCol,
                      (nCol) => HexagonButton(
                            width: hexagonSide,
                            onClick: () {
                              if (widget.grid.matrix[nRow][nCol].isVisible) {
                                setState(() {
                                  widget.onClick(nRow, nCol);
                                });
                              }
                            },
                            block: widget.grid.matrix[nRow][nCol],
                            currentTheme: widget.currentTheme,
                          )),
                )),
          ));
    });
  }
}
