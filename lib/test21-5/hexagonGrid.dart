import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/test21-5/hexagon.dart';

class Grid extends StatefulWidget {

  final HexagonGame gameGrid;
  const Grid({Key? key, required this.gameGrid }) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {

  late HexagonGame gameLogic;

  late double rowWidth;
  late double hexagonWidth;
  late double apothem;

  @override
  void initState() {
    super.initState();
    gameLogic = widget.gameGrid;

    var deviceWidth = WidgetsBinding.instance.window.physicalSize.width;
    var marginPer = 0.1;
    var marginSpace = 0.0;
    marginSpace = deviceWidth * marginPer;
    rowWidth = deviceWidth - marginSpace;
    hexagonWidth = rowWidth/gameLogic.nRows();
    apothem = hexagonWidth / 2 * sqrt(3) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget.gameGrid.nRows(), (i) =>
      Positioned(
        left: i%2 != 0 ?  apothem : 0 ,
        //top:  3 * (i * sqrt( pow(hexagonWidth/2, 2) - pow(apothem, 2) )) ,
        top: i* 3 / 4 * hexagonWidth,
      child:           Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.start,
            spacing: - (hexagonWidth - (apothem * 2)),
            children: List.generate(widget.gameGrid.nColumns(),
                    (j) => HexagonBottom (
                    width: hexagonWidth,
                    num: widget.gameGrid.gameGrid[i][j].value,
                    changeColor: () =>
                    {
                      setState(() {
                        gameLogic.changeColor(i, j);
                      })
                    },
                    color:
                    gameLogic.gameGrid[i][j].color == ButtonColor.color_1 ?
                    Colors.blue : gameLogic.gameGrid[i][j].color == ButtonColor.color_2?
                    Colors.red : Colors.grey
                )
            )
        ),
      )

      ),
    );
  }
}
