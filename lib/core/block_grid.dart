import 'dart:convert';
import 'dart:math';

import 'package:hexagon_glass/core/block.dart';

class BlockGrid {

  late int nCol, nRow;
  late List<List<Block>> grid;

  BlockGrid() {
      nCol = 0;
      nRow = 0;
      grid = [[]];
  }

  BlockGrid.buildRandom(this.nCol, this.nRow, [int? seed]) {
    var randomGenerator = Random(seed);

    grid = [];
    for(int i = 0; i < nRow; i++) {
      grid.add([]);
      for(int j = 0; j < nCol; j++) {
        var rand = randomGenerator.nextInt(3);
        grid[i].add(Block.random(rand));
      }
    }
  }

  BlockGrid.buildGame(BlockGrid origin) {
    grid = [];
    for(int i = 0; i < origin.nRow; i++){
      grid.add([]);
      for(int j = 0; j < origin.nCol; j++) {
        grid[i].add(
            Block.build(
                origin.grid[i][j].value,
                origin.grid[i][j].isVisible,
                BlockColor.noColor
            )
        );
      }
    }
  }

  void changeColor(int i, int j) {
    grid[i][j].changeColor();
  }

  BlockGrid.fromString(String template) {
    List<String> rows = template.split("\n");

    grid = [[]];
    nRow = 0;
    nCol = rows.length ;
    int nElement = 1;
    for(var row in rows){
      grid.add([]);
      List<String> elements =  row.split(" ");
      for(var block in elements) {
        switch(block) {
          case "-" : // missing element
            grid[nRow].add(Block.build(0, false, BlockColor.noColor));
            break;
          case "0" : // present with no color by default
            grid[nRow].add(Block.build(nElement++, true, BlockColor.noColor));
            break;
          case "1" : // present with color_1 by default
            grid[nRow].add(Block.build(nElement++, true, BlockColor.color_1));
            break;
          case "2": // present with color_2 by default
            grid[nRow].add(Block.build(nElement++, true, BlockColor.color_2));
            break;
        }
      }
      nRow++;
    }

  }
}