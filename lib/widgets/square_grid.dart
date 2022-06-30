import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexagon_glass/core/block_grid.dart';
import 'package:hexagon_glass/widgets/hexagon_button.dart';

import 'package:hexagon_glass/ui/hexagon_theme.dart';
import 'package:hexagon_glass/widgets/square_button.dart';

class SquareGrid extends StatefulWidget {
  final BlockGrid grid;
  final PlanetTheme currentTheme;
  final Function(int, int) onClick;

  const SquareGrid({Key? key,
    required this.grid,
    required this.currentTheme,
    required this.onClick
  })
      : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<SquareGrid> {

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
          var rowWidth = deviceWidth - 0;
          var width = rowWidth / grid.nCol;
          var apothem = width / 2 * sqrt(3) / 2;

          return Stack(
              alignment: Alignment.center,
              children: List.generate(
                grid.nRow,
                    (i) => Positioned(
                    top: i * width,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                          grid.nCol,
                              (j) => SquareButton(
                            width: width,
                            onClick: () {
                              setState(() {
                                widget.onClick(i,j);
                              });
                            },
                            block: grid.grid[i][j],
                            currentTheme: widget.currentTheme,
                          )),
                    )),
              ));
        });
  }
}
