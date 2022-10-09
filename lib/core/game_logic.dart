import 'dart:io';

import 'package:hexagon_glass/core/block.dart';
import 'package:hexagon_glass/core/block_grid.dart';

enum GridType { hexagon }

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
    return origin.matrix.length;
  }

  int nColumns() {
    return origin.matrix[0].length;
  }

  void resetGame() {
    for (int i = 0; i < origin.matrix.length; i++) {
      for (int j = 0; j < origin.matrix[i].length; j++) {
        status.matrix[i][j].color = BlockColor.noColor;
      }
    }
  }

  bool checkGame() {
    bool reversed = _isReversed();

    for (int i = 0; i < origin.matrix.length; i++) {
      for (int j = 0; j < origin.matrix[i].length; j++) {
        if (!origin.matrix[i][j].isVisible) continue;

        if (status.matrix[i][j].color != origin.matrix[i][j].color &&
            !reversed) {
          return false;
        }

        if (status.matrix[i][j].color == origin.matrix[i][j].color &&
            reversed) {
          return false;
        }
      }
    }

    return true;
  }

  bool _isReversed() {
    for (int i = 0; i < origin.matrix.length; i++) {
      for (int j = 0; j < origin.matrix[i].length; j++) {
        if (origin.matrix[i][j].isVisible == true) {
          return origin.matrix[i][j].color != status.matrix[i][j].color;
        }
      }
    }
    return false;
  }

  void initGame() {
    status = BlockGrid.buildGame(origin);
  }

  void calculateValues() {
    for (int i = 0; i < origin.matrix.length; i++) {
      for (int j = 0; j < origin.matrix[i].length; j++) {
        origin.matrix[i][j].value = calculateAdjValue(i, j);
      }
    }
  }

  int calculateAdjValue(int i, int j) {
    int counter = 0;
    int offset = i % 2 == 0 ? 0 : 1;

    BlockColor currentColor = origin.matrix[i][j].color;
    if (!origin.matrix[i][j].isVisible) return 0;

    var top = i - 1;
    var bot = i + 1;
    var left = j - 1;
    var right = j + 1;

    // left
    counter +=
        checkRange(i, left) && origin.matrix[i][left].color == currentColor
            ? 1
            : 0;
    // right
    counter +=
        checkRange(i, right) && origin.matrix[i][right].color == currentColor
            ? 1
            : 0;

    left += offset;
    right = left + 1;
    // top left
    counter +=
        checkRange(top, left) && origin.matrix[top][left].color == currentColor
            ? 1
            : 0;
    // top right
    counter += checkRange(top, right) &&
            origin.matrix[top][right].color == currentColor
        ? 1
        : 0;

    // bot left
    counter +=
        checkRange(bot, left) && origin.matrix[bot][left].color == currentColor
            ? 1
            : 0;
    // bot right
    counter += checkRange(bot, right) &&
            origin.matrix[bot][right].color == currentColor
        ? 1
        : 0;
    return counter;
  }

  bool checkRange(int i, int j) {
    return i >= 0 &&
        j >= 0 &&
        i < origin.matrix.length &&
        j < origin.matrix[0].length;
  }

  void printGrid() {
    //Colors
    for (int i = 0; i < origin.matrix.length; i++) {
      if (i % 2 != 0) stdout.write(' ');
      for (int j = 0; j < origin.matrix[i].length; j++) {
        stdout.write(origin.matrix[i][j].toString() + ' ');
      }
      stdout.write('\n');
    }

    //Values
    stdout.write('\n');
    for (int i = 0; i < origin.matrix.length; i++) {
      if (i % 2 != 0) stdout.write(' ');
      for (int j = 0; j < origin.matrix[i].length; j++) {
        stdout.write(origin.matrix[i][j].value.toString() + ' ');
      }
      stdout.write('\n');
    }
  }
}

void main() {
  GameLogic gameLogic = GameLogic(GridType.hexagon, 6, 6);
  gameLogic.printGrid();
}
