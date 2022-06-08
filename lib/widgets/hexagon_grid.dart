import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/hexagon_core.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';

class Grid extends StatefulWidget {
  final HexagonGame gameGrid;
  final double width;
  final double height;
  const Grid(
      {Key? key,
      required this.gameGrid,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  late HexagonGame gameLogic;

  late double rowWidth;
  late double hexagonWidth;
  late double apothem;
  late double border;
  late double marginSpace = 0.0;

  @override
  void initState() {
    super.initState();
    gameLogic = widget.gameGrid;

    var deviceWidth = widget.width;
    var deviceHeight = widget.height;
    var marginPer = 0.2;

    marginSpace = deviceWidth * marginPer;
    rowWidth = deviceWidth - 0;

    hexagonWidth =  rowWidth/ gameLogic.nColumns();
    apothem = hexagonWidth / 2 * sqrt(3) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(
          widget.gameGrid.nRows(),
          (i) => Positioned(
                left: i % 2 != 0 ? apothem + apothem / 2 : 0 + apothem / 2 ,
                top: (i * (3 / 4 * hexagonWidth) +
                        (apothem * gameLogic.nRows() / 4)) +
                    ((widget.height - (hexagonWidth * gameLogic.nRows())) / 2) + (i * 10),
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    spacing: -(hexagonWidth - (apothem * 2)) + 10,
                    children: List.generate(
                        widget.gameGrid.nColumns(),
                        (j) => HexagonButton(
                            width: hexagonWidth,
                            num: widget.gameGrid.gameGrid[i][j].value,
                            changeColor: () => {
                                  setState(() {
                                    gameLogic.changeColor(i, j);
                                  })
                                },
                            color: gameLogic.gameGrid[i][j].color ==
                                    ButtonColor.color_1
                                ? const Color(0xFFFFD700)
                                : gameLogic.gameGrid[i][j].color ==
                                        ButtonColor.color_2
                                    ? const Color(0xFF3EA1CD)
                                    : Colors.grey))),
              )),
    );
  }
}
