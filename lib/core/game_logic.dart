import 'dart:io';

import 'package:hexagon_glass/core/block.dart';
import 'package:hexagon_glass/core/block_grid.dart';

enum GridType {hexagon, square}

class GameLogic {
  late BlockGrid status;
  late BlockGrid origin;
  late GridType type;

  GameLogic(this.type, int width, int height) {
    origin = BlockGrid.buildRandom(width, height);
    calculateValues();
    initGame();
  }

  int nRows() {
    return origin.grid.length;
  }

  int nColumns() {
    return origin.grid[0].length;
  }

  void resetGame() {
    for (int i = 0; i < origin.grid.length; i++) {
      for (int j = 0; j < origin.grid[i].length; j++) {
        status.grid[i][j].color = BlockColor.noColor;
      }
    }
  }

  void initGame() {
    status = BlockGrid.buildGame(origin);
  }

  void calculateValues() {
    for (int i = 0; i < origin.grid.length; i++) {
      for (int j = 0; j < origin.grid[i].length; j++) {
        origin.grid[i][j].value = calculateAdjValue(i, j);
      }
    }
  }

  int calculateAdjValue(int i, int j) {
    int counter = 0;
    int offset = i % 2 == 0 ? 0 : 1;

    BlockColor currentColor = origin.grid[i][j].color;
    if (!origin.grid[i][j].isVisible) return 0;

    var top = i - 1;
    var bot = i + 1;
    var left = j - 1;
    var right = j + 1;

    // left
    counter +=
    checkRange(i, left) && origin.grid[i][left].color == currentColor ? 1 : 0;
    // right
    counter +=
    checkRange(i, right) && origin.grid[i][right].color == currentColor ? 1 : 0;

    left += offset;
    right = left + 1;
    // top left
    counter +=
    checkRange(top, left) && origin.grid[top][left].color == currentColor
        ? 1
        : 0;
    // top right
    counter +=
    checkRange(top, right) && origin.grid[top][right].color == currentColor
        ? 1
        : 0;

    // bot left
    counter +=
    checkRange(bot, left) && origin.grid[bot][left].color == currentColor
        ? 1
        : 0;
    // bot right
    counter +=
    checkRange(bot, right) && origin.grid[bot][right].color == currentColor
        ? 1
        : 0;
    return counter;
  }

  bool checkRange(int i, int j) {
    return
      i >= 0 &&
      j >= 0 &&
      i < origin.grid.length &&
      j < origin.grid[0].length;
  }

  void printGrid() {
    //Colors
    for (int i = 0; i < origin.grid.length; i++) {
      if (i % 2 != 0) stdout.write(' ');
      for (int j = 0; j < origin.grid[i].length; j++) {
        stdout.write(origin.grid[i][j].toString() + ' ');
      }
      stdout.write('\n');
    }

    //Values
    stdout.write('\n');
    for (int i = 0; i < origin.grid.length; i++) {
      if (i % 2 != 0) stdout.write(' ');
      for (int j = 0; j < origin.grid[i].length; j++) {
        stdout.write(origin.grid[i][j].value.toString() + ' ');
      }
      stdout.write('\n');
    }
  }
}

void main() {
  GameLogic gameLogic = GameLogic(GridType.hexagon, 6, 6);
  gameLogic.printGrid();
}