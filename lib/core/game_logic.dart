import 'dart:io';

import 'package:hexagon_glass/core/block.dart';
import 'package:hexagon_glass/core/block_grid.dart';

enum GridType { hexagon }

class GameLogic {
  late BlockGrid status;
  late BlockGrid origin;
  late GridType type;

  GameLogic(this.type, {int width = 4, int height = 4}) {
    int counter = 0;
    bool isAllConnected = false;
    while (!isAllConnected) {
      origin = BlockGrid.buildRandom(width, height);
      isAllConnected = _allHexesAreConnected(origin.matrix);
    }
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
        if (status.matrix[i][j].color == BlockColor.noColor) return false;

        if (!reversed &&
            status.matrix[i][j].color != origin.matrix[i][j].color) {
          return false;
        }

        if (reversed &&
            status.matrix[i][j].color == origin.matrix[i][j].color) {
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
    counter += checkRange(i, left, origin.matrix) &&
            origin.matrix[i][left].color == currentColor
        ? 1
        : 0;
    // right
    counter += checkRange(i, right, origin.matrix) &&
            origin.matrix[i][right].color == currentColor
        ? 1
        : 0;

    left += offset;
    right = left + 1;
    // top left
    counter += checkRange(top, left, origin.matrix) &&
            origin.matrix[top][left].color == currentColor
        ? 1
        : 0;
    // top right
    counter += checkRange(top, right, origin.matrix) &&
            origin.matrix[top][right].color == currentColor
        ? 1
        : 0;

    // bot left
    counter += checkRange(bot, left, origin.matrix) &&
            origin.matrix[bot][left].color == currentColor
        ? 1
        : 0;
    // bot right
    counter += checkRange(bot, right, origin.matrix) &&
            origin.matrix[bot][right].color == currentColor
        ? 1
        : 0;
    return counter;
  }

  bool checkRange(int i, int j, List<List<dynamic>> matrix) {
    return i >= 0 && j >= 0 && i < matrix.length && j < matrix[0].length;
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

  bool _allHexesAreConnected(List<List<Block>> matrix) {
    bool allConnected = true;
    List<List<int>> checkMatrix = _createCheckMatrix(matrix);

    for (int i = 0; i < checkMatrix.length; i++) {
      for (int j = 0; j < checkMatrix[0].length; j++) {
        if (checkMatrix[i][j] != 0) {
          _startChecking(i, j, checkMatrix);
        }
        break;
      }
      break;
    }

    for (int i = 0; i < checkMatrix.length && allConnected; i++) {
      for (int j = 0; j < checkMatrix[0].length && allConnected; j++) {
        if (checkMatrix[i][j] == 1) allConnected = false;
      }
    }
    return allConnected;
  }

  void _startChecking(int rowsIndex, int colsIndex, List<List<int>> cMatrix) {
    int offset = rowsIndex % 2 == 0 ? 0 : 1;
    int left = colsIndex - 1;
    int right = colsIndex + 1;
    int top = rowsIndex - 1;
    int bot = rowsIndex + 1;

    cMatrix[rowsIndex][colsIndex] = 2;

    if (checkRange(rowsIndex, left, cMatrix) && cMatrix[rowsIndex][left] == 1) {
      _startChecking(rowsIndex, left, cMatrix);
    }
    if (checkRange(rowsIndex, right, cMatrix) &&
        cMatrix[rowsIndex][right] == 1) {
      _startChecking(rowsIndex, right, cMatrix);
    }

    left = left + offset;
    right = left + 1;

    if (checkRange(top, right, cMatrix) && cMatrix[top][right] == 1) {
      _startChecking(top, right, cMatrix);
    }
    if (checkRange(top, left, cMatrix) && cMatrix[top][left] == 1) {
      _startChecking(top, left, cMatrix);
    }
    if (checkRange(bot, right, cMatrix) && cMatrix[bot][right] == 1) {
      _startChecking(bot, right, cMatrix);
    }
    if (checkRange(bot, left, cMatrix) && cMatrix[bot][left] == 1) {
      _startChecking(bot, left, cMatrix);
    }
  }

  List<List<int>> _createCheckMatrix(List<List<Block>> matrix) {
    var checkMatrix = List.generate(
        matrix.length, (index) => List.filled(matrix[0].length, 0));

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[0].length; j++) {
        if (matrix[i][j].isEnabled) {
          checkMatrix[i][j] = 1;
        }
      }
    }
    return checkMatrix;
  }
}

void main() {
  GameLogic gameLogic = GameLogic(GridType.hexagon, width: 5, height: 5);
  gameLogic.printGrid();
}
