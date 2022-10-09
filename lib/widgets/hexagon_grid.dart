import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/block_grid.dart';
import 'package:hexagon_glass/core/game_logic.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/square_button.dart';

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

class _GameGridState extends State<HexagonGrid> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrain) {
      var deviceWidth = constrain.biggest.width;
      var deviceWHeight = constrain.biggest.height;

      var margin = deviceWidth * 0.05;
      deviceWidth = deviceWidth - margin;
      var rowWidth = deviceWidth - 0;
      var hexagonWidth = rowWidth / widget.grid.nCol;
      var apothem = hexagonWidth / 2 * sqrt(3) / 2;

      return Stack(
          alignment: Alignment.center,
          children: List.generate(
            widget.grid.nRow,
            (i) => Positioned(
                left: i % 2 != 0 ? 3 / 2 * apothem : apothem / 2,
                top: (i * (3 / 4 * hexagonWidth) +
                        (apothem * widget.grid.nRow / 4)) +
                    ((deviceWHeight - (hexagonWidth * widget.grid.nRow)) / 2),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  spacing: -(hexagonWidth - (apothem * 2)),
                  children: List.generate(
                      widget.grid.nCol,
                      (j) => HexagonButton(
                            width: hexagonWidth,
                            onClick: () {
                              if (widget.grid.matrix[i][j].isVisible) {
                                setState(() {
                                  widget.onClick(i, j);
                                });
                              }
                            },
                            block: widget.grid.matrix[i][j],
                            currentTheme: widget.currentTheme,
                          )),
                )),
          ));
    });
  }
}
