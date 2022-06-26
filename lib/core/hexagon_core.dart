import "dart:io";
import 'dart:math';

enum ButtonColor { color_1, color_2, noColor }

class HexagonBlock {
  late int value;
  late bool isVisible;
  late ButtonColor color;

  HexagonBlock() {
    value = 0;
    color = ButtonColor.noColor;
    isVisible = true;
  }

  HexagonBlock.init(ButtonColor startColor, bool visibility) {
    value = 0;
    color = startColor;
    isVisible = visibility;
  }

  HexagonBlock.build(int startValue, bool visibility) {
    value = startValue;
    color = ButtonColor.noColor;
    isVisible = visibility;
  }

  void changeColor() {
    if (color == ButtonColor.noColor) {
      color = ButtonColor.color_1;
    } else if (color == ButtonColor.color_1) {
      color = ButtonColor.color_2;
    } else {
      color = ButtonColor.noColor;
    }
  }

  @override
  String toString() {
    return color == ButtonColor.color_1 ? "1" : "0";
  }
}

class HexagonGame {
  late List<List<HexagonBlock>> gameGrid;
  late List<List<HexagonBlock>> statusGrid;

  int nRows() {
    return gameGrid.length;
  }

  int nColumns() {
    return gameGrid[0].length;
  }

  HexagonGame.create(int width, int height) {
    initGrid(width, height);
    calculateGrid();
  }

  void initGrid(int width, int height) {
    gameGrid = <List<HexagonBlock>>[];
    statusGrid = <List<HexagonBlock>>[];
    for (int i = 0; i < height; i++) {
      gameGrid.add([]);
      statusGrid.add([]);
      for (int j = 0; j < width; j++) {
        var rand = Random().nextInt(3);
        var color = rand != 1
            ? rand == 2
                ? ButtonColor.color_2
                : ButtonColor.noColor
            : ButtonColor.color_1;
        var visibility = color == ButtonColor.noColor ? false : true;
        gameGrid[i].add(HexagonBlock.init(color, visibility));
        statusGrid[i].add(HexagonBlock.init(ButtonColor.noColor, visibility));
      }
    }
  }

  bool checkRange(int i, int j) {
    return i >= 0 && j >= 0 && i < gameGrid.length && j < gameGrid[0].length;
  }

  int calculateAdjValue(int i, int j) {
    int counter = 0;
    int offset = i % 2 == 0 ? 0 : 1;

    ButtonColor currentColor = gameGrid[i][j].color;
    if (currentColor == ButtonColor.noColor) return -1;
    var top = i - 1;
    var bot = i + 1;
    var left = j - 1;
    var right = j + 1;
    // left
    counter +=
        checkRange(i, left) && gameGrid[i][left].color == currentColor ? 1 : 0;
    // right
    counter += checkRange(i, right) && gameGrid[i][right].color == currentColor
        ? 1
        : 0;

    left += offset;
    right = left + 1;
    // top left
    counter +=
        checkRange(top, left) && gameGrid[top][left].color == currentColor
            ? 1
            : 0;
    // top right
    counter +=
        checkRange(top, right) && gameGrid[top][right].color == currentColor
            ? 1
            : 0;

    // bot left
    counter +=
        checkRange(bot, left) && gameGrid[bot][left].color == currentColor
            ? 1
            : 0;
    // bot right
    counter +=
        checkRange(bot, right) && gameGrid[bot][right].color == currentColor
            ? 1
            : 0;

    return counter;
  }

  bool checkIndices(int i, int j, ButtonColor currentColor) {
    return currentColor != ButtonColor.noColor &&
        checkRange(i, j) &&
        gameGrid[i][j].color == currentColor;
  }

  void changeColor(int i, int j) {
    statusGrid[i][j].changeColor();
  }

  void calculateGrid() {
    for (int i = 0; i < gameGrid.length; i++) {
      for (int j = 0; j < gameGrid[i].length; j++) {
        gameGrid[i][j].value = calculateAdjValue(i, j);
        statusGrid[i][j].value = gameGrid[i][j].value;
      }
    }
  }

  void printGrid() {
    //Colors
    for (int i = 0; i < gameGrid.length; i++) {
      if (i % 2 != 0) stdout.write(' ');
      for (int j = 0; j < gameGrid[i].length; j++) {
        stdout.write(gameGrid[i][j].toString() + ' ');
      }
      stdout.write('\n');
    }
    //Values
    stdout.write('\n');
    for (int i = 0; i < gameGrid.length; i++) {
      if (i % 2 != 0) stdout.write(' ');
      for (int j = 0; j < gameGrid[i].length; j++) {
        stdout.write(gameGrid[i][j].value.toString() + ' ');
      }
      stdout.write('\n');
    }
  }
}

void main() {
  HexagonGame grid = HexagonGame.create(10, 11);
  grid.printGrid();
}
