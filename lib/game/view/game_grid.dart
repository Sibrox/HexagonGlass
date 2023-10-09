import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon_glass/game/bloc/game_bloc.dart';
import 'package:hexagon_glass/game/game.dart';
import 'package:hexagon_glass/game/view/hexagon_cell.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  bool isOdd(int num) {
    return num % 2 != 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, Game>(builder: (context, state) {
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
        var nHexesPerRow = state.nCol;
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
              state.nRow,
              (nRow) => Positioned(
                  left: ((isOdd(nRow) ? hexagonApothem / 2 : 0)) +
                      clippedValue * (state.nCol - 1) / 2,
                  top: ((hexagonSide - clippedValue * 2) * nRow) +
                      (widgetGridHeight -
                              ((hexagonSide / 2 + clippedValue) *
                                  (state.nRow + 1))) /
                          2,
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      spacing: -clippedValue,
                      children: List.generate(
                          state.nCol,
                          (nCol) => HexagonCell(
                              cellInfo: state.status[nRow][nCol],
                              size: hexagonSide)))),
            ));
      });
    });
  }
}
