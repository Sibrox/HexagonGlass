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

  @override
  void initState() {
    super.initState();
    gameLogic = widget.gameGrid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.gameGrid.nRows(), (i) =>
          Row(
            children:List.generate(widget.gameGrid.nColumns(), 
                    (j) => HexagonBottom (
                        width: 100,
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
          )
      ),
    );
  }
}
