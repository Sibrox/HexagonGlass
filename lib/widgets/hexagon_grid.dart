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
  final String type;
  final Function(int, int) onClick;

  const HexagonGrid({Key? key,
    required this.grid,
    required this.currentTheme,
    required this.onClick,
    required this.type,
  })
      : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<HexagonGrid> {

  late BlockGrid grid;
  @override
  void initState() {
    super.initState();
    grid = widget.grid;
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
          var hexagonWidth = rowWidth / grid.nCol;
          var apothem = hexagonWidth / 2 * sqrt(3) / 2;
          int buttonCounter = 0;
          
          bool isEnableLogic(String type){

            bool finalValue = true;

            if(type == "menu"){
              if(buttonCounter++ <= Status.instance.getLastLv("hexagon",widget.currentTheme.difficult)){

                finalValue = true;
              }
              else{
                finalValue = false;
              }
            }

            return finalValue;
          }

          return Stack(
              alignment: Alignment.center,
              children: List.generate(
                grid.nRow,
                    (i) => Positioned(
                    left: i % 2 != 0 ? 3 / 2 * apothem : apothem / 2,
                    top: (i * (3 / 4 * hexagonWidth) +
                        (apothem * grid.nRow / 4)) +
                        ((deviceWHeight - (hexagonWidth * grid.nRow)) / 2),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      spacing: -(hexagonWidth - (apothem * 2)),
                      children: List.generate(
                          grid.nCol,
                              (j) => HexagonButton(
                            isEnable: grid.grid[i][j].isVisible ? isEnableLogic(widget.type): false,
                            width: hexagonWidth,
                            onClick: () {
                              if(grid.grid[i][j].isVisible) {
                                setState(() {
                                  widget.onClick(i, j);
                                });
                              }
                            },
                            block: grid.grid[i][j],
                            currentTheme: widget.currentTheme,
                          )),
                    )),
              ));
        });
  }
}
