import 'dart:convert';
import 'dart:math';

import 'package:hexagon_glass/core/block.dart';

class BlockGrid {
  late int nCol, nRow;
  late List<List<Block>> matrix;

  BlockGrid() {
    nCol = 0;
    nRow = 0;
    matrix = [[]];
  }

  BlockGrid.buildRandom(this.nCol, this.nRow, [int? seed]) {
    var randomGenerator = Random(seed);

    matrix = [];
    for (int i = 0; i < nRow; i++) {
      matrix.add([]);
      for (int j = 0; j < nCol; j++) {
        if (i % 2 != 0 && j == nCol - 1) {
          matrix[i].add(Block.build(0, false, BlockColor.noColor, false));
          continue;
        } else {
          var rand = randomGenerator.nextInt(3);
          matrix[i].add(Block.random(rand));
        }
      }
    }
  }

  BlockGrid.buildGame(BlockGrid origin) {
    matrix = [];
    for (int i = 0; i < origin.nRow; i++) {
      matrix.add([]);
      for (int j = 0; j < origin.nCol; j++) {
        matrix[i].add(Block.build(
          origin.matrix[i][j].value,
          origin.matrix[i][j].isVisible,
          BlockColor.noColor,
          origin.matrix[i][j].isEnabled,
        ));
      }
    }
    nCol = origin.nCol;
    nRow = origin.nRow;
  }

  void changeColor(int i, int j) {
    matrix[i][j].changeColor();
  }

  BlockGrid.fromString(String template, {bool isMenu = false}) {
    List<String> rows = template.split("\n");

    matrix = [[]];
    nRow = 0;
    nCol = rows.length;
    int nElement = 1;
    for (var row in rows) {
      matrix.add([]);
      List<String> elements = row.split(" ");
      for (var block in elements) {
        switch (block) {
          case "-": // missing element
            matrix[nRow].add(Block.build(0, false, BlockColor.noColor, false));
            break;
          case "0": // present with no color by default
            matrix[nRow].add(
                Block.build(nElement++, true, BlockColor.noColor, !isMenu));
            break;
          case "1": // present with color_1 by default
            matrix[nRow]
                .add(Block.build(nElement++, true, BlockColor.color_1, true));
            break;
          case "2": // present with color_2 by default
            matrix[nRow]
                .add(Block.build(nElement++, true, BlockColor.color_2, true));
            break;
        }
      }
      nRow++;
    }
  }
}
